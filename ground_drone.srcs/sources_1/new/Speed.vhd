----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/15/2021 11:29:34 AM
-- Design Name: 
-- Module Name: Speed - Behavioral
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

entity Speed is
    Port ( CLK : in STD_LOGIC;
           PWM_L_OUT : out STD_LOGIC;
           PWM_M_OUT : out STD_LOGIC;
           PWM_H_OUT : out STD_LOGIC);
end Speed;

architecture Behavioral of Speed is
    signal PWMcnt: integer range 0 to 99 := 0;
    signal Rythm_cnt: integer range 0 to 9999 := 0;
    signal Rythm_CLK : STD_LOGIC := '0';

begin
--create the rythm signal 5kHz
process(CLK)
begin
if (CLK'event and CLK='1') then
    if (Rythm_cnt = 0) then
        Rythm_CLK <= '0';
        Rythm_cnt <= Rythm_cnt + 1;
    elsif (Rythm_cnt = 4999) then 
        Rythm_CLK <= '1';
        Rythm_cnt <= Rythm_cnt + 1;
    elsif (Rythm_cnt < 9999) then
        Rythm_cnt <= Rythm_cnt + 1;
    elsif (Rythm_cnt = 9999) then 
        Rythm_CLK <= '0';
        Rythm_cnt <= 0;
    end if; 
end if;
end process;
--create the PWM output (50 Hz)
process(Rythm_CLK)
begin 
if (Rythm_CLK'event and Rythm_CLK='1') then
    if (PWMcnt = 0) then
      PWM_L_OUT <= '1';
      PWM_M_OUT <= '1';
      PWM_H_OUT <= '1';
      PWMcnt <= PWMcnt + 1;
    elsif (PWMcnt = 14) then
      PWM_L_OUT <= '0';
      PWMcnt <= PWMcnt + 1;
    elsif (PWMcnt = 49) then
      PWM_M_OUT <= '0';
      PWMcnt <= PWMcnt + 1;
    elsif (PWMcnt = 94) then
      PWM_H_OUT <= '0';
      PWMcnt <= PWMcnt + 1;
    elsif (PWMcnt = 99) then 
      PWMcnt <= 0;
    else
     PWMcnt <= PWMcnt + 1;
    end if;
end if;
end process;  

end Behavioral;
