
LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Módulo de um comparador de magnitude modificado, que realiza as operações de MAX e MIN

ENTITY comparador_magnitude IS
  PORT (
  ------------------------------------------------------------------------------             
    A, B        : IN  std_logic_vector(3 DOWNTO 0); -- input vector example
  -----------------------------------------------------------------------------
    MAX, MIN        : OUT std_logic_vector(3 DOWNTO 0)                   
    );
END comparador_magnitude;

ARCHITECTURE TypeArchitecture OF comparador_magnitude IS
-- Sinais intermediários para a realização das operações de comparação
SIGNAL equal : std_logic;
SIGNAL a_bigger : std_logic;
SIGNAL b_bigger : std_logic;
SIGNAL a0_bigger, a1_bigger, a2_bigger, a3_bigger : std_logic;
SIGNAL equal_0, equal_1, equal_2, equal_3 : std_logic;
BEGIN
  -- Claramente, dois números binários só são iguais se todos os seus bits forem idênticos
	equal_0 <= A(0) xnor B(0);
	equal_1 <= A(1) xnor B(1);
	equal_2 <= A(2) xnor B(2);
	equal_3 <= A(3) xnor B(3);

	equal <= equal_0 and equal_1 and equal_2 and equal_3;

  -- Implementação combinacional da testagem para se A é maior do que B
	a3_bigger <= A(3) and not B(3);
	a2_bigger <= equal_3 and (A(2) and not B(2));
	a1_bigger <= equal_3 and equal_2 and (A(1) and not B(1));
	a0_bigger <= equal_3 and equal_2 and equal_1 and (A(0) and not B(0));
  
	a_bigger <= a3_bigger OR a2_bigger OR a1_bigger OR a0_bigger;
  
  -- Note que existem 3 possibilidades de comparação entre dois números A e B, ou A < B
  -- ou A = B ou A > B; logo, B > A se e somente se as afirmações de A = B e A > B forem
  -- falsas
	b_bigger <= a_bigger nor equal;

  -- Aqui realiza-se uma operação if, só que combinacionalmente, utilizando-se da porta AND
	MAX(0) <= (A(0) and a_bigger) or (B(0) and b_bigger);
	MAX(1) <= (A(1) and a_bigger) or (B(1) and b_bigger);
	MAX(2) <= (A(2) and a_bigger) or (B(2) and b_bigger);
	MAX(3) <= (A(3) and a_bigger) or (B(3) and b_bigger);

	MIN(0) <= (A(0) and b_bigger) or (B(0) and a_bigger);
	MIN(1) <= (A(1) and b_bigger) or (B(1) and a_bigger);
	MIN(2) <= (A(2) and b_bigger) or (B(2) and a_bigger);
	MIN(3) <= (A(3) and b_bigger) or (B(3) and a_bigger);

	
END TypeArchitecture;
