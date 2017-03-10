LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY testbench_vhd IS
END testbench_vhd;

ARCHITECTURE behavior OF testbench_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT top
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		push : IN std_logic;          
		Unit_R : OUT std_logic_vector(6 downto 0);
		Ten_R : OUT std_logic_vector(6 downto 0)
		);
	END COMPONENT;

	--Inputs
	SIGNAL clk :  std_logic := '0';
	SIGNAL rst :  std_logic := '1';
	SIGNAL push :  std_logic := '0';

	--Outputs
	SIGNAL Unit_R :  std_logic_vector(6 downto 0);
	SIGNAL Ten_R :  std_logic_vector(6 downto 0);

BEGIN

  
	-- Instantiate the Unit Under Test (UUT)
	uut: top PORT MAP(
		clk => clk,
		rst => rst,
		push => push,
		Unit_R => Unit_R,
		Ten_R => Ten_R
	);

  clk <= not clk after 50 ns;
  rst <= '0' after 150 ns;
  push <= not push after 50 ms;
  


END;
