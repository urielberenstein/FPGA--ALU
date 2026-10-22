library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DBS is
  Port ( clk   : in  std_logic;
         rst   : in  std_logic;
         execute_in : in  std_logic;
         execute_out : out std_logic );
end DBS;

architecture Behavioral of DBS is

signal Q1, Q2 : std_logic;

begin

process(clk, rst)
begin
    -- asynchronous, active high reset
    if rst = '1' then
        Q1 <= '0';
        Q2 <= '0';
    elsif falling_edge(clk) then
        Q1 <= execute_in;
        Q2 <= Q1;
    end if;
end process;

execute_out <= Q1 AND (NOT Q2);

end Behavioral;
