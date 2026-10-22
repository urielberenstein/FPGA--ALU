library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
--use UNISIM.VComponents.all;

entity ACCUMULATOR is
    Port (D : in std_logic_vector (8 downto 0);
          clk : in std_logic;
          rst : in std_logic;   
          Q : out std_logic_vector (8 downto 0));
end ACCUMULATOR;

architecture Behavioral of ACCUMULATOR is

begin

process(clk, rst)
begin
-- asyncrhonous, active high reset
    if rst = '1' then
            Q <= (Others => '0');     
    elsif falling_edge(clk) then
            Q <= D;
        end if; 
end process;


end Behavioral;
