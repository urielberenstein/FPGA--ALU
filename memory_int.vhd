library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory_int is
  Port (clk : in std_logic;
        rst : in std_logic;
        
        result_in : in std_logic_vector (8 downto 0);
        data_bus : inout std_logic_vector (7 downto 0);
        internal_bus : out std_logic_vector (7 downto 0);
        WR : in std_logic;
        
        addr_in : in std_logic_vector (3 downto 0);
        addr_inc : in std_logic;
        addr_load : in std_logic;
        store_addr : in std_logic;
        addr_sel : in std_logic;
        addr_out : out std_logic_vector (3 downto 0));

end memory_int;

architecture Behavioral of memory_int is

signal addr_count_reg : unsigned (3 downto 0) := (others => '0');
signal addr_store_reg : std_logic_vector (3 downto 0) := (others => '0');

begin

process(clk, rst)
begin
-- asyncrhonous, active high reset
    if rst = '1' then
        addr_count_reg <= (others => '0');
        addr_store_reg <= (others => '0');
 
    elsif falling_edge(clk) then -- was falling before
        --store
        if store_addr = '1' then
            addr_store_reg <= addr_in;  
         else
            addr_store_reg <= addr_store_reg;
        end if;
        
        --counter
        if addr_load = '1' then
            addr_count_reg <= unsigned(addr_in);
        elsif addr_inc = '1' then
            addr_count_reg <= addr_count_reg + 1;
        else 
            addr_count_reg <= addr_count_reg;
        end if;
    end if;
end process;

addr_out <= addr_store_reg when addr_sel = '0' else
            std_logic_vector(addr_count_reg);

-- data bus WRITE
data_bus <= result_in (7 downto 0) when WR = '1' else
            (others => 'Z');
-- data bus READ
internal_bus <= data_bus;

end Behavioral;
