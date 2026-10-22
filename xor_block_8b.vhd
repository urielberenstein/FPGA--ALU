library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity xor_block_8b is
    Port (A, B : in std_logic_vector (7 downto 0);
          Cin : in std_logic;
          F : out std_logic_vector (8 downto 0));
end xor_block_8b;

architecture Structural of xor_block_8b is

component xor_block is
 Port (A, B : in std_logic;
       F : out std_logic );
end component;

begin

xor_block_0 : xor_block port map (A => A (0),
                                  B => B (0),
                                  F => F (0));
                                
xor_block_1 : xor_block port map (A => A (1),
                                  B => B (1),
                                  F => F (1));

xor_block_2 : xor_block port map (A => A (2),
                                  B => B (2),
                                  F => F (2));
                                
xor_block_3 : xor_block port map (A => A (3),
                                  B => B (3),
                                  F => F (3));
                                
xor_block_4 : xor_block port map (A => A (4),
                                  B => B (4),
                                  F => F (4));
                                
xor_block_5 : xor_block port map (A => A (5),
                                  B => B (5),
                                  F => F (5));
                                
xor_block_6 : xor_block port map (A => A (6),
                                  B => B (6),
                                  F => F (6));
                                
xor_block_7 : xor_block port map (A => A (7),
                                  B => B (7),
                                  F => F (7)); 

F(8) <= Cin;   

end Structural;
