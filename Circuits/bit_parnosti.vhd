library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all ;

entity parnost is
generic(n: integer := 10);
port (num: in std_logic_vector(n-1 downto 0);
    dout: out std_logic_vector(n downto 0));
end entity;

architecture a_parnost of parnost is
begin

process(num)
variable bitp: std_logic;
begin
	bitp := num(0);
	for i in 1 to n-1 loop
    	bitp := num(i) xor bitp;
    end loop;

  dout <= bitp & num;
end process;

end architecture;

----------------------------
-- TESTBENCH

library IEEE ;
  use IEEE.std_logic_1164.all ;
  use IEEE.numeric_std.all ;

entity tb is
  generic (n : integer := 10);
end tb; 

architecture a_tb of tb is
  signal dout : std_logic_vector(n downto 0);
  signal num : std_logic_vector(n-1 downto 0);
begin

  dut4: entity work.parnost(a_parnost)
  	generic map(n)
    port map (num,dout);

  stimuli : process
  begin
	num <= "1000001011"; -- dout = ""
	wait for 20ns;
   
   wait;
  end process stimuli;

end architecture;
