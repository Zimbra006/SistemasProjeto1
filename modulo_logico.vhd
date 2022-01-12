LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY modulo_logico IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    A_MOD, B_MOD : IN std_logic_vector (3 downto 0);
  SEL_MOD : IN std_logic_vector (1 downto 0);
  ------------------------------------------------------------------------------
  --Insert output ports below
  Z_MOD : OUT std_logic_vector (3 downto 0)
    
    );
END modulo_logico;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF modulo_logico IS

SIGNAL OR_OP, AND_OP, MAX_OP, MIN_OP : std_logic_vector(3 downto 0);
-- Sinais para armazenar o valor das operações realizadas
COMPONENT MUX41 IS
 PORT(
 A, B, C, D : IN std_logic_vector(3 DOWNTO 0);
 SEL : IN std_logic_vector (1 DOWNTO 0);
 ---------------------------------------------
 S : OUT std_logic_vector (3 DOWNTO 0)
 );
END COMPONENT MUX41;

COMPONENT comparador_magnitude IS

 PORT(
 A, B : IN std_logic_vector(3 DOWNTO 0);
 -----------------------------------------------
 MAX, MIN : OUT std_logic_vector(3 DOWNTO 0)
 );
 
END COMPONENT comparador_magnitude;
BEGIN

-- Primeiro temos o comparador de magnitude, cujas saídas são os valores das fun
-- -ções MAX e MIN, que são armazenadas nos seus respectivos sinais
comp_mag : comparador_magnitude PORT MAP(
A => A_MOD,
B => B_MOD,
-----------
MAX => MAX_OP,
MIN => MIN_OP);

-- Depois, são realizadas as operações de OR e AND bit a bit, e os resultados
-- são armazenados nos seus respectivos sinais
OR_OP <= A_MOD or B_MOD;
AND_OP <= A_MOD and B_MOD;

-- Por fim, um MUX realiza a seleção da saída, tendo como entrada os sinais das
-- funções realizadas pelo módulo e utilizado a entrada de seleção SEL
mux : MUX41 PORT MAP(
A => OR_OP,
B => AND_OP,
C => MAX_OP,
D => MIN_OP,
------------
SEL => SEL_MOD,
S => Z_MOD);

END TypeArchitecture;
