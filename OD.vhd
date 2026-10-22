library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity OD is
  Port (
        current_state_in : in std_logic_vector (3 downto 0);

        user_sel   : out std_logic;
        opcode     : out std_logic_vector (2 downto 0);
        WR         : out std_logic;
        addr_inc   : out std_logic;
        store_addr : out std_logic;
        addr_sel   : out std_logic
  );
end OD;

architecture Behavioral of OD is

  constant op_hold : std_logic_vector(2 downto 0) := "100";
  constant op_load : std_logic_vector(2 downto 0) := "011";
  constant op_add  : std_logic_vector(2 downto 0) := "001";
  constant op_addc : std_logic_vector(2 downto 0) := "000";
  constant op_xor  : std_logic_vector(2 downto 0) := "010";

  constant idle_state                 : std_logic_vector (3 downto 0) := "0000";
  constant load_F_memory_1            : std_logic_vector (3 downto 0) := "0001";
  constant load_F_memory_2            : std_logic_vector (3 downto 0) := "0010";
  constant save2nxt_1                 : std_logic_vector (3 downto 0) := "0011";
  constant save2nxt_2                 : std_logic_vector (3 downto 0) := "0100";
  constant save_2_U_specified_mem_1   : std_logic_vector (3 downto 0) := "0101";
  constant save_2_U_specified_mem_2   : std_logic_vector (3 downto 0) := "0110";
  constant add_F_mem_1                : std_logic_vector (3 downto 0) := "0111";
  constant add_F_mem_2                : std_logic_vector (3 downto 0) := "1000";
  constant add_WC_F_mem_1             : std_logic_vector (3 downto 0) := "1001";
  constant add_WC_F_mem_2             : std_logic_vector (3 downto 0) := "1010";
  constant load_F_UI                  : std_logic_vector (3 downto 0) := "1011";
  constant add_F_UI                   : std_logic_vector (3 downto 0) := "1100";
  constant add_WC_F_UI                : std_logic_vector (3 downto 0) := "1101";

begin

process(current_state_in)
begin
    -- defaults
    user_sel   <= '0';       -- UI by default
    opcode     <= op_hold;   -- hold by default
    WR         <= '0';       -- no memory write by default
    addr_inc   <= '0';       -- do not increment address by default
    store_addr <= '0';       -- do not capture addr_in by default
    addr_sel   <= '1';       -- default to counter/current-next-memory path

    case current_state_in is

        when idle_state =>
            null;

        -- UI operations (1 state each)

        when load_F_UI =>
            user_sel <= '0';
            opcode   <= op_load;

        when add_F_UI =>
            user_sel <= '0';
            opcode   <= op_add;

        when add_WC_F_UI =>
            user_sel <= '0';
            opcode   <= op_addc;

        -- Memory load operations (2 states)

        when load_F_memory_1 =>
            addr_sel   <= '0';
            store_addr <= '1';
            WR         <= '0';

        when load_F_memory_2 =>
            user_sel   <= '1';
            opcode     <= op_load;
            addr_sel   <= '0';
            store_addr <= '1';
            WR         <= '0';

        -- Memory add operations (2 states)

        when add_F_mem_1 =>
            addr_sel   <= '0';
            store_addr <= '1';
            WR         <= '0';

        when add_F_mem_2 =>
            user_sel   <= '1';
            opcode     <= op_add;
            addr_sel   <= '0';
            store_addr <= '1';
            WR         <= '0';

        when add_WC_F_mem_1 =>
            addr_sel   <= '0';
            store_addr <= '1';
            WR         <= '0';

        when add_WC_F_mem_2 =>
            user_sel   <= '1';
            opcode     <= op_addc;
            addr_sel   <= '0';
            store_addr <= '1';
            WR         <= '0';

        -- Save to next memory (2 states)

        when save2nxt_1 =>
            addr_sel <= '1';
            WR       <= '1';

        when save2nxt_2 =>
            addr_sel <= '1';
            addr_inc <= '1';
            WR       <= '0';

        -- Save to user-specified memory (2 states)

        when save_2_U_specified_mem_1 =>
            addr_sel   <= '0';
            store_addr <= '1';
            WR         <= '1';

        when save_2_U_specified_mem_2 =>
            addr_sel   <= '0';
            store_addr <= '1';
            WR         <= '0';

        when others =>
            null;

    end case;
end process;

end Behavioral;