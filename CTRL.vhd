library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CTRL is
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
end CTRL;

architecture Behavioral of CTRL is

component NSD is
  Port (
        execute          : in std_logic;
        command          : in std_logic_vector (2 downto 0);
        current_state_in : in std_logic_vector (3 downto 0);
        next_state_out   : out std_logic_vector (3 downto 0)
  );
end component;

component CSR is
  Port (
        clk               : in std_logic;
        rst               : in std_logic;
        next_state_in     : in std_logic_vector (3 downto 0);
        current_state_out : out std_logic_vector (3 downto 0)
  );
end component;

component OD is
  Port (
        current_state_in : in std_logic_vector (3 downto 0);
        user_sel         : out std_logic;
        opcode           : out std_logic_vector (2 downto 0);
        WR               : out std_logic;
        addr_inc         : out std_logic;
        store_addr       : out std_logic;
        addr_sel         : out std_logic
  );
end component;

signal next_state_out_S    : std_logic_vector (3 downto 0);
signal current_state_out_S : std_logic_vector (3 downto 0);

begin

u1 : NSD
port map (
    execute          => execute,
    command          => command,
    current_state_in => current_state_out_S,
    next_state_out   => next_state_out_S
);

u2 : CSR
port map (
    clk               => clk,
    rst               => rst,
    next_state_in     => next_state_out_S,
    current_state_out => current_state_out_S
);

u3 : OD
port map (
    current_state_in => current_state_out_S,
    user_sel         => user_sel,
    opcode           => opcode,
    WR               => WR,
    addr_inc         => addr_inc,
    store_addr       => store_addr,
    addr_sel         => addr_sel
);

end Behavioral;
