LIBRARY IEEE;      
USE IEEE.STD_LOGIC_1164.ALL; 
ENTITY micchoose IS   
PORT(
rdens:in std_logic_vector(1 downto 0);
signal1_1:in std_logic_vector(15 downto 0);
signal2_1:in std_logic_vector(15 downto 0);
signal3_1:in std_logic_vector(15 downto 0);
signal4_1:in std_logic_vector(15 downto 0);
signal1_2:in std_logic_vector(15 downto 0);
signal2_2:in std_logic_vector(15 downto 0);
signal3_2:in std_logic_vector(15 downto 0);
signal4_2:in std_logic_vector(15 downto 0);
signal1:out std_logic_vector(15 downto 0);
signal2:out std_logic_vector(15 downto 0);
signal3:out std_logic_vector(15 downto 0);
signal4:out std_logic_vector(15 downto 0);
rdaddr_1:in std_logic_vector(9 downto 0);
rdaddr_2:in std_logic_vector(9 downto 0);
rdaddr:out std_logic_vector(9 downto 0)
);
end;
architecture ss of micchoose is
begin
process(rdens)
begin
case rdens is
 when "10"=>
    signal1<=signal1_1;
	 signal2<=signal2_1;
	 signal3<=signal3_1;
	 signal4<=signal4_1;
	 rdaddr<=rdaddr_1;
 when "01"=>
    signal1<=signal1_2;
	 signal2<=signal2_2;
	 signal3<=signal3_2;
	 signal4<=signal4_2;
	 rdaddr<=rdaddr_2;
	 when others=>signal1<="0000000000000000";
	 signal2<="0000000000000000";
	 signal3<="0000000000000000";
	 signal4<="0000000000000000";
	 rdaddr<="0000000000";
	 end case;
	 end process;
	 end ss;