library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CALCULATOR is
  Port (
        clk, rst   : in std_logic;

        user_input : in std_logic_vector (7 downto 0);
        addr_in    : in std_logic_vector (3 downto 0);

        execute    : in std_logic;
        command    : in std_logic_vector (2 downto 0);

        RESULT     : out std_logic_vector (8 downto 0);
        current_val  : out std_logic_vector(7 downto 0); --output of the accumulator
        current_addr : out std_logic_vector(3 downto 0)
  );
end CALCULATOR;

architecture Behavioral of CALCULATOR is

component DBS is
  Port (
        clk         : in  std_logic;
        rst         : in  std_logic;
        execute_in  : in  std_logic;
        execute_out : out std_logic
  );
end component;

component CTRL is
  Port (
        clk, rst   : in std_logic;

        execute    : in std_logic;
        command    : in std_logic_vector (2 downto 0);

        user_sel   : out std_logic;
        opcode     : out std_logic_vector (2 downto 0);
        WR         : out std_logic;
        addr_inc   : out std_logic;
        store_addr : out std_logic;
        addr_sel   : out std_logic
  );
end component;

component CALC_DATA_PATH is
  Port (
        clk       : in std_logic;
        rst       : in std_logic;

        opcode    : in std_logic_vector(2 downto 0);
        user_sel  : in std_logic;

        user_input : in std_logic_vector (7 downto 0);

        WR        : in std_logic;

        addr_in   : in std_logic_vector (3 downto 0);
        addr_inc  : in std_logic;
        addr_load : in std_logic;
        store_addr : in std_logic;
        addr_sel  : in std_logic;
        addr_out  : out std_logic_vector (3 downto 0);

        data_bus  : inout std_logic_vector(7 downto 0);
        RESULT    : out std_logic_vector (8 downto 0)
  );
end component;

component MEMORY is
  Port (
        clk        : in std_logic;
        address_in : in std_logic_vector (3 downto 0);
        rd         : in std_logic;
        WR         : in std_logic;
        data_bus   : inout std_logic_vector (7 downto 0)
  );
end component;

signal execute_S    : std_logic;
signal user_sel_S   : std_logic;
signal WR_S         : std_logic;
signal rd_S         : std_logic;
signal addr_inc_S   : std_logic;
signal store_addr_S : std_logic;
signal addr_sel_S   : std_logic;
signal opcode_S     : std_logic_vector(2 downto 0);
signal addr_out_S   : std_logic_vector(3 downto 0);
signal data_bus_S   : std_logic_vector(7 downto 0);
signal RESULT_S : std_logic_vector (8 downto 0);

begin

rd_S <= not WR_S;

U1 : DBS
port map (
    clk         => clk,
    rst         => rst,
    execute_in  => execute,
    execute_out => execute_S
);

U2 : CTRL
port map (
    clk        => clk,
    rst        => rst,
    execute    => execute_S,
    command    => command,
    user_sel   => user_sel_S,
    opcode     => opcode_S,
    WR         => WR_S,
    addr_inc   => addr_inc_S,
    store_addr => store_addr_S,
    addr_sel   => addr_sel_S
);

U3 : CALC_DATA_PATH
port map (
    clk        => clk,
    rst        => rst,
    opcode     => opcode_S,
    user_sel   => user_sel_S,
    user_input => user_input,
    WR         => WR_S,
    addr_in    => addr_in,
    addr_inc   => addr_inc_S,
    addr_load  => '0',
    store_addr => store_addr_S,
    addr_sel   => addr_sel_S,
    addr_out   => addr_out_S,
    data_bus   => data_bus_S,
    RESULT     => RESULT_S
);

U4 : MEMORY
port map (
    clk        => clk,
    address_in => addr_out_S,
    rd         => rd_S,
    WR         => WR_S,
    data_bus   => data_bus_S
);

RESULT <= RESULT_S;
current_val <= RESULT_S (7 downto 0);

current_addr <= addr_out_S;


end Behavioral;