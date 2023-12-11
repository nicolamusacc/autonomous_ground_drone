----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/15/2021 11:30:53 AM
-- Design Name: 
-- Module Name: Simu_Direction - Behavioral
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

entity TB_Direction is
--  Port ( );
end TB_Direction;

architecture Behavioral of TB_Direction is
    signal MoveEnable : STD_LOGIC := '1';
    signal SensRight : STD_LOGIC := '0';
    signal SensLeft : STD_LOGIC := '0';
    signal PWM_Low : STD_LOGIC;
    signal PWM_Med : STD_LOGIC;
    signal PWM_High : STD_LOGIC;
    component Direction is
    Port ( ENABLE_IN : in STD_LOGIC;
               SEN_RIGHT : in STD_LOGIC;
               SEN_LEFT : in STD_LOGIC;
               PWM_L_IN : in STD_LOGIC;
               PWM_M_IN : in STD_LOGIC;
               PWM_H_IN : in STD_LOGIC;
               MOT_RIGHT : out STD_LOGIC;
               MOT_LEFT : out STD_LOGIC);
    end component;
    signal MotorRight : STD_LOGIC;
    signal MotorLeft : STD_LOGIC;
    constant clk_period : time := 20 ms;
begin
DIRECTION_BLOCK : Direction PORT MAP ( ENABLE_IN => MoveEnable,
                                           SEN_RIGHT => SensRight,
                                           SEN_LEFT => SensLeft,
                                           PWM_L_IN => PWM_Low,
                                           PWM_M_IN => PWM_Med,
                                           PWM_H_IN => PWM_High,
                                           MOT_RIGHT => MotorRight,
                                           MOT_LEFT => MotorLeft);
                                     
PWM_25: process
begin
    PWM_Low <= '1';
    wait for clk_period/4;
    PWM_Low <= '0';
    wait for 3*clk_period/4;
end process;

PWM_50: process
begin
    PWM_Med <= '1';
    wait for clk_period/2;
    PWM_Med <= '0';
    wait for clk_period/2;
end process;

PWM_95: process
begin
    PWM_High <= '1';
    wait for 9*clk_period/10;
    PWM_High <= '0';
    wait for clk_period/10;
end process;

stim : process
begin
    wait for 100 ms;
    SensRight <= '1';
    wait for 100 ms;
    SensRight <= '0';
    wait for 100 ms;
    SensLeft <= '1';
    wait for 100 ms;
    SensLeft <= '0';
    wait for 100 ms;
    SensLeft <= '1';
    SensRight <= '1';
    wait for 100 ms;
    MoveEnable <= '0';
    wait for 100 ms;
    SensLeft <= '0';
    SensRight <= '0';
end process;

end Behavioral;
