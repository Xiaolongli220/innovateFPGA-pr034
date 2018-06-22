LIBRARY IEEE;      
USE IEEE.STD_LOGIC_1164.ALL; 
ENTITY choose IS   
PORT(
switch:in std_logic_vector(1 downto 0);
signal1:in std_logic_vector(15 downto 0);
signal2:in std_logic_vector(15 downto 0);
signal3:in std_logic_vector(15 downto 0);
signal4:in std_logic_vector(15 downto 0);
outsignal1:out std_logic_vector(15 downto 0)
);
end;
architecture ss of choose is
begin
process(switch)
begin
case switch is
 when "00"=>
    outsignal1<=signal1;
 when "01"=>
    outsignal1<=signal2;
 when "10"=>
    outsignal1<=signal3;
 when "11"=>
    outsignal1<=signal4;
	 end case;
	 end process;
	 end ss;