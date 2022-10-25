-- Model name: RISCV_ALU_TB 
-- Description: Testbench for combinational logic example RISCV_ALU

-- Complete all sections marked >>
-- >> Authors: Oluwadamilola Adebayo
-- >> Date: 03/10/2022

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY RISCV_ALU_TB IS END RISCV_ALU_TB;
 
ARCHITECTURE behavior OF RISCV_ALU_TB IS 

-- >> COMPONENT declaration
COMPONENT RISCV_ALU is
    Port ( A : IN std_logic_vector(31 downto 0);
	       B : IN std_logic_vector(31 downto 0);
	       selALUOP : IN std_logic_vector(3 downto 0);
	       branch : OUT std_logic;
	       ALUOut : OUT std_logic_vector(31 downto 0)
          );
END COMPONENT;

-- >> signal declarations 
signal    A         :    std_logic_vector(31 downto 0);
signal	  B         :    std_logic_vector(31 downto 0);
signal	  selALUOP  :    std_logic_vector(3 downto 0);
signal	  branch    :    std_logic;
signal	  ALUOut    :    std_logic_vector(31 downto 0);

signal  testNo      : integer; -- test numbers aids locating each simulation waveform test 
signal  endOfSim    : boolean := false; -- assert at end of simulation to show end point
 
BEGIN

-- >> uut unit under test instantiation 
uut: RISCV_ALU Port map 
	 (A        =>  A,
      B        =>  B,
      selALUOP =>  selALUOP,
      branch   =>  branch,
      ALUOut   =>  ALUOut
     );

-- >> 
stim_i: process -- Stimulus process
-- >> May wish to use variable and for-loop signal stimulus generation
-- Use tempVec to define the TB i/p signal vector, and assign to UU input signal(s)
-- variable value changes immediately on assignment in process  
variable tempVec : std_logic_vector(1 downto 0); 
begin
    report "%N : Simulation start";
    endOfSim <= false;
    
    -- assign default signals
	testNo <= 0;
    A    <=    X"5a5a5a5a";
    B    <=    X"15a5a5a6";
    selALUOP <= "0000";
    wait for 10 ns;
   
   testNo <= 1;
    A    <=    X"ffffffff";
    B    <=    X"40000000";
    selALUOP <= "0000";
    wait for 10 ns;
    
    testNo <= 2;
    A    <=    X"ffffffff";
    B    <=    X"fffffffe";
    selALUOP <= "0001";
    wait for 10 ns;
    
    testNo <= 3;
    A    <=    X"f0c3a596";
    B    <=    X"1f7e8ab4";
    for i in 2 to 4 loop
     selALUOP <= std_logic_vector( to_unsigned(i,4)); -- generate 2-bit vector 
     wait for 10 ns;
   end loop;
   wait for 10 ns;
   
   testNo <= 4;
    A    <=    X"f0c3a596";
    B    <=    X"1f7e8ab4";
    for i in 5 to 7 loop
     selALUOP <= std_logic_vector( to_unsigned(i,4)); -- generate 2-bit vector 
     wait for 10 ns;
   end loop;
   wait for 10 ns;
   
   testNo <= 5;
    A    <=    X"f0c3a596";
    B    <=    X"1f7e8ab4";
    for i in 8 to 15 loop
     selALUOP <= std_logic_vector( to_unsigned(i,4)); -- generate 2-bit vector 
     wait for 10 ns;
   end loop;
   wait for 10 ns;
   
    endOfSim <= true;
    report "%N : Simulation end";

	wait;
	
end process;

END behavior;
