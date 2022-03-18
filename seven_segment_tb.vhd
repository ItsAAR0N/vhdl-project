----------------------------------------------------------------------------------
-- Company: Unversity of Strathclyde
-- Engineer: Aaron Shek, Jack Kellet
-- 
-- Create Date: 18.03.2022 10:37:18
-- Design Name: Seven Segment - (Primary)
-- Module Name: seven_segment - Behavioral
-- Project Name: Seven Segment Display Project
-- Target Devices: VHDL
-- Tool Versions: N/A
-- Description: FPGA design to display DDMM of 3 birthdays on 7-segment display following a unique LED sequence. Changeable using switches.
-- 
-- Dependencies: N/A
-- 
-- Revision: V0.01
-- Revision 0.01 - File Created
-- Additional Comments: N/A
-- 
----------------------------------------------------------------------------------

-- LIBRARY DECLARATION
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- +----------------------------------+
-- | Entitiy Declaration (interfaces) |
-- +----------------------------------+
entity seven_segment_tb is
--  Port ( );
end seven_segment_tb;


-- +--------------------------+
-- | Architecture design body |
-- +--------------------------+
architecture Behavioral of seven_segment_tb is

-- Component Declaration for UUT
component seven_segment is
    Port ( Clk_In : in STD_LOGIC; -- Clock
           Reset : in STD_LOGIC; -- Reset switch
           Switch_One : in STD_LOGIC; -- First DOB
           Switch_Two : in STD_LOGIC; -- Second DOB
           Switch_Three : in STD_LOGIC; -- Third DOB
           Led_Sequence_Out : out STD_LOGIC_VECTOR (15 downto 0); -- Display unique sequence on LEDs
           Seg_Leds_Out : out STD_LOGIC_VECTOR (6 downto 0)); -- Display MMDD on 7-seven display     
end component;

-- Signals required to test design (Not synthesized)

signal Clk_In, Reset, Enable, Switch_One, Switch_Two, Switch_Three : std_logic;
signal Led_Sequence_Out : std_logic_vector(15 downto 0);

-- Clock period - Actual clock input is 100MHz (see just above the "Basys 3" logo on the board)
constant T_clk : time := 10 ns;

-- Divided clock period (Useful for specifying stimulus - short periods between changes)
constant sim_clk : time := 5 * T_clk;

-- number of clock cycles to simulate
constant n_cycles : integer := 10000;

begin

-- Instantiation of seven_segment, unit under test (UUT)

UUT : seven_segment
port map (Clk_In => Clk_In, Reset => Reset, Switch_One => Switch_One,  Switch_Two => Switch_Two,  Switch_Three => Switch_Three, Led_Sequence_Out => Led_Sequence_Out);

-- Stimulus Process, create all input signals, clock excluded

stimulus : process is

    begin 
        
        Reset <= '0'; Enable <= '1'; Switch_One <= '1'; Switch_Two <= '0'; Switch_Three <= '0'; wait for 2 us;
        Reset <= '0'; Enable <= '1'; Switch_One <= '0'; Switch_Two <= '1'; Switch_Three <= '0'; wait for 2 us;
        Reset <= '0'; Enable <= '1'; Switch_One <= '0'; Switch_Two <= '0'; Switch_Three <= '1'; wait for 2 us;
        Reset <= '0'; Enable <= '1'; Switch_One <= '1'; Switch_Two <= '0'; Switch_Three <= '1'; wait for 2 us;
        
        wait;
        
end process;

   -- Clock generator process

   clk_gen : process is
   
   begin
     
     while now <= (n_cycles*sim_clk) loop       
       
         clk_in <= '1'; wait for T_clk/2;
         clk_in <= '0'; wait for T_clk/2;
         
       end loop;
	
	wait;
       
   end process;

end Behavioral;
