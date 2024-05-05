-- WAVE SIGNALI ZBRKANO MZD IZGLEDAJU ZBOG KASNJENJA DODELE, ALI DAJU TACAN REZULTAT

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all ;

entity kolo is
generic(n: integer := 9);
port (num1,num2: in std_logic_vector(n downto 0);
    dout: out std_logic_vector(n-1 downto 0);
    par: out std_logic);
end entity;

architecture a_kolo of kolo is
signal bitp1, bitp2: std_logic_vector(n downto 0);
signal br1, br2: std_logic_vector(n-1 downto 0);
begin
	br1 <= num1(n-1 downto 0);
    br2 <= num2(n-1 downto 0);
    dout <= std_logic_vector(unsigned(br1) + unsigned(br2));
     
	prvi: entity work.parnost(a_parnost)
    	generic map(n => n)
        port map(num => br1, dout => bitp1);
	drugi: entity work.parnost(a_parnost)
    	generic map(n => n)
        port map(num => br2,dout => bitp2);


process
begin
	
    if (bitp1 = num1 and bitp2 = num2) then
    	par <= '1'; 
    else
    	par <= '0';
    end if;
    
    wait for 10ns;
end process;

end architecture;

-----------------------------
-- KOLO PARNOSTI

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all ;

entity parnost is
generic(n: integer := 9);
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

----------------------------------
-- TESTBENCH

library IEEE ;
  use IEEE.std_logic_1164.all ;
  use IEEE.numeric_std.all ;

entity tb is
  generic (n : integer := 9);
end tb; 

architecture a_tb of tb is
  signal dout : std_logic_vector(n-1 downto 0);
  signal par: std_logic;
  signal num1,num2 : std_logic_vector(n downto 0);
begin

  dut4: entity work.kolo(a_kolo)
  	generic map(n)
    port map (num1,num2,dout,par);

  stimuli : process
  begin
	num1 <= "1000001011";
    num2 <= "0000001011";
	wait for 20ns; PAR = '0' , DOUT = "10110"
   	num1 <= "0000001111";
    num2 <= "1000001011";
	wait for 20ns; -- PAR = '1' , DOUT = "11010"
   wait;
  end process stimuli;

end architecture;
