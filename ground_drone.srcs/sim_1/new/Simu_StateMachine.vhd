----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2021 12:16:44 PM
-- Design Name: 
-- Module Name: TB_StateMachine - Behavioral
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

entity TB_StateMachine is
--  Port ( );
end TB_StateMachine;
    
    
architecture Behavioral of TB_StateMachine is

    component Start_StateMachine is
    Port ( S_S : in STD_LOGIC;  
           RST : in STD_LOGIC;  
           CLK : in STD_LOGIC;  
           ENABLE_OUT : out STD_LOGIC);
    end component;
   
    signal Button : STD_LOGIC := '0';
    signal Reset : STD_LOGIC := '0';
    signal Iclk : STD_LOGIC := '0';
    signal MoveEnable : STD_LOGIC;  
    constant clk_period : time := 20 ns;
    
    signal ff1 : std_logic;
    signal ff2 : std_logic;
    signal feve: std_logic;
       
begin
BLOCK1: Start_StateMachine PORT MAP ( S_S => Button,
                                      RST => Reset,
                                      CLK => Iclk,
                                      ENABLE_OUT => MoveEnable);
clk_process: process
begin
    Iclk <= '0';
    wait for clk_period/2;
    Iclk <= '1';
    wait for clk_period/2;
end process;

stim1_process: process
begin
    Button <= '0';
    wait for 5 us;
    Button <= '1';
    wait for 1 us ;
end process;

stim2_process: process
begin
    Reset <= '0';
    wait for 14 us;
    Reset <= '1';
    wait for 1 us;
    Reset <= '0';
    wait for 5 us;
    Reset <= '1';
    wait for 1 us;
end process;

end Behavioral;
