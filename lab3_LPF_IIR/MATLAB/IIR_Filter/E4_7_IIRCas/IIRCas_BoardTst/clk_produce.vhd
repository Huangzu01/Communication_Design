----------------------------------------------------------------------------------
-- Company:        http://duyongcn.blog.163.com/
-- Engineer:       duyongcn@sina.cn
-- 
-- Create Date:    13:13:24 09/11/2016 
-- Design Name:    cameion
-- Module Name:    clk_produce - Behavioral 
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
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_SIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_produce is
    Port ( reset        : in   std_logic;   --��λ�źţ��ߵ�ƽ��Ч
           gclk1        : in   std_logic;   --����ʱ�ӣ�50MHz
			  gclk2        : in   std_logic;   --����ʱ�ӣ�50MHz
           clk_da1_32m  : out  std_logic;   --���DA1ʱ��,32MHz 				gclk1��������
           clk_32m      : out  std_logic;   --������մ���ϵͳʱ��,32MHz		gclk2��������
			  clk_8m       : out  std_logic;   --���DA2ʱ�ӣ�8MHz				gclk2��������
           rst          : out  std_logic);  --���ϵͳ��λ�źţ��ߵ�ƽ��Ч	gclk2��������
end clk_produce;

architecture Behavioral of clk_produce is
	 
    --ʱ�ӹ���IP��
    component clock
    port (
      reset     : in   std_logic;
      clk_in1   : in   std_logic;
      clk_out1  : out  std_logic;
      locked    : out  std_logic);
    end component;

    signal locked    : std_logic;
    signal clk32m    : std_logic;
    signal clk8m     : std_logic;
    signal cn        : std_logic_vector(1 downto 0);
begin
    
	 clk_32m <= clk32m;
    clk_8m <= clk8m; 
	  
    --ʵ����ʱ�ӹ���IP�ˣ�����32MHzʱ���ź�,��ΪDA1������ʱ��
    u1: clock
    port map (
        clk_in1  => gclk1,
        clk_out1 => clk_da1_32m, 
        reset    => reset);  
		  
    --locked�ź��ϵ��λʱΪ�͵�ƽ������ȶ���Ϊ�ߵ�ƽ��ȡ������Ϊϵͳ��λ�ź�
    rst <= not locked;
    u2: clock
    port map (
        clk_in1  => gclk2,
        clk_out1 => clk32m, 
        reset    => reset,       
        locked   => locked);  
	  
	 --��clk32m����4��Ƶ�����clk32m�ź�
    process(locked,clk32m)
    begin
       if locked='0' then 
			 clk8m <= '0';
			 cn <= "00";
       elsif rising_edge(clk32m) then
		    cn <= cn + 1;
		    clk8m <= cn(1);
       end if;
    end process;
	 
end Behavioral;
