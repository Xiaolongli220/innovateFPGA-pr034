LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity divider22 is
port(
clk:in std_logic;


CLKout : OUT std_logic

);
end divider22;
architecture count200_1 of divider22 is
signal cnt:std_logic_vector(5 downto 0):="000000"; 
begin
process(clk)
begin
if clk 'event and clk ='1' then

     if cnt<"100101" then
			if cnt<"010011" then
				CLKout <= '0';
				else 
				CLKout <= '1';
				end if;
        cnt<=cnt+'1';
	     
	  else 
	     cnt<="000000";
	     
		  end if;

	

end if;
end process;

end count200_1;