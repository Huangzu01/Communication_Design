----------------------------------------------------------------------------------
-- Company:        http://duyongcn.blog.163.com/
-- Engineer:       duyongcn@sina.cn 
-- 
-- Create Date:    19:01:43 10/05/2016 
-- Design Name:    cameion
-- Module Name:    tstdata_produce - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tstdata_produce is
    Port ( clk_32m  :  in   std_logic;
	        data_add :  out  std_logic_vector (7 downto 0);  --�����Ĳ����ź�����������ź�
	        data_sin :  out  std_logic_vector (7 downto 0)); --�����Ĳ����ź������200kHz���Ҳ� 
end tstdata_produce;

architecture Behavioral of tstdata_produce is

   --DDS��,����ʱ��Ƶ��Ϊ32MHz,���2.1MHz���Ҳ�
	component data2m1
   port (
      clk : in   std_logic;
      sine : out std_logic_vector(7 DOWNTO 0));
	end component;
	
	component data200k
   port (
      clk : in   std_logic;
      sine : out std_logic_vector(7 DOWNTO 0));
	end component;
	
   signal data_2m1 : std_logic_vector(7 downto 0);
   signal data_200k : std_logic_vector(7 downto 0);
	signal dataadd  : std_logic_vector(8 downto 0);
	
begin

   u1: data2m1
   port map (
      clk  => clk_32m,
      sine => data_2m1);
		
   u2: data200k
   port map (
      clk  => clk_32m,
      sine => data_200k);

   dataadd <= data_2m1(7)&data_2m1 + data_200k;
   --����������ת��Ϊ��������ʽ��DAת����	
   data_add <= (dataadd(8 downto 1)-128) when  dataadd(8)='1'  else (dataadd(8 downto 1)+128);
   data_sin <= (data_200k-128) when  data_200k(7)='1'  else (data_200k+128);
	

end Behavioral;

