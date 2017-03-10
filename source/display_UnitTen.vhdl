library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all;  
use ieee.std_logic_signed.all; 

------------------------------------------------------------------------
-- entity                                                             --
------------------------------------------------------------------------

--  
--  
--  

entity display_UnitTen is
    port(  clk        : in    std_logic ;               
           rst        : in    std_logic ;               		  
	        inc : in    std_logic ;    
           Display_7s_ten : out std_logic_vector(6 downto 0) ;     
           Display_7s_unit : out std_logic_vector(6 downto 0)  
    );
end display_UnitTen ;

------------------------------------------------------------------------
-- architecture                                                       --
------------------------------------------------------------------------
architecture RTL of display_UnitTen is

 component  decoder7s IS
    PORT (  D         : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            S7Display : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    ) ;     
 END component;

 component counter IS
 PORT (  clk        : in    std_logic ; -- System Clock
         rst        : in    std_logic ; -- System Reset
	      inc        : in    std_logic ; -- count <= count + 1
	      rst_count  : in    std_logic ; -- Reset the conter count <= 0
         count      : OUT unsigned(3 DOWNTO 0) -- count value
      ); 
 END component;

-- increment unit +1
signal  inc_unit       : std_logic ;       
-- reset unit to 0
signal  rst_count_unit : std_logic ;    
--unit counter value
signal  count_unit     : unsigned(3 downto 0); 

-- increment ten +1
signal  inc_ten       : std_logic ;       
-- reset ten to 0
signal  rst_count_ten : std_logic ;    
--ten counter value
signal  count_ten     : unsigned(3 downto 0); 

-----------------------------------------------------------
-- Architectures                                         --
-----------------------------------------------------------
 begin

   counter_unit : counter 
     port map (  clk   => clk,
                 rst   => rst,
                 inc   => inc_unit,
                 rst_count => rst_count_unit,
                 count     =>count_unit
     );

   display7s_unit : decoder7s 
     port map ( D         => STD_LOGIC_VECTOR(count_unit),
                S7Display => Display_7s_unit
     );

   counter_ten : counter 
     port map (  clk   => clk,
               rst   => rst,	    
	            inc   => inc_ten,
	            rst_count => rst_count_ten,
               count     => count_ten
     );

  display7s_ten : decoder7s 
    port map ( D         => STD_LOGIC_VECTOR(count_ten),
             S7Display => Display_7s_ten
    );

   --contorle signal for unit counter
   inc_unit  <= inc;
   rst_count_unit <= '1' when  (count_unit = 10) else 
                '0';

   --contorle signal for ten counter 
   inc_ten       <= '1' when  (count_unit = 10) else 
                '0';
   rst_count_ten <= '1' when  (count_ten = 10) else 
                '0';
   
end RTL ;
------------------------------------------------------------------------
-- End of File                                                        --
------------------------------------------------------------------------
