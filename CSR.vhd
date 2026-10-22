library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CSR is
  Port (clk, rst : in std_logic;
        next_state_in : in std_logic_vector (3 downto 0);
        current_state_out : out std_logic_vector (3 downto 0));
end CSR;

architecture Behavioral of CSR is

begin

process (clk, rst)
begin
-- active high, asynchronous reset
    if rst = '1' then 
        current_state_out <= (others => '0');
    elsif rising_edge (clk) then
        current_state_out <= next_state_in;
    end if;
end process;


end Behavioral;