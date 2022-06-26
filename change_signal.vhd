----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:53:09 06/02/2022 
-- Design Name: 
-- Module Name:    change_signal - Behavioral 
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


-- criando um trocador de sinais com um 4 bits de saída 
entity change_signal is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           ci : in  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR (3 downto 0);
           co : out  STD_LOGIC);
end change_signal;

architecture Behavioral of change_signal is

component full_adder is
	port	( A,B,ci : in STD_LOGIC;
				Y, CO : out STD_LOGIC);
end component;

-- Variável auxiliar para passagem de carries
signal c : STD_LOGIC_VECTOR (2 downto 0);

begin

-- Utilizando 4 full-adder de 1 bit para construir 1 trocador de sinais com 4 bits de saída,
-- apenas permitindo a entrada 'a' negada e somando o valor '1' à operação.
u1: full_adder port map (not A(0), '0', '1', Y(0), C(0));
u2: full_adder port map (not A(1), '0', C(0), Y(1), C(1));
u3: full_adder port map (not A(2), '0', C(1), Y(2), C(2));
u4: full_adder port map (not A(3), '0', C(2), Y(3), CO);

end Behavioral;


