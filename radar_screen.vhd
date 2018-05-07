----------------------------------------------------------------------------------
-- Design Name: Ultrasonic Radar Implementation 
-- Module Name: project - Behavioral
-- Project Name: Ultrasonic Radar Implementation
-- Target Devices: Arty Z7 FPGA Board
-- Additional Comments: ** Component Name is RADAR_DRIVER for the TOP MODULE ** 
-- Radar Screen Size: 640x480
----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.math_real.all;

entity radar_screen is
port( distance_radar: in integer;
	  vert_sync_out, horiz_sync_out : in std_logic;
	  pixel_row, pixel_column : in std_logic_vector(9 downto 0);
	  red, green, blue : out std_logic;
	  sensor_loc_in : in std_logic_vector (7 downto 0));	
end entity;

architecture Behavior of radar_screen is 
signal ball_y_pos, ball_x_pos : std_logic_vector(9 DOWNTO 0);
signal ball_on_red, ball_on_green, ball_on_blue : std_logic;
signal ball_row: integer := 240; -- 480/2
signal ball_col: integer := 320; -- 640/2
signal ball_size: integer := 5;
type sinlut is array (0 to 179) of integer;
signal sinrom : sinlut;
signal cosrom : sinlut;
begin

genrom_sin: for i in 0 to 179 generate
constant x : real := sin ( real(i) * math_pi / real(179));
constant xn : integer := (integer (x * real(100)));
begin
	sinrom(i) <= xn;
end generate;
	
genrom_cos: for i in 0 to 179 generate
constant x : real := cos ( real(i) * math_pi / real(179));
constant xn : integer := (integer (x * real(100)));
begin
	cosrom(i) <= xn;
end generate;
	
	
red   <=  ball_on_red;
green <=  ball_on_green; 
blue  <=  ball_on_blue;

process(distance_radar)
begin

if (distance_radar > 0) then
	if distance_radar > 200 then -- if distance is higher than 200cm, show black point at 10x10 pixel
		ball_row <= 10;
		ball_col <= 10;
		ball_on_red <= '0';
		ball_on_green <= '0';
		ball_on_blue <= '0';
	else
		ball_col <= distance_radar*2*(cosrom (conv_integer(sensor_loc_in)))/100+320;
		ball_row <= distance_radar*2*(sinrom (conv_integer(sensor_loc_in)))/100+240;		
	end if;
end if;

-----DRAW BACKGROUND BLACK----
if (pixel_row > 0 and pixel_row < 480 and pixel_column > 0 and pixel_column < 640) then 
	ball_on_red <= '0';
	ball_on_green <= '0';
	ball_on_blue <= '0';
	
-----DRAW POINT MAGENTA----
	if ( pixel_column > (ball_col - ball_size) and pixel_column < (ball_col + ball_size) and pixel_row > (ball_row - ball_size) and pixel_row < (ball_row + ball_size) ) then 
		ball_on_RED <= '1';
		ball_on_GREEN <= '0';
		ball_on_BLUE <= '1';
	end if;
	
----DRAW CIRCLES GREEN----
-- inner to outer circles --
	if(480*conv_integer(pixel_row)-conv_integer(pixel_row)*conv_integer(pixel_row)+640*conv_integer(pixel_column)-conv_integer(pixel_column)*conv_integer(pixel_column))> 158000
		and (480*conv_integer(pixel_row)-conv_integer(pixel_row)*conv_integer(pixel_row)+640*conv_integer(pixel_column)-conv_integer(pixel_column)*conv_integer(pixel_column))< 158089  then
		ball_on_red <= '0';
		ball_on_green <= '1';
		ball_on_blue <= '0';
	end if;

	if(480*conv_integer(pixel_row)-conv_integer(pixel_row)*conv_integer(pixel_row)+640*conv_integer(pixel_column)-conv_integer(pixel_column)*conv_integer(pixel_column))> 155000
		and (480*conv_integer(pixel_row)-conv_integer(pixel_row)*conv_integer(pixel_row)+640*conv_integer(pixel_column)-conv_integer(pixel_column)*conv_integer(pixel_column))< 155159  then
		ball_on_red <= '0';
        ball_on_green <= '1';
        ball_on_blue <= '0';
	end if;

	if(480*conv_integer(pixel_row)-conv_integer(pixel_row)*conv_integer(pixel_row)+640*conv_integer(pixel_column)-conv_integer(pixel_column)*conv_integer(pixel_column))> 151000
		and (480*conv_integer(pixel_row)-conv_integer(pixel_row)*conv_integer(pixel_row)+640*conv_integer(pixel_column)-conv_integer(pixel_column)*conv_integer(pixel_column))< 151219  then
		ball_on_red <= '0';
        ball_on_green <= '1';
        ball_on_blue <= '0';
	end if;

	if(480*conv_integer(pixel_row)-conv_integer(pixel_row)*conv_integer(pixel_row)+640*conv_integer(pixel_column)-conv_integer(pixel_column)*conv_integer(pixel_column))> 145000
		and (480*conv_integer(pixel_row)-conv_integer(pixel_row)*conv_integer(pixel_row)+640*conv_integer(pixel_column)-conv_integer(pixel_column)*conv_integer(pixel_column))< 145259  then
		ball_on_red <= '0';
        ball_on_green <= '1';
        ball_on_blue <= '0';
	end if;

	if(480*conv_integer(pixel_row)-conv_integer(pixel_row)*conv_integer(pixel_row)+640*conv_integer(pixel_column)-conv_integer(pixel_column)*conv_integer(pixel_column))> 137000
		and (480*conv_integer(pixel_row)-conv_integer(pixel_row)*conv_integer(pixel_row)+640*conv_integer(pixel_column)-conv_integer(pixel_column)*conv_integer(pixel_column))< 137319  then
		ball_on_red <= '0';
        ball_on_green <= '1';
        ball_on_blue <= '0';
	end if;

	if(480*conv_integer(pixel_row)-conv_integer(pixel_row)*conv_integer(pixel_row)+640*conv_integer(pixel_column)-conv_integer(pixel_column)*conv_integer(pixel_column))> 125000
		and (480*conv_integer(pixel_row)-conv_integer(pixel_row)*conv_integer(pixel_row)+640*conv_integer(pixel_column)-conv_integer(pixel_column)*conv_integer(pixel_column))< 125429  then
		ball_on_red <= '0';
        ball_on_green <= '1';
        ball_on_blue <= '0';
	end if;

	if(480*conv_integer(pixel_row)-conv_integer(pixel_row)*conv_integer(pixel_row)+640*conv_integer(pixel_column)-conv_integer(pixel_column)*conv_integer(pixel_column))> 110000
		and (480*conv_integer(pixel_row)-conv_integer(pixel_row)*conv_integer(pixel_row)+640*conv_integer(pixel_column)-conv_integer(pixel_column)*conv_integer(pixel_column))< 110419  then
		ball_on_red <= '0';
        ball_on_green <= '1';
        ball_on_blue <= '0';
	end if;
--
		
end if;  
end process;

end Behavior;
