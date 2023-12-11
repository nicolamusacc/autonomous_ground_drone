----------------------------------------------------------------------------------                                   
-- Company:                                                                                                          
-- Engineer:                                                                                                         
--                                                                                                                   
-- Create Date: 11/09/2021 12:00:40 PM                                                                               
-- Design Name:                                                                                                      
-- Module Name: Start_StateMachine - Behavioral                                                                      
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
                                                                                                                     
entity Start_StateMachine is                                                                                         
    Port ( S_S : in STD_LOGIC;                                                                                       
           RST : in STD_LOGIC;                                                                                       
           CLK : in STD_LOGIC;                                                                                       
           ENABLE_OUT : out STD_LOGIC);                                                                                                          
end Start_StateMachine;                                                                                              
                                                                                                                     
architecture Behavioral of Start_StateMachine is                                                                     
    type state is (S0, S1);                                                                                          
    signal pr_state, nx_state: state;                                                                                
    signal ff1 : STD_LOGIC := '0';                                                                                   
    signal ff2 : STD_LOGIC := '0';                                                                                   
    signal ev : STD_LOGIC := '0';                                                                                     
                                                                             
begin                                                                                                                                                                                                                     
-- section 0: Event detector                                                                                    
ev <= ff1 and not ff2;                                                                                                               
process (CLK)                                                        
begin                                                                                                                
    if (CLK'event and CLK='1') then                                                                                  
    ff1 <= S_S; -- Synchronize input                                                                                     
    ff2 <= ff1; -- Detect event                                                                                 
    end if;                                                                                                          
end process;                                                                                                                       
-- section 1: fsm register                                                                                           
process (RST,CLK)                                                                                                    
begin                                                                                                                
    if (RST='1') then                                                                                                
    pr_state <= s0; -- choose reset state                                                                            
    elsif (CLK'event and CLK='1') then                                                                               
    pr_state <= nx_state;                                                                                            
    end if;                                                                                                          
end process;                                                                                                         
-- section 2: next state function                                                                                    
process (ev, pr_state)                                                                                               
begin                                                                                                                
case pr_state is                                                                                                     
    when S0 =>                                                                                                       
        if (ev = '1') then                                                                                           
        nx_state <= S1;                                                                                              
        else                                                                                                         
        nx_state <= S0;                                                                                              
        end if;                                                                                                      
    when S1 =>                                                                                                       
        if (ev = '1') then                                                                                           
        nx_state <= S0;                                                                                              
        else                                                                                                         
        nx_state <= S1;                                                                                              
        end if;                                                                                                      
end case;                                                                                                            
end process;                                                                                                         
-- section 3: output function                                                                                        
    ENABLE_OUT <= '1' when pr_state = S1 else '0';                                                                   
end Behavioral;