LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Implementação combinacional de um MUX 4x1, com entradas de 1 bit

ENTITY MUX4_1 IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    A, B, C, D : IN  std_logic;
    SEL0        : IN  std_logic;
    SEL1        : IN std_logic;
  ------------------------------------------------------------------------------

    S        : OUT std_logic                    
    );
END MUX4_1;

ARCHITECTURE TypeArchitecture OF MUX4_1 IS

BEGIN
  -- A saída vai ser selecionada com base no vetor de seleção (SEL1 SEL0), logo podemos realizar
  -- diversas operações de AND entre as entradas e os mintermos desse vetor de seleção, como se
  -- fosse uma operação de if
	S <= (A and (SEL1 nor SEL0)) or (B and (not SEL1 and SEL0)) or (C and (SEL1 and not SEL0)) or
			(D and (SEL1 and SEL0));

END TypeArchitecture;
