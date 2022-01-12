LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Implementação de um full_adder em VHDL

ENTITY full_adder IS
  PORT (
  
    A, B            : IN  std_logic;                    
    CARRY_IN        : IN  std_logic;
    SUM             : OUT std_logic;                    
    CARRY           : OUT std_logic 
    );
END full_adder;

ARCHITECTURE TypeArchitecture OF full_adder IS
-- Sinais temporários para auxiliar nas operações
SIGNAL X, Y, Z : std_logic;

-- Criação do componente de meia soma
COMPONENT half_adder IS
  PORT (
 
    A, B        : IN  std_logic;                    
    SUM         : OUT  std_logic;
    CARRY       : OUT std_logic                   
    );
END COMPONENT half_adder;

BEGIN

-- Um carry só será gerado por uma soma completa se houver carry
-- ou na soma entre os dois vetores de entrada, A e B, ou se hou
-- ver carry na soma (A+B) + carry_in
CARRY <= Z OR Y;

ha1: half_adder PORT MAP(

A       => A,
B       => B,
SUM     => X,
CARRY   => Y
);

ha2: half_adder PORT MAP(

A => X,
B => CARRY_IN,
SUM => SUM,
CARRY => Z
);


END TypeArchitecture;
