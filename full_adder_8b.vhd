library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity full_adder_8b is
    Port (A, B : in std_logic_vector (7 downto 0);
      Cin : in std_logic;
      Sum : out std_logic_vector (7 downto 0);
      Cout : out std_logic);
end full_adder_8b;

architecture Structural of full_adder_8b is

component full_adder_4b is
    Port (A, B : in std_logic_vector (3 downto 0);
          Cin : in std_logic;
          Cout : out std_logic;
          Sum : out std_logic_vector (3 downto 0));
end component;

-- middle signals
signal Cin_1 : std_logic;

begin

adder_4b0 : full_adder_4b port map (A => A(3 downto 0),
                                    B => B(3 downto 0),
                                    Cin => Cin,
                                    Cout => Cin_1,
                                    Sum => Sum(3 downto 0) );

adder_4b1 : full_adder_4b port map (A => A(7 downto 4),
                                    B => B(7 downto 4),
                                    Cin => Cin_1,
                                    Cout => Cout,
                                    Sum => Sum(7 downto 4));

end Structural;
