library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all;  
use ieee.std_logic_unsigned.all; 

------------------------------------------------------------------------
-- entity                                                             --
------------------------------------------------------------------------

--  
--  
--  

entity top is    port(
        clk        : in    std_logic ;               -- System Clock
        rst        : in    std_logic ;               -- System Reset
        push : in    std_logic ;               -- inc counter 0:red, 1:blue
	     Unit_R : out std_logic_vector(6 downto 0) ;     
        Ten_R : out std_logic_vector(6 downto 0)    
    );
end top ;

----------------------------------------------------------------------
-- architecture                                                       --
------------------------------------------------------------------------
architecture RTL of top is

component display_UnitTen is
    port(
        clk        : in    std_logic ;               -- System Clock
        rst        : in    std_logic ;               -- System Reset
        inc : in    std_logic ;                      -- inc counter
        Display_7s_ten : out std_logic_vector(6 downto 0) ;     
        Display_7s_unit : out std_logic_vector(6 downto 0)  
    );
end component ;

 
 component Upluse is
    Port ( clk  : in  STD_LOGIC;
           rst  : in  STD_LOGIC;
           push : in  STD_LOGIC;
           pulse: out  STD_LOGIC);
   end component;

signal pulse : std_logic;
-----------------------------------------------------------
-- Architectures                                         --
-----------------------------------------------------------
 begin

  
   display_UnitTen_R : display_UnitTen 
     port map (  clk   => clk,
                 rst   => rst,
	              inc   => pulse,
                 Display_7s_unit => Unit_R,
                 Display_7s_ten  => Ten_R
     );

  U_Upluse : Upluse 
     port map (  clk   => clk,
                 rst   => rst,
	              push  => push,
					  pulse   => pulse
               );

  
end RTL ;
------------------------------------------------------------------------
-- End of File                                                        --
------------------------------------------------------------------------
