# radar_implementation_on_fpga
----------------------------------------------------------------------------------
-- Create Date: 06.05.2018 19:31:14
-- Design Name: Ultrasonic Radar Implementation 
-- Module Name: project - Behavioral
-- Project Name: Ultrasonic Radar Implementation
-- Target Devices: Arty Z7 FPGA Board
-- Additional Comments: ** You can copy this source code to Vivado as a TOP MODULE ** 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity project is
port( pin_sysclk  : in std_logic;  -- master clock from external clock source 100MHz
      pin_vga_red1 : out std_logic;
      pin_vga_green1 : out std_logic;
      pin_vga_blue1 : out std_logic;
      pin_vga_hsync_n : out std_logic;
      pin_vga_vsync_n : out std_logic;
	  start : in std_logic; -- servo motor on if switch equal to 1 
	  pin_trig	: out std_logic; -- ultrasonic trig signal
	  pin_echo	: in std_logic; -- ultrasonic echo signal
	  servo_control : out std_logic); -- servo motor pwm
end entity;

architecture Behavioral of project is
signal sysClk : std_logic;  -- system clock
signal ball_red : std_logic;
signal ball_green : std_logic;
signal ball_blue : std_logic; 
signal clk_25mhz : std_logic := '0';
signal vga_pixel_row : std_logic_vector(9 downto 0);
signal vga_pixel_column : std_logic_vector(9 downto 0);
signal vga_vert_sync_out : std_logic;
signal vga_horizantal_sync_out : std_logic;
signal distance_v : integer :=0 ;
signal sensor_location : std_logic_vector (7 downto 0);
		
component ultrasonic_code
port( clk : in std_logic;
	  echo : in std_logic;
	  trig : out std_logic;
	  distance_value : out integer);
end component;

component vga_sync
port( clock_25Mhz, red, green, blue : in std_logic;
      red_out, green_out, blue_out, horiz_sync_out, vert_sync_out : out std_logic;
      pixel_row, pixel_column : out std_logic_vector(9 downto 0));
end component;

component radar_screen
port( distance_radar: in integer;
	  vert_sync_out, horiz_sync_out : in std_logic;
	  pixel_row, pixel_column : in std_logic_vector(9 downto 0);
	  red, green, blue : out std_logic;
	  sensor_loc_in : in std_logic_vector (7 downto 0));	
end component;

component servo_motor
port( clk : in std_logic;
	  sw : in std_logic; 
	  sensor_loc_out : out std_logic_vector ( 7 downto 0);		
	  pwm : out std_logic);
end component;
	
begin

------------- pin_sysclk = 100MHz to 25MHz clock--------------
process(pin_sysclk)
variable counter : integer range 0 to 4 := 0;
begin
if rising_edge(pin_sysclk) then
   if counter = 3 then
      counter := 0;
      clk_25mhz <= '1';
   else
      counter := counter + 1;
      clk_25mhz <= '0';
	end if;
end if;
end process;


pin_vga_hsync_n <= vga_horizantal_sync_out;
pin_vga_vsync_n <= vga_vert_sync_out;
sysClk <= clk_25mhz;


VGA_DRIVER:
vga_sync port map(
clock_25Mhz    => sysClk, -- 25MHz clock for vga
red            => ball_red,
green          => ball_green,
blue           => ball_blue,
red_out        => pin_vga_red1, -- pin red
green_out      => pin_vga_green1, -- pin green
blue_out       => pin_vga_blue1, -- pin blue
horiz_sync_out => vga_horizantal_sync_out, -- pin_vga_hsync_n
vert_sync_out  => vga_vert_sync_out, -- pin_vga_vsync_n
pixel_row      => vga_pixel_row,
pixel_column   => vga_pixel_column );

ULTRASONIC_DRIVER:
ultrasonic_code port map(
clk		    => pin_sysclk, -- 100MHz clock
echo		=> pin_echo, -- echo signal
trig		=> pin_trig, -- trig signal
distance_value => distance_v ); -- distance value calculated by ultrasonic

RADAR_DRIVER:
radar_screen port map(
distance_radar			=> distance_v, -- distance value calculated by ultrasonic
vert_sync_out 		 	=> vga_vert_sync_out, -- pin_vga_vsync_n
horiz_sync_out      	=> vga_horizantal_sync_out, -- pin_vga_hsync_n
pixel_row      		    => vga_pixel_row,
pixel_column   		    => vga_pixel_column,
red           		 	=> ball_red,
green					=> ball_green,
blue          		 	=> ball_blue,
sensor_loc_in  		    => sensor_location);

SERVO_DRIVER: 
servo_motor port map(
clk 			=> pin_sysclk,
sw 				=> start,
pwm 			=> servo_control,
sensor_loc_out  => sensor_location);
	
end Behavioral;
