LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Implementação combinacional de um MUX 4x1 com entradas com 4 bits de largura

ENTITY MUX41 IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    A, B, C, D : IN  std_logic_vector(3 downto 0);
    SEL        : IN  std_logic_vector(1 DOWNTO 0); 
    S        : OUT std_logic_vector(3 downto 0)                    
    );
END MUX41;

ARCHITECTURE TypeArchitecture OF MUX41 IS
-- Sinais para o armazenamento dos mintermos do vetor de entrada, dessa forma
-- as operações são só realizadas uma vez
SIGNAL S0, S1, S2, S3 : std_logic;

BEGIN
	S0 <= SEL(0) nor SEL(1);
	S1 <= SEL(0) and not SEL(1);
	S2 <= not SEL(0) and SEL(1);
	S3 <= SEL(0) and SEL(1);
  
  -- A ideia é a mesma do MUX 4x1 com entradas de 1 bit de largura, mas agora aplicada
  -- em vetores
	S(0) <= (A(0) and S0) or (B(0) and S1) or (C(0) and S2) or (D(0) and S3);
	S(1) <= (A(1) and S0) or (B(1) and S1) or (C(1) and S2) or (D(1) and S3);
	S(2) <= (A(2) and S0) or (B(2) and S1) or (C(2) and S2) or (D(2) and S3);
	S(3) <= (A(3) and S0) or (B(3) and S1) or (C(3) and S2) or (D(3) and S3);

END TypeArchitecture;
