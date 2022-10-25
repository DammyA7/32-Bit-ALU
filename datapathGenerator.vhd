-- Header Section
-- Component Name : ALU
-- Title          : 32-bit RISC-V ALU

-- Description
-- ALUOUTMux generates ALUOut(31:0)
-- branchMux genrates branch

-- Author(s)      : Oluwadamilola Adebayo
-- Company        : University of Galway
-- Email          : o.adebayo2@universityofgalway.ie
-- Date           : 06/10/2022

-- entity signal dictionary
-- sel	0/1  selects muxOut = muxIn0/muxIn1
-- muxIn1	Input datapath 1 (1-bit)
-- muxIn0	Input datapath 0 (1-bit)
-- muxOut	Output datapath 1 (1-bit)

-- internal signal dictionary
-- None

-- library declarations
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- entity declaration
entity RISCV_ALU is 
Port(
	A : in std_logic_vector(31 downto 0);
	B : in std_logic_vector(31 downto 0);
	selALUOP : in std_logic_vector(3 downto 0);
	branch : out std_logic;
	ALUOut : out std_logic_vector(31 downto 0)
);
end entity RISCV_ALU;

architecture Combinational of RISCV_ALU is
-- Internal signal declarations
-- Component declarations

begin

ALUOut_branch_i: process(A,B,selALUOP)
begin
	AlUOut <= (others => '0');
	branch <= '0';
	case selALUOP is
	-- arithmetic operations
		when "0000" => ALUOut <= std_logic_vector(signed(A) + signed(B));  --ADD
		when "0001" => ALUOut <= std_logic_vector(signed(A) - signed(B));  --SUB
		
	-- logical Operations
		when "0010" => ALUOut <= A AND B; -- AND
		when "0011" => ALUOut <= A OR B; --OR
		when "0100" => ALUOut <= A XOR B; --XOR
		
	-- Shift (immediate or registered) operations
		when "0101" => ALUOut <= std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(B(4 downto 0))))); --SLL
		when "0110" => ALUOut <= std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B(4 downto 0))))); --SRL
		when "0111" => ALUOut <= std_logic_vector(shift_right(signed(A), to_integer(unsigned(B(4 downto 0))))); -- SRA 
		
	-- set less than operations
		when "1000" => -- Set less than immediate(SLT)
		if(signed(A) < signed(B)) then
				ALUOut(0) <= '1';
			else
				ALUOut(0) <= '0';
			end if;
		
		when "1001" => -- Set less than unsigned(SLTU)
		if(unsigned(A) < unsigned(B)) then
				ALUOut(0) <= '1';
			else
				ALUOut(0) <= '0';
			end if;
		
	-- branch check
		when "1010" => --BEQ
			if(A = B) then
				branch <= '1';
			else
				branch <= '0';
			end if;
		
		when "1011" => --BNE
		  if(A /= B) then
				branch <= '1';
			else
				branch <= '0';
			end if;
		
		
		when "1100" => --BLT
		if(signed(A) < signed(B)) then
				branch <= '1';
			else
				branch <= '0';
			end if;
			
		when "1101" => --BGE
		if(signed(A) >= signed(B)) then
				branch <= '1';
			else
				branch <= '0';
			end if;
		
		when "1110" => --BLTU
		if(unsigned(A) < unsigned(B)) then
				branch <= '1';
			else
				branch <= '0';
			end if;
		
		when "1111" => --BGEU
		if(unsigned(A) >= unsigned(B)) then
				branch <= '1';
			else
				branch <= '0';
			end if;
	   when others => null;
    end case;
end process;

end Combinational;