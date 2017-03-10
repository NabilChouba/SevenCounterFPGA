----------------------------------------------------------------------------------
-- Company:  
-- Engineer: Nabil Chouba
-- 
-- Create Date:    10:51:24 04/16/2009 
-- Design Name: 
-- Module Name:    Upluse - rtl 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Upluse is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           push : in  STD_LOGIC;
           pulse : out  STD_LOGIC);
end Upluse;

architecture rtl of Upluse is

  signal count_filter_full    : std_logic ; 
  signal count_filter_reg , count_filter_next : std_logic_vector(15 downto 0)   ;  
 

  -- FSM States
   type state_type is (idle,wait_count,inc_dispaly,wait_released_noise,wait_released);
  -- FSM registers
  signal state_reg : state_type;
  signal state_next: state_type;


begin


 cloked_process : process( clk, rst )
  begin
    if( rst='1' ) then
      count_filter_reg  <= (others =>'0') ;
		state_reg <=  idle ;
    elsif( clk'event and clk='1' ) then
      count_filter_reg <= count_filter_next;
		state_reg<= state_next ;
		
    end if;
 end process ;
 
 
 COUNTER_GEN : process( state_reg,count_filter_reg )
    begin
     count_filter_next <= (others=>'0');
	  if( state_reg = wait_count  or state_reg = wait_released   ) then
            count_filter_next <= count_filter_reg + 1 ;
          
      end if ;
    
    end process ;
	 
  pulse <= '1' when state_reg = inc_dispaly else
        '0';
  
  
  count_filter_full <= '1' when count_filter_reg = "1111111111111111"  else
          '0';
			 
  
  --next state processing
  combinatory_FSM_next : process(state_reg, push,count_filter_full)
  begin
    state_next<= state_reg;
	  
    case state_reg is
    when idle =>
	 
      if push = '1' then
        state_next <= wait_count;  
      end if;

    when wait_count =>
	   if push = '0' then
		  state_next <= idle;
      elsif count_filter_full = '1' then
        state_next <= inc_dispaly;
      end if;
		
    when  inc_dispaly =>
	   state_next <= wait_released_noise;
		
	 when	wait_released_noise =>
	   if push = '0' then
		  state_next <= wait_released;
		end if;

	 when  wait_released =>
      if push = '1' then
		  state_next <= wait_released_noise;
		elsif count_filter_full = '1' then
		  state_next <= idle;
      end if;
		
    when others =>
    end case;
  end process;

end rtl;

