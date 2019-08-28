-- Listing 3.20
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity fp_adder_test is
   port(
      CLOCK_50: in std_logic;
      SW: in std_logic_vector(8 downto 0);
      KEY: in std_logic_vector(3 downto 0);     
		HEX0: out std_logic_vector(6 downto 0);
		HEX1: out std_logic_vector(6 downto 0);
		HEX2: out std_logic_vector(6 downto 0);
		HEX3: out std_logic_vector(6 downto 0);
		LEDG: out std_logic_vector(3 downto 0)
   );
end fp_adder_test;

architecture arch of fp_adder_test is
   signal sign1, sign2: std_logic;
   signal exp1, exp2: std_logic_vector(3 downto 0);
   signal frac1, frac2: std_logic_vector(7 downto 0);
   signal sign_out: std_logic;
   signal exp_out: std_logic_vector(3 downto 0);
   signal frac_out: std_logic_vector(7 downto 0);
   signal led3, led2, led1, led0:
             std_logic_vector(7 downto 0);
      signal an: std_logic_vector(3 downto 0);
      signal sseg: std_logic_vector(7 downto 0); 
		signal state: std_logic_vector(1 downto 0); 
begin
   -- set up the fp adder input signals
	-- sign1 <= '0';
	-- exp1 <= "0100";
	-- frac1<= "10001000";
	-- sign2 <= '0';
	-- exp2 <= "0010";
	-- frac2 <= "11100000";
	
	-- sign1 <= '0';
   -- exp1 <= "0100";
   -- frac1<= "10001000";
   -- sign2 <= '1';
   -- exp2 <= "0010";
   -- frac2 <= "11100000";
	
	   -- sign1 <= '1'; -- sinal negativo
	   -- sign2 <= '1'; -- sinal negativo
	   -- exp1 <= "0001";  -- expoente 1
	   -- exp2 <= "0001"; -- expoente 1
	   -- frac1 <= "11000000"; -- já com expoente, 1,5
	   -- frac2 <= "10100000"; -- já com expoente, 1,25
		-- resultado é -2,75
		
		-- sign1 <= '0';
	   -- sign2 <= '0';
	   -- exp1 <= "0000";
	   -- exp2 <= "0000";
	   -- frac1 <= "00000000";
	   -- frac2 <= "00000000";

		
		process (KEY)
			begin
				if (KEY(0)='0') then						
					state <= "00";
					
				elsif (KEY(1)='0') then
					state <= "01";
				elsif (KEY(2)='0') then
					state <= "10";
				elsif (KEY(3)='0') then
					state <= "11";
				end if;
			end process;
	
			
		process (state, SW)
			begin
				case state is
					when "00" => 
						LEDG<="0001";
						sign1 <= SW(8);
						frac1 <= SW(7 downto 0);					
						
					when "01" =>
						LEDG<="0010";
						exp1 <= SW(3 downto 0);
						
					when "10" => 
						LEDG<="0100";
						sign2 <= SW(8);
						frac2 <= SW(7 downto 0);
						
					when others => 
						LEDG<="1000";
						exp2 <= SW(3 downto 0);
					
					end case;
			end process;
	
   -- instantiate fp adder
   fp_add_unit: entity work.fp_adder
      port map(
         sign1=>sign1, sign2=>sign2, exp1=>exp1, exp2=>exp2,
         frac1=>frac1, frac2=>frac2,
         sign_out=>sign_out, exp_out=>exp_out,
         frac_out=>frac_out
      );

   -- instantiate three instances of hex decoders
   -- exponent
   sseg_unit_0: entity work.hex_to_sseg
      port map(hex=>exp_out, dp=>'0', sseg=>led0);
		
		
   -- 4 LSBs of fraction
   sseg_unit_1: entity work.hex_to_sseg
      port map(hex=>frac_out(3 downto 0),
               dp=>'1', sseg=>led1);
   -- 4 MSBs of fraction
   sseg_unit_2: entity work.hex_to_sseg
      port map(hex=>frac_out(7 downto 4),
               dp=>'0', sseg=>led2);
   -- sign
   led3 <= "10111111" when sign_out='1' else -- middle bar
           "11111111";                       -- blank
			  

   -- instantiate 7-seg LED display time-multiplexing module
   disp_unit: entity work.disp_mux
      port map(
         clk=>CLOCK_50, reset=>'0',
         in0=>led0, in1=>led1, in2=>led2, in3=>led3,
         an=>an, sseg=>sseg
      );
		
		process(an, sseg)
   begin
      case an is
         when "1110" =>
				HEX0 <= sseg (6 downto 0);
				HEX1 <= "1111111";
				HEX2 <= "1111111";
				HEX3 <= "1111111";
         when "1101" =>
				HEX1 <= sseg (6 downto 0);
				HEX0 <= "1111111";
				HEX2 <= "1111111";
				HEX3 <= "1111111";
         when "1011" =>
				HEX2 <= sseg (6 downto 0);
				HEX1 <= "1111111";
				HEX0 <= "1111111";
				HEX3 <= "1111111";
         when others =>
				HEX3 <= sseg (6 downto 0);
				HEX1 <= "1111111";
				HEX2 <= "1111111";
				HEX0 <= "1111111";
      end case;
   end process;
end arch;
