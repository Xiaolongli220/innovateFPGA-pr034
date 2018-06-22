LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity divider2 is
port(
clk:in std_logic;


CLKout : OUT std_logic

);
end divider2;
architecture count200_1 of divider2 is
signal cnt:std_logic:='0'; 
begin
process(clk)
begin
if clk 'event and clk ='1' then
  
cnt<=not cnt;
	

end if;
end process;
CLKout<=cnt; 
end count200_1;