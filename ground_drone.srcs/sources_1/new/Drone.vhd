----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2021 11:37:08 AM
-- Design Name: 
-- Module Name: Drone - Behavioral
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

entity Drone is
    Port ( SensRight : in STD_LOGIC;
           SensLeft : in STD_LOGIC;
           BP_Start_Stop : in STD_LOGIC;
           BP_Reset : in STD_LOGIC;
           Clock : in STD_LOGIC;
           MotorRight_pos : out STD_LOGIC;
           MotorRight_neg : out STD_LOGIC;
           MotorLeft_pos : out STD_LOGIC;
           MotorLeft_neg : out STD_LOGIC--;
           --Display : out STD_LOGIC_VECTOR(6 dwonto 0);
           --AN : out STD_LOGIC_VECTOR(6 dwonto 0)
           );
end Drone;

architecture Behavioral of Drone is
    signal MoveEnable : STD_LOGIC;
    signal PWM_Low : STD_LOGIC;
    signal PWM_Med : STD_LOGIC;
    signal PWM_High : STD_LOGIC;
    
    component Start_StateMachine is
    Port ( S_S : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           ENABLE_OUT : out STD_LOGIC);
    end component;
   
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
    
    component Speed is
    Port ( CLK : in STD_LOGIC;
           PWM_L_OUT : out STD_LOGIC;
           PWM_M_OUT : out STD_LOGIC;
           PWM_H_OUT : out STD_LOGIC);
    end component;
    
begin
    MotorRight_neg <= '0';
    MotorLeft_neg <= '0';
    CONTROL_BLOCK: Start_StateMachine PORT MAP ( S_S => BP_Start_Stop,
                                                 RST => BP_Reset,
                                                 CLK => Clock,
                                                 ENABLE_OUT => MoveEnable);
                                          
    DIRECTION_BLOCK : Direction PORT MAP ( ENABLE_IN => MoveEnable,
                                           SEN_RIGHT => SensRight,
                                           SEN_LEFT => SensLeft,
                                           PWM_L_IN => PWM_Low,
                                           PWM_M_IN => PWM_Med,
                                           PWM_H_IN => PWM_High,
                                           MOT_RIGHT => MotorRight_pos,
                                           MOT_LEFT => MotorLeft_pos);
                                           
    SPEED_BLOCK : Speed PORT MAP ( CLK => Clock,
                                   PWM_L_OUT => PWM_Low,
                                   PWM_M_OUT => PWM_Med,
                                   PWM_H_OUT => PWM_High);   
end Behavioral;
