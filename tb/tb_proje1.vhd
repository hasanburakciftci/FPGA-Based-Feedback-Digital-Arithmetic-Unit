library ieee;
use ieee.std_logic_1164.all;

entity tb_proje1 is
end entity;

architecture sim of tb_proje1 is
  signal rst      : std_logic := '1';
  signal clock_50 : std_logic := '0';
  signal x        : std_logic_vector(31 downto 0) := x"3FC00000"; -- 1.5
  signal y        : std_logic_vector(31 downto 0);

  constant Tclk : time := 20 ns; -- 50 MHz
begin

  clock_50 <= not clock_50 after Tclk/2;


  dut: entity work.proje1
    port map (
      rst      => rst,
      clock_50 => clock_50,
      x        => x,
      y        => y
    );

  stim: process
  begin
    rst <= '1';
    wait for 100 ns;    -- reset time
    rst <= '0';

    wait for 2 us;      -- for 3 cycles
    assert false report "The Simulation is over (3 iteration)" severity failure;
  end process;
end architecture;
