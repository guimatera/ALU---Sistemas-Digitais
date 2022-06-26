----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:34:23 05/26/2022 
-- Design Name: 
-- Module Name:    adder_4b - Behavioral 
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

-- criando full adder com um 4 bits de saída 
entity adder_4b is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           ci : in  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR (3 downto 0);
           co : out  STD_LOGIC);
end adder_4b;


architecture Behavioral of adder_4b is

-- Importando componente full_adder com 1 bit de saída
component full_adder is
	port	( A,B, ci : in STD_LOGIC;
				Y, CO : out STD_LOGIC);
end component;

-- Variável auxiliar para passagem de carries
signal C : STD_LOGIC_VECTOR (2 downto 0);

begin
-- Utilizando 4 full-adder de 1 bit para construir 1 full-adder com 4 bits de saída
u1: full_adder port map (A(0), B(0), ci, Y(0), C(0));
u2: full_adder port map (A(1), B(1), C(0), Y(1), C(1));
u3: full_adder port map (A(2), B(2), C(1), Y(2), C(2));
u4: full_adder port map (A(3), B(3), C(2), Y(3), CO);

end Behavioral; 

