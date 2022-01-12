LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Implementação de um módulo aritmético em VHDL
-- Possuí duas entradas de 4 bits cada, além de uma
-- entrada de seleção de operação, com 2 bits
-- Suas saídas são os flags CARRY_OUT e OVERFLOW, além
-- da saída R, que é o vetor do resultado das operações

ENTITY modulo1 IS
  PORT (
  
    A0, A1, A2, A3      : IN  std_logic;                    
    B0, B1, B2, B3      : IN  std_logic;
    R0, R1, R2, R3      : OUT  std_logic;
    S0, S1              : IN  std_logic;                    
    CARRY_OUT           : OUT std_logic;
    OVERFLOW            : OUT std_logic
    );
    
END modulo1;

ARCHITECTURE TypeArchitecture OF modulo1 IS

-- Sinais para facilitação da implementação
SIGNAL A, B, W, X, Y, Z, C1, C2, C3 : std_logic;

-- Criação dos componentes necessários para a realização do projeto
COMPONENT MUX4_1 IS
  PORT (

    A, B, C, D : IN  std_logic;
    SEL0        : IN  std_logic;
    SEL1        : IN std_logic;
    S          : OUT std_logic                    
    );
END COMPONENT MUX4_1;


COMPONENT full_adder IS
  PORT (
  
    A, B            : IN  std_logic;                    
    CARRY_IN        : IN  std_logic;
    SUM             : OUT std_logic;                    
    CARRY           : OUT std_logic 
    );
END COMPONENT full_adder;


BEGIN

-- Se S1 AND S2 for alto, nulifica a entrada A, a razão
-- disso será vista em breve
A <= (S1 NAND S0);

-- O flag de overflow é alto quando o carry_out e o
-- carry_in do MSB forem diferentes
OVERFLOW <= (C3 XOR B);

CARRY_OUT <= B;

-- As operaçõs realizadas são:
-- SEL = 00 -> Soma
-- SEL = 01 -> Subtração
-- SEL = 10 -> Incremento de 1
-- SEL = 11 -> Complemento de 2
-- As duas últimas são realizadas em A

-- Essencialmente, o módulo realiza uma operação de soma entre o vetor
-- de entrada A e outro vetor (W X Y Z), e o valor desse é definido
-- por estes MUXs. Se SEL = (00), ele é igual à B, se (01), igual a não
-- B, se (10), igual a 0001 e se (11), igual a não A

-- Para a última operação ser implementada corretamente, o vetor A precisa
-- ser nulificado, em outras palavras, ele precisa se tornar "0000"
mux1 : MUX4_1 PORT MAP(

A => B3,
B => (NOT B3),
C => '0',
D => (NOT A3),
SEL0 => S0,
SEL1 => S1,
S => W);

mux2 : MUX4_1 PORT MAP(

A => B2,
B => (NOT B2),
C => '0',
D => (NOT A2),
SEL0 => S0,
SEL1 => S1,
S => X);

mux3 : MUX4_1 PORT MAP(

A => B1,
B => (NOT B1),
C => '0',
D => (NOT A1),
SEL0 => S0,
SEL1 => S1,
S => Y);

mux4 : MUX4_1 PORT MAP(

A => B0,
B => (NOT B0),
C => '1',
D => (NOT A0),
SEL0 => S0,
SEL1 => S1,
S => Z);

-- Por fim, tendo escolhido o vetor (W X Y Z), o módulo realiza a soma completa entre
-- esse vetor e o vetor A, retornando a saída R
fa1 : full_adder PORT MAP(

A => (A3 AND A),
B => W,
CARRY_IN => C3,
SUM => R3,
CARRY => B);

fa2 : full_adder PORT MAP(

A => (A2 AND A),
B => X,
CARRY_IN => C2,
SUM => R2,
CARRY => C3);

fa3 : full_adder PORT MAP(

A => (A1 AND A),
B => Y,
CARRY_IN => C1,
SUM => R1,
CARRY => C2);

fa4 : full_adder PORT MAP(

A => (A0 AND A),
B => Z,
CARRY_IN => S0,
SUM => R0,
CARRY => C1);


END TypeArchitecture;
