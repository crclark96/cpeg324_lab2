library ieee;
use ieee.std_logic_1164.all;

-- A testbench has no ports
entity adder_4_bit_tb is
end adder_4_bit_tb;

architecture behavioral of adder_4_bit_tb is
-- Declaration of the component to be instantiated
  component adder_4_bit
    port(a     : in  std_logic_vector(3 downto 0);
         b     : in  std_logic_vector(3 downto 0);
         sub   : in  std_logic;
         s     : out std_logic_vector(3 downto 0);
         over  : out std_logic;
         under : out std_logic;
         );
  end component;
-- Specifies which entity is bound with the component
  signal _a, _b, _s          : std_logic_vector(3 downto 0);
  signal _sub, _over, _under : std_logic;
begin
-- Component instantiation
  adder0 : adder_4_bit port map(a     => _a,
                                b     => _b,
                                s     => _s,
                                sub   => _sub,
                                over  => _over,
                                under => _under);
-- This process does the real job
  process
    type pattern_type is record
-- The inputs of the adder
      _a, _b        : std_logic_vector(3 downto 0);
      _sub          : std_logic;
-- Expected outputs of adder
      _s            : std_logic_vector(3 downto 0);
      _over, _under : std_logic;
    end record;
-- The patterns to apply
    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
      (("0001", "0001", '0', "0010", '0', '0'), -- 1 + 1 = 2
       ("0001", "1111", '0', "0000", '0', '0'), -- 1 +-1 = 0
       ("1111", "1111", '0', "1110", '0', '0'), -- -1+-1 =-2
       ("0001", "0001", '1', "0000", '0', '0'), -- 1 - 1 = 0
       ("1111", "0001", '1', "1110", '0', '0'), -- -1- 1 =-2
       ("1111", "1111", '1', "0000", '0', '0'), -- -1--1 = 0
       ("0111", "0001", '0', "1000", '1', '0'), -- 7 + 1 =-8
       ("1001", "0010", '1', "0111", '0', '1'));-- -7- 2 = 7
  begin
-- Check each pattern    
    for n in patterns'range loop
-- Set the inputs      
      _a <= patterns(n)._a;
      _b <= patterns(n)._b;
      _sub <= patterns(n)._sub;
-- Wait for the result      
      wait for 1 ns;
-- Check the output      
      assert _s = patterns(n)._s
        report "bad output value" severity error;
      assert _over = patterns(n)._over
        report "bad output value" severity error;
      assert _under = patterns(n)._under
        report "bad output value" severity error;
    end loop;
    assert false report "end of test" severity note;
-- Wait forever; this will finish the simulation
    wait;
  end process;
end behavioral;
