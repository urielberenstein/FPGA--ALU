library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hold_8b is
  Port (A : in std_logic_vector (7 downto 0);
        Cin : in std_logic;
        F : out std_logic_vector (8 downto 0) );
end hold_8b;

architecture Structural of hold_8b is

component hold is
    Port (A : in std_logic;
          F : out std_logic );
end component;

begin

hold_0 : hold port map (A => A(0),
                        F => F(0));
                        
hold_1 : hold port map (A => A(1),
                        F => F(1));
                        
hold_2 : hold port map (A => A(2),
                        F => F(2));
                        
hold_3 : hold port map (A => A(3),
                        F => F(3));
                        
hold_4 : hold port map (A => A(4),
                        F => F(4));
                        
hold_5 : hold port map (A => A(5),
                        F => F(5));
                        
hold_6 : hold port map (A => A(6),
                        F => F(6));
                        
hold_7 : hold port map (A => A(7),
                        F => F(7));
                        
F(8) <= Cin;                     


end Structural;
