LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY alu IS
  -- A ALU leva 2 entradas A e B de 4 bits cada, além da entrada SEL, de seleção, com 3 bits
  -- Além disso, há também os flags, cada um de 1 bit
  PORT (
    A0, A1, A2, A3     : IN  std_logic;   
    B0, B1, B2, B3     : IN  std_logic;   
    SEL0, SEL1, SEL2   : IN  std_logic;
    R0, R1, R2, R3     : OUT std_logic;
    CARRY_OUT          : OUT std_logic;
    OVERFLOW           : OUT std_logic;
    ZERO               : OUT std_logic;
    NEGATIVO           : OUT std_logic
            
    );
END alu;

ARCHITECTURE TypeArchitecture OF alu IS
-- Sinais temporários para o armazenamento de operações
SIGNAL A, B, C, D, E, F, G, H, W, X, Y, Z : std_logic;
SIGNAL c_out, ovf : std_logic;

-- Criação dos componentes necessários para a implementação da ALU
COMPONENT modulo_logico IS
  PORT (

    A_MOD, B_MOD : IN std_logic_vector (3 downto 0);
	 SEL_MOD : IN std_logic_vector (1 downto 0);
	 Z_MOD : OUT std_logic_vector (3 downto 0)
    
    );
END COMPONENT modulo_logico;

COMPONENT modulo1 IS
  PORT (
  
    A0, A1, A2, A3      : IN  std_logic;                    
    B0, B1, B2, B3      : IN  std_logic;
    R0, R1, R2, R3      : OUT std_logic;
    S0, S1              : IN  std_logic;                    
    CARRY_OUT           : OUT std_logic;
    OVERFLOW            : OUT std_logic
    );
    
END COMPONENT modulo1;


COMPONENT quad_mux IS
  PORT (
    A0, A1, A2, A3      : IN  std_logic;    
    B0, B1, B2, B3      : IN  std_logic; 
    R0, R1, R2, R3      : OUT  std_logic; 
    S                   : IN  std_logic             
    );
END COMPONENT quad_mux;


BEGIN
-- Todos os flags só funcionam se as operações aritméticas forem selecionadas
-- O flag ZERO só é positivo somente quando todos os bits de saída são zero
ZERO <= (W NOR X) AND (Y NOR Z) AND not SEL0;

-- O flag de negativo é igual ao MSB, pois ele representa o sinal
NEGATIVO <= Z AND not SEL0;

-- O flag de carry_out indica se uma soma realizada no MSB gerou, ou propagou, um carry
CARRY_OUT <= c_out AND not SEL0;

-- O flag de overflow indica se uma soma entre dos números de sinais equivalentes gerou
-- um número de sinal diferente
OVERFLOW <= ovf AND not SEL0;

R0 <= W;
R1 <= X;
R2 <= Y;
R3 <= Z;

-- O módulo aritmético, que realiza as operações de soma, subtração, incremento de 1
-- e complemento de 2, sendo essas duas últimas realizadas em cima do vetor A
mod_1 : modulo1 PORT MAP(

A0 => A0,
A1 => A1,
A2 => A2,
A3 => A3,

B0 => B0,
B1 => B1,
B2 => B2,
B3 => B3,

R0 => A,
R1 => B,
R2 => C,
R3 => D,

S0 => SEL2,
S1 => SEL1,

CARRY_OUT => c_out,
OVERFLOW => ovf);


-- O módulo lógico, que realiza as operações de OR bit a bit, AND bit a bit,
-- MAX e MIN
mod_2 : modulo_logico PORT MAP(

A_MOD(0) => A0,
A_MOD(1) => A1,
A_MOD(2) => A2,
A_MOD(3) => A3,

B_MOD(0) => B0,
B_MOD(1) => B1,
B_MOD(2) => B2,
B_MOD(3) => B3,

SEL_MOD(0) => SEL2,
SEL_MOD(1) => SEL1,

Z_MOD(0) => E,
Z_MOD(1) => F,
Z_MOD(2) => G,
Z_MOD(3) => H);

-- Este último MUX realiza a seleção de qual módulo será a saída
mux : quad_mux PORT MAP(

A0 => A,
A1 => B,
A2 => C,
A3 => D,

B0 => E,
B1 => F,
B2 => G,
B3 => H,

R0 => W,
R1 => X,
R2 => Y,
R3 => Z,

S => SEL0);


END TypeArchitecture;
