
-- importando bibliotecas
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_arith.all;
use IEEE.STD_LOGIC_unsigned.all;

-- criando a ALU
entity ALU_VHDL is
   port
   (  Operation : in std_logic_vector(2 downto 0);
      Result, Flag : out std_logic_vector(3 downto 0);
		clock_50,reset : in std_logic);
end entity ALU_VHDL;
 
architecture Behavioral of ALU_VHDL is

-- Importando somador de 4 bits, criado em outro arquivo
    component adder_4b is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           ci : in  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR (3 downto 0);
           co : out  STD_LOGIC);
end component;

-- Importando subtrator de 4 bits, criado em outro arquivo
    component subtractor_4b is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           ci : in  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR (3 downto 0);
           co : out  STD_LOGIC);
end component;

-- Importando incrementador de 1, criado em outro arquivo
    component increment_one is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           ci : in  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR (3 downto 0);
           co : out  STD_LOGIC);
end component;

-- Importando componente de mudança de sinal, criado em outro arquivo
   component change_signal is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           ci : in  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR (3 downto 0);
           co : out  STD_LOGIC);
end component;

component contador is
    Port ( clock_50 : in std_logic;
				CONTADOR_out : out std_logic_vector (7 downto 0));
end component;

   signal e, f: std_logic_vector(3 downto 0);
-- criando as variáveis de resultado 

-- resultados em forma de número de 4 bits
   signal res_or, res_xor, res_soma, res_sub, res_mais1, res_mudsinal, res_mult: std_logic_vector(3 downto 0); 
   
-- resultados de apenas 1 bit
   signal carry_sum, carry_sub, carry_mais, carry_mud, carry_mult: std_logic;
	
	signal contador_out: std_logic_vector(7 downto 0);

begin

-- realizando as operações
	 cont : CONTADOR port map(clock_50, CONTADOR_out);
	 
	 CONTADOR_loop:
	 for i in 0 to 3 generate 
		e(i) <= CONTADOR_out(i);
		f(i) <= CONTADOR_out(i + 4);
	 end generate CONTADOR_loop;
	
    soma : adder_4b port map(e, f, '0', res_soma, carry_sum); 
    sub : subtractor_4b port map(e, f, '0', res_sub, carry_sub);
    mais1 : increment_one port map (e, f, '0', res_mais1, carry_mais);
    mudsinal : change_signal port map (e, f, '0', res_mudsinal, carry_mud);
    mult : adder_4b port map (e, e, '0', res_mult, carry_mult);
    
	 
    
-- Selecionando as operações 
   process(e, f, Operation) is
   begin
	
      Flag <= "0000";   -- Operação de soma
      case Operation is
 	   when "000" => 
 	         Result <= res_soma;
 	         flag(0)  <= carry_sum;
			   flag(1)  <= carry_sum;
			   if (res_soma = "0000") then
				Flag(2) <= '1';
				end if;
							  
      when "001" =>  -- Operação de multiplicação por 2
            Result <= res_mult;
 	         flag(0)  <= carry_mult;
			   flag(1)  <= carry_mult;
				if (res_mult = "0000") then
				Flag(2) <= '1';
				end if;
				  
 	   when "010" =>  -- Operação de subtração
            Result <= res_sub; 
 	         flag(0)  <= carry_sub;
				if (res_sub = "0000") then
				Flag(2) <= '1';
				end if;
				if (f > e) then
				Flag(3) <= '1';
				end if;

 	   when "011" =>  -- Operação de incremento de 1
            Result <= res_mais1;
 	         flag(0)  <= carry_mais;
			   flag(1)  <= carry_mais;
				if (res_mais1 = "0000") then
				Flag(2) <= '1';
				end if;

				
 	   when "100" =>  -- Operação de mudança de sinal
            Result <= res_mudsinal;
 	         flag(0)  <= carry_mud;
			   flag(1)  <= carry_mud;
				flag(3)  <= '1';
				if (res_mudsinal = "0000") then
				flag(3)  <= '0';
				Flag(2) <= '1';
				end if;

 	        
 	   when "101" =>   -- Operação de comparação
				if (e = f) then
				Result <= "0100";
				end if;
				if (e < f) then
				Result <= "0010";
				end if;
				if (e > f) then
				Result <= "0001";
				end if;
				if (e = "0000" and f = "0000") then
				Flag(2) <= '1';
				end if;

           
  	   when "110" =>  -- Operação de incremento de XOR
  	        res_xor <= e XOR f;
			  Result <= res_xor;
			  if (res_xor = "0000") then
				Flag(2) <= '1';
				end if;

            
 	   when others => -- Operação de incremento de OR
			  res_or <= e OR f;
			  Result <= res_or;
			  if (res_or = "0000") then
				Flag(2) <= '1';
				end if;

	
      end case;
   end process;

end architecture Behavioral;