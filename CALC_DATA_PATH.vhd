library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CALC_DATA_PATH is
  Port (clk : in std_logic;
        rst : in std_logic;
        
        opcode : in std_logic_vector(2 downto 0);
        user_sel : in std_logic;
        
        user_input : in std_logic_vector (7 downto 0);
        
        WR : in std_logic;
        
        addr_in : in std_logic_vector (3 downto 0);
        addr_inc : in std_logic;
        addr_load : in std_logic;
        store_addr : in std_logic;
        addr_sel : in std_logic;
        addr_out : out std_logic_vector (3 downto 0);
        
        data_bus : inout std_logic_vector(7 downto 0);
        RESULT : out std_logic_vector (8 downto 0) );

end CALC_DATA_PATH;



architecture Structural of CALC_DATA_PATH is

component ALU_ACC is
  Port (clk : in std_logic;
        rst : in std_logic;
        opcode : in std_logic_vector (2 downto 0);
        user_sel : in std_logic;
        user_input : in std_logic_vector (7 downto 0);
        input_mem : in std_logic_vector (7 downto 0);
        F : out std_logic_vector (8 downto 0));
end component;

component memory_int is
  Port (clk : in std_logic;
        rst : in std_logic;
        
        result_in : in std_logic_vector (8 downto 0);
        data_bus : inout std_logic_vector(7 downto 0);
        internal_bus : out std_logic_vector (7 downto 0);
        WR : in std_logic;
        
        addr_in : in std_logic_vector (3 downto 0);
        addr_inc : in std_logic;
        addr_load : in std_logic;
        store_addr : in std_logic;
        addr_sel : in std_logic;
        addr_out : out std_logic_vector (3 downto 0));

end component;

signal acc_result_S : std_logic_vector (8 downto 0);
signal internal_bus_S : std_logic_vector (7 downto 0);

begin

U_ALU_ACC : ALU_ACC
port map (clk => clk,
          rst => rst,
          opcode => opcode,
          user_sel => user_sel,
          user_input => user_input,
          input_mem => internal_bus_S,
          F => acc_result_S
          );
          
U_MEMORY : memory_int
port map (clk => clk,
          rst => rst,
          result_in => acc_result_S,
          data_bus => data_bus,
          internal_bus => internal_bus_S,
          WR => WR,
          addr_in => addr_in,
          addr_inc => addr_inc,
          addr_load => addr_load,
          store_addr => store_addr,
          addr_sel => addr_sel,
          addr_out => addr_out
          );

RESULT <= acc_result_S;

end Structural;
