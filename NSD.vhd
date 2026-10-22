library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity NSD is
  Port (
        execute : in std_logic;
        command : in std_logic_vector (2 downto 0);
        current_state_in : in std_logic_vector (3 downto 0);
        next_state_out : out std_logic_vector (3 downto 0)
  );
end NSD;

architecture Behavioral of NSD is

  constant idle_state : std_logic_vector (3 downto 0) := "0000";
  constant load_F_memory_1 : std_logic_vector (3 downto 0) := "0001";
  constant load_F_memory_2 : std_logic_vector (3 downto 0) := "0010";
  constant save2nxt_1 : std_logic_vector (3 downto 0) := "0011";
  constant save2nxt_2 : std_logic_vector (3 downto 0) := "0100";
  constant save_2_U_specified_mem_1 : std_logic_vector (3 downto 0) := "0101";
  constant save_2_U_specified_mem_2 : std_logic_vector (3 downto 0) := "0110";
  constant add_F_mem_1 : std_logic_vector (3 downto 0) := "0111";
  constant add_F_mem_2 : std_logic_vector (3 downto 0) := "1000";
  constant add_WC_F_mem_1 : std_logic_vector (3 downto 0) := "1001";
  constant add_WC_F_mem_2 : std_logic_vector (3 downto 0) := "1010";
  constant load_F_UI : std_logic_vector (3 downto 0) := "1011";
  constant add_F_UI : std_logic_vector (3 downto 0) := "1100";
  constant add_WC_F_UI : std_logic_vector (3 downto 0) := "1101";

  constant cmd_load_from_memory              : std_logic_vector(2 downto 0) := "000";
  constant cmd_save_to_next_memory           : std_logic_vector(2 downto 0) := "001";
  constant cmd_save_to_user_specified_memory : std_logic_vector(2 downto 0) := "010";
  constant cmd_add_from_memory               : std_logic_vector(2 downto 0) := "011";
  constant cmd_add_w_carry_from_memory       : std_logic_vector(2 downto 0) := "100";
  constant cmd_load_from_UI                  : std_logic_vector(2 downto 0) := "101";
  constant cmd_add_from_UI                   : std_logic_vector(2 downto 0) := "110";
  constant cmd_add_w_carry_from_UI           : std_logic_vector(2 downto 0) := "111";

begin

process(execute, command, current_state_in)
begin
    next_state_out <= idle_state;

    case current_state_in is

        when idle_state =>
            if execute = '0' then
                next_state_out <= idle_state;
            else
                case command is
                    when cmd_add_from_UI =>
                        next_state_out <= add_F_UI;
                    when cmd_add_w_carry_from_UI =>
                        next_state_out <= add_WC_F_UI;
                    when cmd_add_from_memory =>
                        next_state_out <= add_F_mem_1;
                    when cmd_add_w_carry_from_memory =>
                        next_state_out <= add_WC_F_mem_1;
                    when cmd_load_from_memory =>
                        next_state_out <= load_F_memory_1;
                    when cmd_load_from_UI =>
                        next_state_out <= load_F_UI;
                    when cmd_save_to_next_memory =>
                        next_state_out <= save2nxt_1;
                    when cmd_save_to_user_specified_memory =>
                        next_state_out <= save_2_U_specified_mem_1;
                    when others =>
                        next_state_out <= idle_state;
                end case;
            end if;

        when add_F_UI =>
            next_state_out <= idle_state;

        when add_WC_F_UI =>
            next_state_out <= idle_state;

        when add_F_mem_1 =>
            next_state_out <= add_F_mem_2;

        when add_F_mem_2 =>
            next_state_out <= idle_state;

        when add_WC_F_mem_1 =>
            next_state_out <= add_WC_F_mem_2;

        when add_WC_F_mem_2 =>
            next_state_out <= idle_state;

        when load_F_memory_1 =>
            next_state_out <= load_F_memory_2;

        when load_F_memory_2 =>
            next_state_out <= idle_state;

        when load_F_UI =>
            next_state_out <= idle_state;

        when save2nxt_1 =>
            next_state_out <= save2nxt_2;

        when save2nxt_2 =>
            next_state_out <= idle_state;

        when save_2_U_specified_mem_1 =>
            next_state_out <= save_2_U_specified_mem_2;

        when save_2_U_specified_mem_2 =>
            next_state_out <= idle_state;

        when others =>
            next_state_out <= idle_state;

    end case;
end process;

end Behavioral;
