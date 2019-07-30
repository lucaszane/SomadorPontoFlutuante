-- Listing 3.20
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity fp_adder_testbench is
end fp_adder_testbench;

architecture arch of fp_adder_testbench is
   signal sign1, sign2: std_logic;
   signal exp1, exp2: std_logic_vector(3 downto 0);
   signal frac1, frac2: std_logic_vector(7 downto 0);
   signal sign_out: std_logic;
   signal exp_out: std_logic_vector(3 downto 0);
   signal frac_out: std_logic_vector(7 downto 0);
begin
   -- instantiate fp adder
   fp_add_unit: entity work.fp_adder
      port map(
         sign1=>sign1, sign2=>sign2, exp1=>exp1, exp2=>exp2,
         frac1=>frac1, frac2=>frac2,
         sign_out=>sign_out, exp_out=>exp_out,
         frac_out=>frac_out
      );

      process
	begin
	   sign1 <= '0';
	   sign2 <= '0';
	   exp1 <= "0001";
	   exp2 <= "0000";
	   frac1 <= "10000010";
	   frac2 <= "10000010";
	   wait for 500 ns;

	   sign1 <= '1';
	   sign2 <= '0';
	   exp1 <= "1001";
	   exp2 <= "1010";
	   frac1 <= "10000011";
	   frac2 <= "10000110";
	   wait for 500 ns;
	
	   wait;
     end process;

end arch;
