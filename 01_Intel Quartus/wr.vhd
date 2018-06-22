LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity wr is
port(
wready:in std_logic;
rready:in std_logic;
rden:out std_logic;
wren:out std_logic;
o:out std_logic
);
end wr;
architecture wr_1 of wr is
signal state:std_logic_vector(1 downto 0):="00";
signal ready:std_logic;
begin
ready<=wready or rready;
process(ready)
begin

if ready 'event and ready = '1' then
       if state<"10" then
		 state<= state+'1';
		 else state<="00";
		 end if;
		 else state<=state;
	end if;
end process;

process(state)
begin
case state is
 when "00"=> 
   o<='0';rden<='0';wren<='1';
    
 when "01" =>
   o<='1';rden<='1';wren<='0';
 
 when "10" =>
   o<='1';rden<='0';wren<='0';
	 
when others=>null;
end case;
end process;
end wr_1;