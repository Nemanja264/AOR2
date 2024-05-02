library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all ;

entity kolo is
generic(n: integer := 4;);
port(c: in std_logic;
	a, b: in std_logic_vector(n-1 downto 0);
	y: out std_logic_vector(n-1 downto 0););
end entity;

architecture arch of kolo is
signal yand: std_logic; --_vector(n-1 downto 0);
begin

prenos: for i in 0 to n-1 generate
	uslov1: if i = 0 generate
    begin
    	yand <= a(i) and b(i);
        y(i) <= c or yand;
     else generate
     	yand <= a(i) and b(i);
        y(i) <= y(i-1) or yand; -- moze i yand kao std_logic_vector da vidimo sve izlaze iz and kola, ali i ovako radi
     end generate;
end generate;

end architecture;

----- test bench
library IEEE ;
  use IEEE.std_logic_1164.all ;
  use IEEE.numeric_std.all ;

entity tb is
  generic (n : integer := 4;
  		t: integer := 2;);
end tb ; 

architecture a_tb of tb is
  signal a,b,y : std_logic_vector(n-1 downto 0);
  signal c : std_logic;
begin

  dut4 : entity work.kolo(arch)
  	generic map(n)
    port map (c,a,b,y);
 
  stimuli : process
  begin
    a <= "1000";
    b <= "1011";
    c <= '0';
    wait for 50 ns;
    wait;
  end process stimuli;

end architecture;
