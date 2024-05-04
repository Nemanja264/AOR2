library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all ;

entity updown is
generic(n: integer := 10);
port (clk,wr: in std_logic;
	din: in integer;
    dout: out integer);
end entity;

architecture a_updown of updown is
begin

process (clk)
variable brojanje: integer := 0;
variable dir: std_logic := '1'; -- inicijalno up brojanje
begin
    if clk'event and clk='1' then
		if wr = '1' then
    		if din > n then -- NEVALIDNA VREDNOST
            	brojanje := 0;
                dir := '1';
             else
             	brojanje := din;
             end if;
         else
         	if dir = '1' then
            	if brojanje = n-1 then
                	dir := '0';
                else
                	brojanje := (brojanje + 1) mod n;
                end if;
             else
             	if brojanje = 0 then
                	dir := '1'; 
                else
                	brojanje := (brojanje - 1) mod n;
                end if;
             end if;
         end if;
      end if;
      dout <= brojanje;
end process;

end architecture;

-----------------------
-- TEST BENCH

  library IEEE ;
  use IEEE.std_logic_1164.all ;
  use IEEE.numeric_std.all ;

entity tb is
  generic (n : integer := 10);
end tb; 

architecture a_tb of tb is
  signal din,dout : integer;
  signal clk,wr : std_logic;
begin

  dut4: entity work.updown(a_updown)
  	generic map(n)
    port map (clk,wr,din,dout);
   
process
begin
clk <= '1';wait for 5ns;
clk<= '0'; wait for 5ns;
end process;

  stimuli : process
  begin
    wr <= '0';
    din <= 6;
    wait for 20ns;
    wr <= '1'; -- 6
    wait for 10ns;
    din <= 4; -- 4
    wait for 5ns;
    wr <= '0'; -- BROJANJE NASTAVLJA OD 4 NA GORE
    wait for 20ns;
    din <= 11; -- NEVALIDNA VREDNOST 11 > 10
    wr <= '1'; -- BROJANJE SE RESETUJE OD NULE I BROJI NA GORE
    wait for 10ns;
    wr <= '0'; -- KRECE BROJANJE OD NULE
    wait for 20ns;
    
    wait;
  end process stimuli;

end architecture;
  
