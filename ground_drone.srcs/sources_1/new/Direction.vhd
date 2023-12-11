----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/15/2021 09:58:11 AM
-- Design Name: 
-- Module Name: Direction - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Direction is
    Port ( ENABLE_IN : in STD_LOGIC;
           SEN_RIGHT : in STD_LOGIC;
           SEN_LEFT : in STD_LOGIC;
           PWM_L_IN : in STD_LOGIC;
           PWM_M_IN : in STD_LOGIC;
           PWM_H_IN : in STD_LOGIC;
           MOT_RIGHT : out STD_LOGIC;
           MOT_LEFT : out STD_LOGIC);
end Direction;

architecture Behavioral of Direction is
signal sens: std_logic_vector(2 downto 0);
begin
    sens <= ENABLE_IN & SEN_LEFT & SEN_RIGHT;
    -- Motor Right
    process (sens, PWM_L_IN, PWM_M_IN, PWM_H_IN)
    begin
        case sens is
            when "100" => MOT_RIGHT <= PWM_H_IN;
            when "101" => MOT_RIGHT <= PWM_L_IN; -- turn right
            when "110" => MOT_RIGHT <= PWM_H_IN; -- turn left
            when "111" => MOT_RIGHT <= PWM_M_IN; -- lost
            when others => MOT_RIGHT <= '0'; -- ENABLE = 0
        end case;
    end process;
    -- Motor Left
    process (sens, PWM_L_IN, PWM_M_IN, PWM_H_IN)
    begin
        case sens is
            when "100" => MOT_LEFT <=PWM_H_IN;
            when "101" => MOT_LEFT <=PWM_H_IN; -- turn right
            when "110" => MOT_LEFT <=PWM_L_IN; -- turn left
            when "111" => MOT_LEFT <=PWM_M_IN; -- lost
            when others => MOT_LEFT <='0'; -- ENABLE = 0
        end case;
    end process;  
end Behavioral;
