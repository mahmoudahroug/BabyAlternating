library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity BabyAlternating is
	port( clk, sensor : in std_logic;
			alarm, motorLeft, motorRight, pwm : out std_logic) ;
end BabyAlternating;

architecture arch of BabyAlternating is
Signal timer: INTEGER range 0 to 200000999 := 0;
signal motorPeriod: INTEGER range 0 to 20000000 := 0;
Signal alternate: std_logic := '0';
Signal pwmRange: INTEGER range 0 to 100001;

BEGIN
	process(clk, sensor, timer, alternate)
	BEGIN
		if clk'event and clk='1' then
			timer <= timer +1;
		end if;
		
		if sensor='0' then
			alarm <= '0';
			alternate <= '0';
		end if;
		
		if timer >= 200000000 then
			alarm <= '1';
			alternate <= '1';
			timer <= 0;
		end if;
		
		
	END process;
	process(clk, alternate, motorPeriod)
	BEGIN
		if alternate = '0' then
			motorLeft<= '0';
			motorRight <= '0';
		else
			if clk'event and clk='1' then
				motorPeriod <= motorPeriod+1;
			end if;
			if motorPeriod < 4999991 then
				motorLeft <= '1';
				motorRight <= '0';
			else
				motorLeft <= '0';
				motorRight <= '1';
				
			end if;
		end if;
		if motorPeriod >= 10000000 then
			motorPeriod <= 0;
		end if;
	END process;
	process(clk, pwmRange)
	BEGIN
		if clk'event and clk='1' then
			pwmRange <= pwmRange +1;
		end if;
		if pwmRange <= 30000 then
			pwm <= '1';
		else
			pwm <= '0';
		end if;
		if pwmRange >= 40000 then
			pwmRange <= 0;
		end if;
	END process;
END arch;