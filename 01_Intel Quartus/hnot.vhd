LIBRARY IEEE;      
USE IEEE.STD_LOGIC_1164.ALL; 
ENTITY hnot IS   
PORT(
a : IN STD_LOGIC;              
y: OUT STD_LOGIC
);  
END hnot;   
ARCHITECTURE one OF hnot IS BEGIN      
 y<= not a; 
END one;