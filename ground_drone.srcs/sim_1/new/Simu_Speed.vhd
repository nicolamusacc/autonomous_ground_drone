----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/15/2021 03:22:22 PM
-- Design Name: 
-- Module Name: Simu_Speed - Behavioral
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

entity TB_Speed is
--  Port ( );
end TB_Speed;

architecture Behavioral of TB_Speed is
component Speed
    Port (CLK : in STD_LOGIC;  --50 Mhz
          PWM_L_OUT : out STD_LOGIC; --50 kHz signals 
          PWM_M_OUT : out STD_LOGIC;
          PWM_H_OUT : out STD_LOGIC);
    end component;

signal Clk_50MHz : STD_LOGIC := '0';  --50 Mhz
signal PWM_Low : STD_LOGIC; --50 kHz signals 
signal PWM_Med : STD_LOGIC;
signal PWM_High : STD_LOGIC;
constant clock_period: time := 20 ns;

begin
SPEED_BLOCK: speed port map (CLK => Clk_50MHz,
                             PWM_L_OUT => PWM_Low,
                             PWM_M_OUT => PWM_Med,
                             PWM_H_OUT => PWM_High);
clk_process : process
begin
  Clk_50MHz <= '0';
  wait for clock_period/2;
  Clk_50MHz <= '1';
  wait for clock_period/2;
end process;

end Behavioral;
