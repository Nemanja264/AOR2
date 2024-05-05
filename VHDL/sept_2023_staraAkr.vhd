library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all ;

entity brojac is
generic(n:integer := 8);
port (clk,rst: in std_logic;
	dout: out std_logic_vector(n-1 downto 0));
end entity;

architecture a_brojac of brojac is
begin

process(clk,rst)
variable count: std_logic_vector := "00000000";
variable br1: integer := 0; -- broj vodecih 1
begin

	if rst = '1' then
    	count := (others => '0');
        br1 := 0;
    elsif clk'event and clk = '1' then
        if br1 = n then
           	count := ('1', others => '0'); -- BUDE "10000000"
            br1 := 1;
        else
           	count(br1) := '1';
            br1 := br1 + 1;
        end if;
    end if;
dout <= count;
end process;
end architecture;
------------------------------------
-- TESTBENCH

library IEEE ;
  use IEEE.std_logic_1164.all ;
  use IEEE.numeric_std.all ;

entity tb is
generic(n: integer := 8);
end tb; 

architecture a_tb of tb is
  signal dout : std_logic_vector(n-1 downto 0);
  signal clk,rst: std_logic;
begin

  dut4: entity work.brojac(a_brojac)
  	generic map (n)
    port map (clk,rst,dout);

	process
    begin
    	clk <= '1'; wait for 5ns;
        clk <= '0'; wait for 5ns;
    end process;
    
  stimuli : process
  begin
	  rst <= '0';
    wait for 40ns;
    rst <= '1';
    wait for 20ns;
    rst <= '0';
    wait for 90ns;
    rst <= '1';
    wait for 20ns;
   wait;
  end process stimuli;

end architecture;
