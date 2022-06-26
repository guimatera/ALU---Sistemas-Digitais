----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:19:15 05/26/2022 
-- Design Name: 
-- Module Name:    full_adder - Behavioral 
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
-- Importando bibliotecas
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- criando full adder com um bit de saída 
entity full_adder is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           CI : in  STD_LOGIC;
           Y : out  STD_LOGIC;
           CO : out  STD_LOGIC);
end full_adder;

architecture Behavioral of full_adder is

begin
-- Lógica para a saída do full-adder
Y  <= A xor B xor CI;
-- Lógica para o carry-out do full-adder
CO <= (A and B) or (A and CI) or (B and CI);

end Behavioral;

