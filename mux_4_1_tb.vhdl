library ieee;
use ieee.std_logic_1164.all;

-- A testbench has no ports
entity mux_4_1_tb is
end mux_4_1_tb;

architecture behavioral of mux_4_1_tb is
-- Declaration of the component to be instantiated
  component mux_4_1
    generic(N : integer := 7
            );
    port(in0    : in  std_logic_vector (N downto 0);
         in1    : in  std_logic_vector (N downto 0);
         in2    : in  std_logic_vector (N downto 0);
         in3    : in  std_logic_vector (N downto 0);
         switch : in  std_logic_vector (1 downto 0);
         output : out std_logic_vector (N downto 0)
         );
  end component;
-- Specifies which entity is bound with the component
  signal s                 : std_logic_vector(1 downto 0);
  signal i0, i1, i2, i3, o : std_logic_vector(7 downto 0);
begin
-- Component instantiation
  mux0 : mux_4_1 port map(switch => s,
                          in0    => i0,
                          in1    => i1,
                          in2    => i2,
                          in3    => i3,
                          output => o);
-- This process does the real job
  process
    type pattern_type is record
-- The inputs of the mux
      i0, i1, i2, i3 : std_logic_vector(7 downto 0);
      s              : std_logic_vector(1 downto 0);
-- Expected outputs of mux      
      o              : std_logic_vector(7 downto 0);
    end record;
-- The patterns to apply
    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
      (("00000000", "00000001", "00000010", "00000011", "00", "00000000"),
       ("00000000", "00000001", "00000010", "00000011", "01", "00000001"),
       ("00000000", "00000001", "00000010", "00000011", "10", "00000010"),
       ("00000000", "00000001", "00000010", "00000011", "11", "00000011"));
  begin
-- Check each pattern    
    for n in patterns'range loop
-- Set the inputs      
      s  <= patterns(n).s;
      i0 <= patterns(n).i0;
      i1 <= patterns(n).i1;
      i2 <= patterns(n).i2;
      i3 <= patterns(n).i3;
-- Wait for the result      
      wait for 1 ns;
-- Check the output      
      assert o = patterns(n).o
        report "bad output value" severity error;
    end loop;
      assert false report "end of test" severity note;
-- Wait forever; this will finish the simulation
    wait;
  end process;
end behavioral;


