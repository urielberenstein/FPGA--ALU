library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity load_8b is
  Port (B : in std_logic_vector (7 downto 0);
        Cin : in std_logic;
        F : out std_logic_vector (8 downto 0) );
end load_8b;

architecture Structural of load_8b is

component load is
    Port (B : in std_logic;
          F : out std_logic );
end component;


begin

load_0 : load port map (B => B(0),
                        F => F(0));
                        
load_1 : load port map (B => B(1),
                        F => F(1));
                        
load_2 : load port map (B => B(2),
                        F => F(2));
                        
load_3 : load port map (B => B(3),
                        F => F(3));
                        
load_4 : load port map (B => B(4),
                        F => F(4));
                        
load_5 : load port map (B => B(5),
                        F => F(5));
                        
load_6 : load port map (B => B(6),
                        F => F(6));
                        
load_7 : load port map (B => B(7),
                        F => F(7));
                        
F(8) <= Cin;   


end Structural;
