LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Implementação combinacional de um MUX 8x4, com 1 entrada de seleção

ENTITY quad_mux IS
  PORT (
    A0      : IN  std_logic;    
    A1      : IN  std_logic; 
    A2      : IN  std_logic; 
    A3      : IN  std_logic; 
    B0      : IN  std_logic;    
    B1      : IN  std_logic;     
    B2      : IN  std_logic;     
    B3      : IN  std_logic;
    R0      : OUT  std_logic;  
    R1      : OUT  std_logic; 
    R2      : OUT  std_logic; 
    R3      : OUT  std_logic; 
    S       : IN  std_logic             
  
    );
END quad_mux;

ARCHITECTURE TypeArchitecture OF quad_mux IS
-- Sinais temporários utilizados para uma fácil legibilidade
-- do código
SIGNAL A, B, C, D, E, F, G, H : std_logic;

BEGIN

-- Cada vetor é selecionado com base no valor atual da entrada S
-- Se ela for 0, o vetor A é selcionado, caso contrário, o vetor B é
A <= (A0 AND (NOT S));
B <= (A1 AND (NOT S));
C <= (A2 AND (NOT S));
D <= (A3 AND (NOT S));

E <= (B0 AND NOT(NOT S));
F <= (B1 AND NOT(NOT S));
G <= (B2 AND NOT(NOT S));
H <= (B3 AND NOT(NOT S));

R0 <= A OR E;
R1 <= B OR F;
R2 <= C OR G;
R3 <= D OR H;


END TypeArchitecture;
