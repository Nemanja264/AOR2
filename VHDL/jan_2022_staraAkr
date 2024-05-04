-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all ;

entity kolo is
generic(n: integer := 4);
port(a:in std_logic;
	b,c: in std_logic_vector(n-1 downto 0);
	f: out std_logic_vector(n-1 downto 0));
end entity;

architecture a_kolo of kolo is
signal fxor: std_logic_vector(n-1 downto 0);
begin
	
    generisi: for i in 0 to n-1 generate
    	
          uslov: if i = 0 generate
          	fxor(i) <= a xor b(i);
          	f(i) <= fxor(i) or c(i); -- konkurentnom dozvolom
              --dut1: entity work.A(a_arch) -- ako hocemo da generisemo kola
              --port map(a,b(i),c(i),f(i));
          else generate
          	 fxor(i) <= f(i-1) xor b(i);
             f(i) <= fxor(i) or c(i);
             -- duti: entity work.A(a_arch)
             -- port map(f(i-1),b(i),c(i),f(i));
          end generate;
        
    end generate;
end architecture;

----------------------------
-- POSEBNO KOLO, KADA BI RADILI SA WORK.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all ;

entity A is
port (a,b,c:in std_logic;
	f: out std_logic;);
end entity;

architecture a_arch of A is
begin

f <= (a xor b) or c;

end architecture;

----------------------
-- TESTBENCH

library IEEE ;
  use IEEE.std_logic_1164.all ;
  use IEEE.numeric_std.all ;

entity tb is
  generic (n : integer := 4);
end tb; 

architecture a_tb of tb is
  signal b,c,f : std_logic_vector(n-1 downto 0);
  signal a : std_logic;
begin

  dut4: entity work.kolo(a_kolo)
  	generic map(n)
    port map (a,b,c, f);
   
  stimuli : process
  begin
    a <= '0';
    b <= "1110";
    c <= "0010";
    wait for 10ns;
    --- f = "1010"
    wait;
  end process stimuli;

end architecture;
