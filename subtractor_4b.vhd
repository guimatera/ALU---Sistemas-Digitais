----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:57:59 06/02/2022 
-- Design Name: 
-- Module Name:    subtractor_4b - Behavioral 
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

-- criando subtrator com um 4 bits de saída 
entity subtractor_4b is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           ci : in  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR (3 downto 0);
           co : out  STD_LOGIC);
end subtractor_4b;

architecture Behavioral of subtractor_4b is
-- Importando componente full_adder com 1 bit de saída
component full_adder is
	port	( A,B, ci : in STD_LOGIC;
				Y, CO : out STD_LOGIC);
end component;

-- Variável auxiliar para passagem de carries
signal c : STD_LOGIC_VECTOR (2 downto 0);

begin
-- Utilizando 4 full-adder de 1 bit para construir 1 subtrator com 4 bits de saída,
-- apenas negando a entrada 'b' e somando o valor '1' à operação (complemento de 2).
u1: full_adder port map (A(0), not B(0), '1', Y(0), C(0));
u2: full_adder port map (A(1), not B(1), C(0), Y(1), C(1));
u3: full_adder port map (A(2), not B(2), C(1), Y(2), C(2));
u4: full_adder port map (A(3), not B(3), C(2), Y(3), CO);

end Behavioral; 

