-- POD A), KRUZNI BROJAC DO 9

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all ;

entity brojac is
port (clk,rst,en: in std_logic;
	dout: out integer);
end entity;

architecture a_brojac of brojac is
begin

process(clk,rst,en)
variable count: integer := 0;
begin

	if rst = '1' then
    	count := 0;
    elsif clk'event and clk = '1' then
    	if en = '1' then
        	if count = 9 then
            	count := 0;
            else
            	count := count + 1;
            end if;
         end if;
    end if;
dout <= count;
end process;
end architecture;

-----------------------
-- TESTBENCH

library IEEE ;
  use IEEE.std_logic_1164.all ;
  use IEEE.numeric_std.all ;

entity tb is
end tb; 

architecture a_tb of tb is
  signal dout : integer;
  signal en,clk,rst: std_logic;
begin

  dut4: entity work.brojac(a_brojac)
    port map (clk,rst,en,dout);

	process
    begin
    	clk <= '1'; wait for 5ns;
        clk <= '0'; wait for 5ns;
    end process;
    
  stimuli : process
  begin
	en <= '1';
    rst <= '0';
	wait for 20ns;
   	en <= '0';
    rst <= '0';
	wait for 20ns;
    en <= '1';
    rst <= '0';
    wait for 40ns;
    rst <= '1';
    wait for 20ns;
    rst <= '0';
    wait for 40ns;
    
   wait;
  end process stimuli;

end architecture;
  
