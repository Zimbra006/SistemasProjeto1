
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY decoder7seg IS
  PORT (
  
    A : IN std_logic_vector(3 downto 0);
    SEG : OUT std_logic_vector(6 downto 0)
    );
END decoder7seg;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF decoder7seg IS
---- A = XYZW

SIGNAL X, Y, Z, W : std_logic;
SIGNAL S6, S5, S4, S3, S2, S1, S0 : std_logic;
-- Sinais intermediários para armazenar valores
BEGIN
X <= A(3);
Y <= A(2);
Z <= A(1);
W <= A(0);
-- Estes sinais armazenam os valores do vetor de entrada, por conveniência

S6 <= (Y nor W) or (Y and Z) or (X and (Y nor Z)) or ((not X) and Y and W) or ((not X) and W and Z);
S5 <= (Y nor W) or (Y nor X) or ((not X) and (Z xnor W)) or (X and (not Z) and W);
S4 <= (X nor Z) or ((not Z) and W) or (X xor Y) or ((not X) and W);
S3 <= (Y nor W) or (Z and (not W)) or ((not Y) and Z) or (X and (not Z)) or (Y and W and (not Z));
S2 <= (Y nor W) or (X and Y) or (X and Z) or (Z and (not W));
S1 <= ((X nor Z) and (not W)) or ((not Z) and (X xor Y)) or (X and Z and W) or (Y and Z and (not W));
S0 <= X or (Y and (not W)) or (Y xor Z);
-- Estes armazenam o valor da operação de decodificação

SEG(6) <= not S6;
SEG(5) <= not S5;
SEG(4) <= not S4;
SEG(3) <= not S3;
SEG(2) <= not S2;
SEG(1) <= not S1;
SEG(0) <= not S0;
-- Por fim, a saída é o valor da decodificação negada, para se adaptar aos displays com 
-- entradas em valor baixo


END TypeArchitecture;
