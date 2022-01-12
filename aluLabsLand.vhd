LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Código da ALU adaptado para o uso da placa Altera, no IDE do site LabsLand

-- Os vetores A, B e S são representados pelo vetor SW
-- SW(10 downto 7) = A
-- SW(6 downto 3) = B
-- SW(2 downto 0) = SEL

-- Os flags são representados pelas saídas LEDG
-- Já os valores de cada vetor de entrada e o vetor de saída são
-- representados nos displays hexadecimas HEX6, 4 e 2

ENTITY alu IS
  PORT (
     SW    : IN std_logic_vector(10 DOWNTO 0);
	 LEDG  : OUT std_logic_vector (3 DOWNTO 0);
	 HEX6  : out std_logic_vector (6 downto 0);
	 HEX4  : out std_logic_vector (6 downto 0); 
	 HEX2  : out std_logic_vector (6 downto 0)
	 );
END alu;

ARCHITECTURE TypeArchitecture OF alu IS
SIGNAL A, B, C, D, E, F, G, H, W, X, Y, Z : std_logic;

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
    OVERFLOW            : OUT std_logic;
    NEGATIVO            : OUT std_logic
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

-- O único componente novo é o decoder de binário para 7 segmentos
COMPONENT decoder7seg IS
  PORT (
  
    A : IN std_logic_vector(3 downto 0);
    SEG : OUT std_logic_vector(6 downto 0)
    );
END COMPONENT decoder7seg;


BEGIN

-- Entre esse e o próximo comentário, todas as operações realizadas pela ALU
-- são as mesmas, a diferença estando nos nomes das saídas e entradas
  
LEDG(0) <= (W NOR X) AND (Y NOR Z);

mod_1 : modulo1 PORT MAP(

A0 => SW(7),
A1 => SW(8),
A2 => SW(9),
A3 => SW(10),

B0 => SW(3),
B1 => SW(4),
B2 => SW(5),
B3 => SW(6),

R0 => A, 
R1 => B,
R2 => C,
R3 => D,

S0 => SW(0),
S1 => SW(1),

CARRY_OUT => LEDG(1),
OVERFLOW =>  LEDG(2),
NEGATIVO =>  LEDG(3));

mod_2 : modulo_logico PORT MAP(

A_MOD(0) => SW(7),
A_MOD(1) => SW(8),
A_MOD(2) => SW(9),
A_MOD(3) => SW(10),

B_MOD(0) => SW(3),
B_MOD(1) => SW(4),
B_MOD(2) => SW(5),
B_MOD(3) => SW(6),

SEL_MOD(0) => SW(0),
SEL_MOD(1) => SW(1),

Z_MOD(0) => E,
Z_MOD(1) => F,
Z_MOD(2) => G,
Z_MOD(3) => H);

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

S => SW(2));

-- O diplay HEX4 representa o vetor B
d1 : decoder7seg PORT MAP(

A(0) => SW(3),
A(1) => SW(4),
A(2) => SW(5),
A(3) => SW(6),

SEG(0) => HEX4(6),
SEG(1) => HEX4(5),
SEG(2) => HEX4(4),
SEG(3) => HEX4(3),
SEG(4) => HEX4(2),
SEG(5) => HEX4(1),
SEG(6) => HEX4(0)
);

-- O diplay HEX6, o vetor A
d2 : decoder7seg PORT MAP(

A(0) => SW(7),
A(1) => SW(8),
A(2) => SW(9),
A(3) => SW(10),

SEG(0) => HEX6(6),
SEG(1) => HEX6(5),
SEG(2) => HEX6(4),
SEG(3) => HEX6(3),
SEG(4) => HEX6(2),
SEG(5) => HEX6(1),
SEG(6) => HEX6(0)
);

-- O diplay HEX2 representa o vetor R, de saída
d3 : decoder7seg PORT MAP(

A(0) => W,
A(1) => X,
A(2) => Y,
A(3) => Z,

SEG(0) => HEX2(6),
SEG(1) => HEX2(5),
SEG(2) => HEX2(4),
SEG(3) => HEX2(3),
SEG(4) => HEX2(2),
SEG(5) => HEX2(1),
SEG(6) => HEX2(0)
);

END TypeArchitecture;
