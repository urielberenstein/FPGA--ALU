library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
  Port (A, B : in std_logic_vector (7 downto 0);
        Cin : in std_logic;
        opcode : in std_logic_vector (2 downto 0);
        R : out std_logic_vector (8 downto 0) );
end ALU;

architecture Behavioral of ALU is

component mux_8_to_1 is
    Port (I0, I1, I2, I3, I4, I5, I6, I7 : in std_logic_vector (8 downto 0);
          S : in std_logic_vector (2 downto 0);
          F : out std_logic_vector (8 downto 0) );
end component;

component full_adder_8b is
    Port (A, B : in std_logic_vector (7 downto 0);
      Cin : in std_logic;
      Sum : out std_logic_vector (7 downto 0);
      Cout : out std_logic);
end component;

component xor_block_8b is
    Port (A, B : in std_logic_vector (7 downto 0);
          Cin : in std_logic;
          F : out std_logic_vector (8 downto 0));
end component;

component load_8b is
  Port (B : in std_logic_vector (7 downto 0);
        Cin : in std_logic;
        F : out std_logic_vector (8 downto 0) );
end component;

component hold_8b is
  Port (A : in std_logic_vector (7 downto 0);
        Cin : in std_logic;
        F : out std_logic_vector (8 downto 0) );
end component;

signal addWC : std_logic_vector (8 downto 0);
signal addNC : std_logic_vector (8 downto 0);
signal xor_s : std_logic_vector (8 downto 0);
signal hold_s : std_logic_vector (8 downto 0);
signal load_s : std_logic_vector (8 downto 0);

signal sumWC : std_logic_vector (7 downto 0);
signal coutWC : std_logic;
signal sumNC : std_logic_vector (7 downto 0);
signal coutNC : std_logic;

begin

mux : mux_8_to_1 port map (I0 => addWC,
                           I1 => addNC,
                           I2 => xor_s,
                           I3 => load_s,
                           I4 => hold_s,
                           I5 => "000000000",
                           I6 => "000000000",
                           I7 => "000000000",
                           S => opcode,
                           F => R);
                           
FA_WC : full_adder_8b port map (A => A(7 downto 0),
                                B => B(7 downto 0),
                                Cin => Cin,
                                Sum => sumWC,
                                Cout => coutWC);
                          
FA_NC : full_adder_8b port map (A => A(7 downto 0),
                                B => B(7 downto 0),
                                Cin => '0',
                                Sum => sumNC,
                                Cout => coutNC);

xor_block : xor_block_8b port map (A => A(7 downto 0),
                               B => B(7 downto 0),
                               Cin => Cin,
                               F => xor_s);
                               
hold_block : hold_8b port map (A => A(7 downto 0),
                               Cin => Cin,
                               F => hold_s);

load_block : load_8b port map (B => B(7 downto 0),
                               Cin => Cin,
                               F => load_s);                               

addWC <= coutWC & sumWC;
addNC <= coutNC & sumNC;

                                

end Behavioral;



