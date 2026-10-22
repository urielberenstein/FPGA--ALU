library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_ACC is
  Port (clk : in std_logic;
        rst : in std_logic;
        opcode : in std_logic_vector (2 downto 0);
        user_sel : in std_logic;
        user_input : in std_logic_vector (7 downto 0);
        input_mem : in std_logic_vector (7 downto 0);
        F : out std_logic_vector (8 downto 0));
end ALU_ACC;

architecture Behavioral of ALU_ACC is

component ALU is
  Port (A, B : in std_logic_vector (7 downto 0);
        Cin : in std_logic;
        opcode : in std_logic_vector (2 downto 0);
        R : out std_logic_vector (8 downto 0) );
end component;

component ACCUMULATOR is
    Port (D : in std_logic_vector (8 downto 0);
          clk : in std_logic;
          rst : in std_logic;   
          Q : out std_logic_vector (8 downto 0));
end component;

-- middle signal
signal Q_back : std_logic_vector (8 downto 0);
signal R_s : std_logic_vector (8 downto 0);
signal mux_out : std_logic_vector (7 downto 0);

begin

-- mux part
mux_out <= user_input when user_sel = '0' else
     input_mem;
     
ALU_inst : ALU port map (A => Q_back (7 downto 0),
                         Cin => Q_back(8),
                         B => mux_out(7 downto 0),
                         opcode => opcode (2 downto 0),
                         R => R_s);
      
ACC_inst : ACCUMULATOR port map (D => R_S,
                                 clk => clk,
                                 rst=> rst,
                                 Q => Q_back(8 downto 0));
                                 
F <= Q_back;
                               


end Behavioral;
