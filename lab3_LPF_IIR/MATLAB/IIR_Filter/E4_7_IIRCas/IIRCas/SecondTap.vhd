----------------------------------------------------------------------------------
-- Company:        http://duyongcn.blog.163.com/
-- Engineer:       duyongcn@sina.cn 
-- 
-- Create Date:    12/06/2016 
-- Design Name:    cameion
-- module Name:    SecondTap - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;--�з���������

---- Uncomment the following library declaration if instantiating
---- any xilinx primitives in this code.
--library UNISIm;
--use UNISIm.VComponents.all;

entity SecondTap is
    Port ( rst  : in  std_logic;  --��λ�źţ��ߵ�ƽ��Ч
           clk  : in  std_logic;  --FPGAϵͳʱ�ӣ�������������ͬ
           xin  : in  std_logic_vector (11 downto 0);   --�ڶ����˲�����������
           yout : out std_logic_vector (11 downto 0));  --�ڶ����˲����������
end SecondTap;

architecture Behavioral of SecondTap is

	--����2��12��1��13�����źţ��洢��ʱ����������xin
   signal xin_1,xin_2: std_logic_vector (11 downto 0);
	--����1��13�����źţ��洢���жԳ�ϵ������������֮��
   signal xin_02: std_logic_vector (12 downto 0);
	--����3��24�����źţ��洢ϵ��������������˼��˼Ӻ������
   signal xmult_02,xmult_1,xout: std_logic_vector (23 downto 0);
	
	--����3��12�����źţ��洢��������뼰��ʱ����
   signal yin,yin_1,yin_2: std_logic_vector (11 downto 0);
	--����λ��Ϊ24���ص���ֵ���������ڷ���λ��չ
	constant zeros:std_logic_vector(23 downto 0):=(others=>'0');
	--������ֵΪ11�ĳ�����������λ����
	constant eleven: std_logic_vector(4 downto 0):="01011";
	--����������õ����м��ź�
   signal ymult_1,ymult_2,ysum,ydiv: std_logic_vector (23 downto 0);
	
	
begin

   ----------------------------------
	--���ϵ����ʵ�ִ���
	--���������ݴ�����λ�Ĵ�����
	Pxin: process(rst,clk)
	begin
		if rst='1' then 
         xin_1<=(others=>'0');
         xin_2<=(others=>'0');
		elsif rising_edge(clk) then
         xin_1<=xin;
         xin_2<=xin_1;
		end if;
	end process Pxin;
	xin_02 <= xin(11)&xin+xin_2;
	
   --������λ���㼰�ӷ��������˷�����
   xmult_02<=zeros+(xin_02&"00000000000");                          --*2048
   xmult_1<=zeros+(xin_1&"00000000")+(xin_1&"000000")+(xin_1&"00"); --*324

	--���˲���ϵ�����������ݵĳ˷���������ۼӣ�������˲��������
	xout<=xmult_02+xmult_1;

   ---------------------------------------
	--����ϵ����ʵ�ִ���
	--���������ݴ�����λ�Ĵ�����
   Pyin: process(rst,clk)
	begin
		if rst='1' then 
		   yin_1<=(others=>'0');
		   yin_2<=(others=>'0');
		elsif rising_edge(clk) then
		   yin_1<=yin;
			yin_2<=yin_1;
		end if;
	end process Pyin;
	
   --������λ���㼰�ӷ��������˷�����
	ymult_1<=zeros+(yin_1&"00000000000")-(yin_1&"0000000")-(yin_1&"000")
	         -(yin_1&"00")-yin_1;                                        --*1907
	ymult_2<=zeros+(yin_2&"0000000000")+(yin_2&"0000000")+(yin_2&"0000")--*1171
	         +(yin_1&"0")+yin_1;
				
	----------------------------------------
	--���㼫��ϵ��ʵ�ֽṹ��ϳ�������IIR�˲���
	ysum<=xout-ymult_2+ymult_1;
   ydiv <= shr(ysum,eleven);
	
	--�������λ��������������ͬ����Ϊ12����
	yin <= ydiv(11 downto 0) when rst='0' else (others=>'0');
	
	--����һ���Ĵ�������������ٶ�
	process 
	begin
	wait until rising_edge(clk);
		yout <= yin;
	end process;

end Behavioral;

