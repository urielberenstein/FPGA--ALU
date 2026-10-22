library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEMORY is
  Port (clk : in std_logic;
        address_in : in std_logic_vector (3 downto 0);
        rd : in std_logic;
        WR : in std_logic;
        data_bus : inout std_logic_vector (7 downto 0) );
end MEMORY;

architecture Behavioral of MEMORY is

type ram_type is array (0 to 15) of std_logic_vector (7 downto 0);
signal ram : ram_type := (others => (others => '0'));

begin

process (clk)
begin
    if rising_edge(clk) then
        if WR = '1' then
            ram(to_integer(unsigned(address_in))) <= data_bus;
        end if;
    end if;
end process;

data_bus <= ram(to_integer(unsigned(address_in))) when rd = '1' 
           else (others => 'Z');

end Behavioral;
