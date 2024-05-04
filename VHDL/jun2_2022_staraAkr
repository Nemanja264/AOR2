-- MALO SU NEJASNI KOD KONACNOG KOLA PA SAM OVAKO REALIZOVAO MALO RUCNO MORA, ALI RADI

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
variable dir: std_logic := '1';
begin
    if clk'event and clk='1' then
		if wr = '1' then
    		if din > n then -- nevalidna vrednost
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

----------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all ;

entity kolo is
generic(n: integer := 10);
port (clk,rst,wr: in std_logic;
	din: in integer;
    dout: out integer);
end entity;

architecture a_kolo of kolo is
signal dins: integer;
signal wrs: std_logic;
begin

brojac: entity work.updown(a_updown)
	generic map(n)
    port map(clk,wrs,dins,dout);
    
    process(clk,rst)
    begin
    	if clk'event and clk = '1' then
        	if rst = '1' then
            	wrs <= '1'; -- OVO JE MALO MEHANICKI, ALI NE ZNAM KAKO SU DRUGACIJE MISLILI DA SE RESETUJE AKO NEMAMO RST U BROJACU
                dins <= n+1; -- SALJEMO NEVALIDNU VREDNOST STO SAMO RESETUJE BROJAC
            else
            	wrs <= wr;
                dins <= din;
            end if;
         end if;
    end process;
    
end architecture;

----------------------------------
-- TESTBENCH

library IEEE ;
  use IEEE.std_logic_1164.all ;
  use IEEE.numeric_std.all ;

entity tb is
  generic (n : integer := 10);
end tb; 

architecture a_tb of tb is
  signal dout,din : integer;
  signal clk,rst,wr : std_logic;
begin

  dut4: entity work.kolo(a_kolo)
  	generic map(n)
    port map (clk,rst,wr,din,dout);
   
  process
  begin
    clk <= '1';wait for 5ns;
    clk<= '0'; wait for 5ns;
  end process;

  stimuli : process
  begin
	rst <= '0';
	wait for 80ns;
    wr <= '1';
    din <= 6;
    wait for 40ns;
	rst <= '1';
	wait for 5ns;
    rst <= '0'; -- OTPOCINJE BROJANJE OPET
    wr <= '0'; -- I OVO MORA MALO MEHANICKI DA BI NASTAVILO DA BROJI
	wait for 80ns;
   
   wait;
  end process stimuli;

end architecture;
