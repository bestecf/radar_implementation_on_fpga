----------------------------------------------------------------------------------
-- Create Date: 06.05.2018 19:31:14
-- Module Name: project - Behavioral
-- Project Name: Ultrasonic Radar Implementation on FPGA
-- Target Devices: Arty Z7
-- Additional Comments: ** Component name is "SERVO_DRIVER" for the TOP MODULE **
-----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity servo_motor is
port( clk : in std_logic;
	  sw : in std_logic;
	  sensor_loc_out : out std_logic_vector (7 downto 0);
	  pwm : out std_logic);
end entity;

architecture Behavioral of servo_motor is
signal clk_1MHz : std_logic:='0';
signal cc : std_logic:='0';
begin

process(clk) --1MHz clock
variable count: integer range 0 to 1000000:=0;
begin
if (rising_edge(clk)) then
		count := count + 1;
	if (count = 50) then
		clk_1MHz <= not clk_1MHz;
		count := 0;
	end if;
end if;
end process;

process(clk_1MHz, CC)
variable pwm_time : integer range 0 to 20000 := 0;
variable angle_count : integer range 0 to 180 := 0;
constant pwmOn : integer := 500;
constant pwmOff : integer := 19500;
begin
if (rising_edge(clk_1MHz)) then

	if (angle_count = 0) then --cw turn
		cc <= '0';		
	elsif (angle_count = 180) then --ccw turn
		cc <= '1';
	end if;

-- 500us to 2500us pwm signal
-- 11 x max_angle_count:180 + 500 = 2500
	if (pwm_time < (pwmOn + (angle_count*11)) and sw = '1') then
		pwm <= '1';
	elsif (pwm_time < (pwmOff - (angle_count*11))) then
		pwm <= '0';
	end if;
	
	if (pwm_time = (pwmOn + pwmOff) and sw = '1') then	-- 20000us period of pwm
		pwm_time := 0;	
		if (cc = '0') then    -- angle 0 to 180 turn
			angle_count := angle_count + 1;
			sensor_loc_out <= conv_std_logic_vector(angle_count,8);
		elsif (cc = '1') then     -- angle 180 to 0 turn
			angle_count := angle_count - 1;
			sensor_loc_out <= conv_std_logic_vector(angle_count,8);
		end if;
	end if;
	
	pwm_time := pwm_time + 1;	
	
end if;
end process;

end Behavioral;
