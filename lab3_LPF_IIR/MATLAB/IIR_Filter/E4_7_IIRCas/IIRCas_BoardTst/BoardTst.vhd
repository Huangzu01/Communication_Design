----------------------------------------------------------------------------------
-- Company:        http://duyongcn.blog.163.com/
-- Engineer:       duyongcn@sina.cn 
-- 
-- Create Date:    13:14:44 09/12/2016 
-- Design Name:    cameion
-- Module Name:    BoardTst - Behavioral 
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
use IEEE.STD_LOGIC_SIGNED.ALL;   --�����з���������

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.Vcomponents.all;

entity BoardTst is
    Port ( --2·ϵͳʱ�Ӽ�1·��λ�ź�
	        gclk1    : in   std_logic;                           --ϵͳʱ��1���룺50MHz���������������ź�����DAʱ��
           gclk2    : in   std_logic;                           --ϵͳʱ��2���룺50MHz�����մ���ϵͳʱ��
           reset    : in   std_logic;                           --��λ�ź����룺�ߵ�ƽ��Ч
			  
			  --AD�����źſ��ƿ���
			  key1     : in   std_logic;                           --����ʱ��AD�����룻δ����ʱAD��DA1����
			  
			  --2·DAͨ��
			  --�����õĵ�Ƶ�ź�DA���ݼ�ʱ��
           da1_clk  : out  std_logic;                           --DA1ʱ�������32MHz
           da1_out  : out  std_logic_vector (7 downto 0);       --DA1�ź������ͨ����·�������뵽ADͨ��
			  --����ͬ������ز��ź�DA���ݼ�ʱ��
           da2_clk  : out  std_logic;                           --DA2ʱ�������8MHz
           da2_out  : out  std_logic_vector (7 downto 0);       --DA2�ź����

			  --1·ADͨ��
			  ad_clk   : out  std_logic;                           --AD����ʱ��:8MHz
			  ad_din   : in   std_logic_vector (7 downto 0));      --AD�����ź�����,��DA1ͨ����·������
end BoardTst;


 architecture Behavioral of BoardTst is
   
	--ʱ�Ӳ���ģ��
	component clk_produce
	port(
		reset : in std_logic;
		gclk1 : in std_logic;
		gclk2 : in std_logic;          
		clk_da1_32m : out std_logic;
		clk_32m : out std_logic;
		clk_8m  : out std_logic;
		rst : out std_logic);
	end component;
   
	--������������ģ��
	component tstdata_produce
	port(
		clk_32m : in std_logic; 
		data_sin : out std_logic_vector(7 downto 0);
      data_add : out std_logic_vector(7 downto 0));		
	end component;
   
	--�˲���ͬ��ģ��
	component IIRCas
	port(
	   rst : in std_logic;
		clk : in std_logic;
		xin : in std_logic_vector(11 downto 0);          
		yout : out std_logic_vector(11 downto 0));
	end component;

	signal clk_da1_32m  : std_logic;
	signal clk_8m       : std_logic;
	signal rst          : std_logic;
	
	signal din_ad       : std_logic_vector(11 downto 0);
	signal ad_data      : std_logic_vector(7 downto 0);
	signal data_sin     : std_logic_vector(7 downto 0);
   signal data_add     : std_logic_vector(7 downto 0);
   signal dout         : std_logic_vector(11 downto 0);
	
begin
   
	da1_clk <= clk_da1_32m;
   da1_out <= data_sin  when key1='0' else data_add;
	
   da2_clk <= clk_8m;
	
    --����������ת��Ϊ��������ʽ��DAת����
   da2_out  <= (dout(11 downto 4)-128)  when dout(11)='1' else (dout(11 downto 4)+128);
	
   ad_clk  <= clk_8m;
	
	din_ad <= ad_data&"0000";
	
 	--��AD������������ת���ɶ����Ʋ�����ʽ
	process(rst,clk_8m)
	begin
	   if rst='1' then
		   ad_data <= (others=>'0');
		elsif rising_edge(clk_8m) then
		   ad_data <= ad_din-128;
		end if;
	end process;
	
	u1: clk_produce port map(
		 reset => reset,
		 gclk1 => gclk1,
		 gclk2 => gclk2,
		 clk_da1_32m => clk_da1_32m,
		 --clk_32m => clk_32m,
		 clk_8m => clk_8m,
		 rst => rst);

	u2: tstdata_produce port map(
		 clk_32m  => clk_da1_32m, 
       data_add => data_add,		 
		 data_sin  => data_sin);
		
	u3: IIRCas port map(
	    rst => rst,
		 clk => clk_8m,
		 xin => din_ad,
		 yout => dout);

		
end Behavioral;

