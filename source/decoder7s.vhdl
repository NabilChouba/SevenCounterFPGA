
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY decoder7s IS
PORT ( D   :IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
       S7Display :OUT STD_LOGIC_VECTOR(6 DOWNTO 0)); 
END decoder7s;

ARCHITECTURE RTL OF decoder7s IS
 BEGIN
  PROCESS (D)
  BEGIN 
    CASE D IS      --GFEDCBA--  (0:OFF - 1:ON)
      WHEN "0000"=>
        S7Display <="0111111"; -- Display 0  
      WHEN "0001"=>
        S7Display <="0000110"; -- Display 1  
      WHEN "0010"=>
        S7Display <="1011011"; -- Display 2
      WHEN "0011"=>
        S7Display <="1001111"; -- Display 3
      WHEN "0100"=>
        S7Display <="1100110"; -- Display 4
      WHEN "0101"=>
        S7Display <="1101101"; -- Display 5
      WHEN "0110"=>
        S7Display <="1111100"; -- Display 6
      WHEN "0111"=>
        S7Display <="0000111"; -- Display 7
      WHEN "1000"=>
        S7Display <="1111111"; -- Display 8
      WHEN "1001"=>
        S7Display <="1100111"; -- Display 9
      WHEN OTHERS=>
        S7Display <="1111001"; -- Display E : Error
    END CASE;

  END PROCESS;

END RTL;
