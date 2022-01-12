LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Módulo para um meio somador em VHDL

ENTITY half_adder IS
  PORT (
 
    A, B        : IN  std_logic;                    
    SUM         : OUT  std_logic;
    CARRY       : OUT std_logic                   
    );
END half_adder;

ARCHITECTURE TypeArchitecture OF half_adder IS
BEGIN
-- A operação realizada por ele é simples:
-- 0+0 = 0, 0+1 = 1, 1+0 = 1 e 1+1=0, podemos perceber o padrão
-- da porta XOR aqui, e o carry é gerado só no último caso, para
-- A AND B
SUM   <= A XOR B;
CARRY <= A AND B;

END TypeArchitecture;
