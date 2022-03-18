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
entity seven_segment is
    Port ( Clk_In : in STD_LOGIC; -- Clock
           Reset : in STD_LOGIC; -- Reset switch
           Switch_One : in STD_LOGIC; -- First DOB
           Switch_Two : in STD_LOGIC; -- Second DOB
           Switch_Three : in STD_LOGIC; -- Third DOB
           Led_Sequence_Out : out STD_LOGIC_VECTOR (15 downto 0); -- Display unique sequence on LEDs
           Seg_Leds_Out : out STD_LOGIC_VECTOR (6 downto 0)); -- Display MMDD on 7-seven display     
end seven_segment;

-- +--------------------------+
-- | Architecture design body |
-- +--------------------------+
architecture Behavioral of seven_segment is

-- CONSTANTS

--constant max_count : integer := 6250000;    -- Must count to this number to divide clock frequency from 100MHz to 8Hz.
constant Max_count : integer := 5;           -- For simulation only (easier to check output!)

-- INTERNAL SIGNALS
signal CLK : std_logic;                         -- This is the divided clock (i.e. frequency of 8Hz)

begin

  -- clock divider process
  ---------------------------------
  Clk_Divide : process (Clk_In) is
  
  variable Count : unsigned(22 downto 0):= to_unsigned(0,23);   -- Required to count up to 6,250,000!
  variable Clk_Int : std_logic := '0';                          -- This is a clock internal to the process
  
  begin
    
    if rising_edge(Clk_In) then
      
      if Count < (Max_count - 1) then     -- Highest value count should reach is 6,249,999.
        Count := Count + 1;           -- Increment counter
      else
        Count := to_unsigned(0,23);   -- Reset count to zero
        clk_int := not clk_int;       -- Invert clock variable every time counter resets
      end if;
      
      Clk <= Clk_Int;                 -- Assign clock variable to internal clock signal
      
    end if;
    
  end process;
  
  sequence_generator : process (Clk) is

  variable count : unsigned(3 downto 0) := "0000";   -- 16 steps in the sequence...
  
  begin
         
    if rising_edge(clk) then
      
      if (reset = '1') then
      
           count := "0000";
      
      else
           
           count := count + 1;
      
      end if;

    end if;

  -- Use counter value to determine LED outputs & Switches
  ----------------------------------------------
  if Switch_One = '1' then
  
        case to_integer(count) is 
      
        when 0 =>   
          Led_Sequence_Out <= "0000001111000000";         
        when 1 =>    
           Led_Sequence_Out <= "0000011001100000";    
        when 2 =>     
          Led_Sequence_Out <= "0000110000110000";   
        when 3 =>    
          Led_Sequence_Out <= "0001100000011000"; 
        when 4 =>    
          Led_Sequence_Out <= "0011000000001100";
        when 5 =>    
          Led_Sequence_Out <= "0110000000000110";   
        when 6 =>    
          Led_Sequence_Out <= "1100000000000011";  
        when 7 =>    
          Led_Sequence_Out <= "1010000000000101";    
        when 8 =>    
          Led_Sequence_Out <= "0101000000001010";  
        when 9 =>    
          Led_Sequence_Out <= "0010100000010100";  
        when 10 =>    
          Led_Sequence_Out <= "0001010000101000";  
        when 11 =>    
          Led_Sequence_Out <= "0000101001010000";  
        when 12 =>    
          Led_Sequence_Out <= "0000010110100000";  
        when 13 =>    
          Led_Sequence_Out <= "0000001111000000";  
        when 14 =>    
          Led_Sequence_Out <= "0000001111000000";              
        when 15 =>
          Led_Sequence_Out <= "0000010110100000";                          
        when others =>
          Led_Sequence_Out <= (others => '1');   -- set all LEDs to ON if anything unexpected happens!      
           
        end case;
        
        else if Switch_Two = '1' then
        
            case to_integer(count) is 
            
            when 0 =>   
              Led_Sequence_Out <= "1111111111111111";         
            when 1 =>    
               Led_Sequence_Out <= "0000000000000000";    
            when 2 =>     
              Led_Sequence_Out <= "1111111111111111";   
            when 3 =>    
              Led_Sequence_Out <= "0000000000000000"; 
            when 4 =>    
              Led_Sequence_Out <= "1111111111111111";
            when 5 =>    
              Led_Sequence_Out <= "0000000000000000";   
            when 6 =>    
              Led_Sequence_Out <= "1111111111111111";  
            when 7 =>    
              Led_Sequence_Out <= "0000000000000000";    
            when 8 =>    
              Led_Sequence_Out <= "1111111111111111";  
            when 9 =>    
              Led_Sequence_Out <= "0000000000000000";  
            when 10 =>    
              Led_Sequence_Out <= "1111111111111111";  
            when 11 =>    
              Led_Sequence_Out <= "0000000000000000";  
            when 12 =>    
              Led_Sequence_Out <= "1111111111111111";  
            when 13 =>    
              Led_Sequence_Out <= "0000000000000000";  
            when 14 =>    
              Led_Sequence_Out <= "1111111111111111";              
            when 15 =>
              Led_Sequence_Out <= "0000000000000000";                          
            when others =>
              Led_Sequence_Out <= (others => '1');   -- Set all LEDs to ON if anything unexpected happens!      
               
            end case;  
            
            else if Switch_Three = '1' then
            
                case to_integer(count) is 
                
                when 0 =>   
                  Led_Sequence_Out <= "1000000000000000";         
                when 1 =>    
                   Led_Sequence_Out <= "0100000000000000";    
                when 2 =>     
                  Led_Sequence_Out <= "0010000000000000";   
                when 3 =>    
                  Led_Sequence_Out <= "0001000000000000"; 
                when 4 =>    
                  Led_Sequence_Out <= "0000100000000000";
                when 5 =>    
                  Led_Sequence_Out <= "0000010000000000";   
                when 6 =>    
                  Led_Sequence_Out <= "0000001000000000";  
                when 7 =>    
                  Led_Sequence_Out <= "0000000100000000";    
                when 8 =>    
                  Led_Sequence_Out <= "0000000010000000";  
                when 9 =>    
                  Led_Sequence_Out <= "0000000001000000";  
                when 10 =>    
                  Led_Sequence_Out <= "0000000000100000";  
                when 11 =>    
                  Led_Sequence_Out <= "0000000000010000";  
                when 12 =>    
                  Led_Sequence_Out <= "0000000000001000";  
                when 13 =>    
                  Led_Sequence_Out <= "0000000000000100";  
                when 14 =>    
                  Led_Sequence_Out <= "0000000000000010";              
                when 15 =>
                  Led_Sequence_Out <= "0000000000000001";                          
                when others =>
                  Led_Sequence_Out <= (others => '1');   -- Set all LEDs to ON if anything unexpected happens!       
                  
                end case;
                
             else 
                  Led_Sequence_Out <= "0000000000000000"; -- If all else conditions not met
                  
            end if;
    
        end if;
    
    end if;
    
  end process;
   
end Behavioral;
