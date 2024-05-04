-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all ;

entity kolo is
generic(n: integer := 4;);
port(clk:in std_logic;
	din: in std_logic_vector(n-1 downto 0);
	msk_in: in std_logic;
    op: in std_logic_vector(1 downto 0);
	y: out std_logic_vector(n-1 downto 0););
end entity;

architecture maska of kolo is
signal ny: std_logic_vector(n-1 downto 0);
signal mask: std_logic_vector(n-1 downto 0);
signal pamti_op: std_logic_vector(1 downto 0);
begin
	mkolo: entity work.multiGate(a_multi)
    	generic map (n)
        port map (din,mask,pamti_op,ny);
    
process(clk) is
begin
	if clk'event and clk='1' then
		if msk_in = '1' then
    		y <= (others => 'Z');
            mask <= din;
            pamti_op <= op;
		else
    		y <= ny;
        end if;
    end if;
end process;
end architecture;

-- AND/OR/XOR kolo

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all ;

entity multiGate is
generic(n: integer := 4);
port(a, b: in std_logic_vector(n-1 downto 0);
	op: in std_logic_vector(1 downto 0);
	y: out std_logic_vector(n-1 downto 0););
end entity;

architecture a_multi of multiGate is
begin

process(a,b,op) is
begin
	if op = "00" then
    	y <= a and b;
    elsif op = "01" then
    	y <= a or b;
    elsif op = "10" then
    	y <= a xor b;
    else
    	y <= (others => '0');
    end if;
end process;

end architecture;

-- TestBench

library IEEE ;
  use IEEE.std_logic_1164.all ;
  use IEEE.numeric_std.all ;

entity tb is
  generic (n : integer := 4;
  		t: integer := 2;);
end tb ; 

architecture a_tb of tb is
  signal din,y : std_logic_vector(n-1 downto 0);
  signal clk,msk_in : std_logic;
  signal op: std_logic_vector(1 downto 0);
begin

  dut4: entity work.kolo(maska)
  	generic map(n)
    port map (clk,din,msk_in,op, y);
    
 process
    begin
        clk <= '1'; wait for 5 ns;
        clk <= '0'; wait for 5 ns;
    end process;
 
  stimuli : process
  begin
    op <= "00"; -- and
    msk_in <= '1'; -- y = "zzzz"
    din <= "1011";
    wait for 10 ns;
    msk_in <= '0'; -- y = "1011"
    wait for 20ns;
    din <= "0010"; -- y = "0010"
    wait for 20ns;
    op <= "10";	-- xor
    msk_in <= '1'; -- y = "zzzz"
    din <= "1110";
    wait for 20ns;
    msk_in <= '0';
    din <= "0101"; -- y = "1011"
    wait for 20ns;
    
    wait;
  end process stimuli;

end architecture;
