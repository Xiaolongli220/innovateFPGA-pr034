LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity divider10 is
port(
clk:in std_logic;


CLKout : OUT std_logic

);
end divider10;
architecture count200_1 of divider10 is
signal cnt:std_logic_vector(3 downto 0):="0000"; 
begin
process(clk)
begin
if clk 'event and clk ='1' then

     if cnt<"1001" then
			if cnt<"0101" then
				CLKout <= '0';
				else 
				CLKout <= '1';
				end if;
        cnt<=cnt+'1';
	     
	  else 
	     cnt<="0000";
	     
		  end if;

	

end if;
end process;

end count200_1;