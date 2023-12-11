----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/15/2021 04:47:12 PM
-- Design Name: 
-- Module Name: TB_Drone - Behavioral
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

entity TB_Drone is
--  Port ( );
end TB_Drone;

architecture Behavioral of TB_Drone is
constant clk_period : time := 20 ns;
component Drone is
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
end component;
-- INPUTS
signal SenR_ex : STD_LOGIC := '0';
signal SenL_ex : STD_LOGIC := '0';
signal SS_ex : STD_LOGIC := '0';
signal Reset_ex : STD_LOGIC := '0';
signal Clock_ex : STD_LOGIC := '0';
-- OUTPUTS
signal MotorR_pos_ex : STD_LOGIC;
signal MotorR_neg_ex : STD_LOGIC;
signal MotorL_pos_ex : STD_LOGIC;
signal MotorL_neg_ex : STD_LOGIC;

begin
MAIN_BLOCK : Drone PORT MAP ( SensRight => SenR_ex,
           SensLeft => SenL_ex,
           BP_Start_Stop => SS_ex,
           BP_Reset => Reset_ex,
           Clock => Clock_ex,
           MotorRight_pos => MotorR_pos_ex,
           MotorRight_neg => MotorR_neg_ex,
           MotorLeft_pos => MotorL_pos_ex,
           MotorLeft_neg => MotorL_neg_ex);
           
clk_process: process
begin
    Clock_ex <= '0';
    wait for clk_period/2;
    Clock_ex <= '1';
    wait for clk_period/2;
end process;

start : process
begin
    wait for 10 ms;
    SS_ex <= '1';
    wait for 2 ms;
    ss_ex <= '0';
    wait for 238 ms;
end process;

reset : process
begin
    wait for 245 ms;
    Reset_ex <= '1';
    wait for 2 ms;
    Reset_ex <= '0';
    wait for 3 ms;
end process;

stim : process
begin
    wait for 50 ms;
    SenR_ex <= '1';
    wait for 40 ms;
    SenR_ex <= '0';
    wait for 40 ms;
    SenL_ex <= '1';
    wait for 40 ms;
    SenL_ex <= '0';
    wait for 40 ms;
    SenL_ex <= '1';
    SenR_ex <= '1';
    wait for 40 ms;
    SenL_ex <= '0';
    SenR_ex <= '0';
end process;

end Behavioral;
