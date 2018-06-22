LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity count200 is
port(
clk:in std_logic;
count:out std_logic_vector(9 downto 0);
clr : IN STD_LOGIC;
co:out std_logic
);
end count200;
architecture count200_1 of count200 is
signal cnt:std_logic_vector(9 downto 0):="0000000000"; 
begin
process(clk,clr)
begin
if clk 'event and clk ='1' then
if clr='0' then
     if cnt<"1111100111" then
        cnt<=cnt+'1';
	     co<='0';
	  else 
	     cnt<="0000000000";
	     co<='1';
		  end if;
else 
  cnt<="0000000000";co<='0';
	
end if;
end if;
end process;
count<=cnt;
end count200_1;