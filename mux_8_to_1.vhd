library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_8_to_1 is
    Port (I0, I1, I2, I3, I4, I5, I6, I7 : in std_logic_vector (8 downto 0);
          S : in std_logic_vector (2 downto 0);
          F : out std_logic_vector (8 downto 0) );
end mux_8_to_1;

architecture Behavioral of mux_8_to_1 is

constant op_addWC : std_logic_vector (2 downto 0):= "000";
constant op_addNC : std_logic_vector (2 downto 0):= "001";
constant op_xor : std_logic_vector (2 downto 0):= "010";
constant op_load : std_logic_vector (2 downto 0):= "011";
constant op_hold : std_logic_vector (2 downto 0):= "100";

begin

F <= I0 when S = op_addWC else
     I1 when S = op_addNC else
     I2 when S = op_xor else
     I3 when S = op_load else
     I4 when S = op_hold else
     I5 when S = "101" else
     I6 when S = "110" else
     I7 when S = "111";
     
end Behavioral;
