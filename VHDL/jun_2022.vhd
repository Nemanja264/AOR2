-- Code your testbench here
library IEEE;
use IEEE.numeric_std.all ;
use IEEE.std_logic_1164.all;

entity tb is
generic(n:integer := 10);
end tb ; 

architecture a_tb of tb is
    signal clk, wr, ce, smer: std_logic;
    signal counter, din : integer range 0 to 256;
    
begin
    dut : entity work.brojac(arch)
    	generic map(n)
        port map(smer,ce,wr,din,clk, counter);
    
    clock: process
    begin
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
    end process;
    
    stimuli: process
    begin
        din <= 2;
        smer <= '1';
        wr<='1';
        ce<='0';
        wait for 10 ns;
       	ce <= '1';
        din <= 8;
        wait for 10ns;
        din <= 6;
        wait for 80 ns;
        smer <= '0';
        wait for 50ns;
        wr <= '0';
        smer <= '1';
        wait for 100ns;
        wait;
    end process;
end architecture;

-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all ;


entity brojac is
	generic(n: integer:= 10);
    port(smer: in std_logic;
    	ce: in std_logic;
        wr: in std_logic;
        din: in integer;
        clk:in std_logic;
        counter: out integer
        );
end entity;

architecture arch of brojac is
begin
per: process(clk,din, ce, wr)
variable count: integer :=0;
begin
    if clk'event and clk = '1' then
        if ce = '1' then
            if smer = '1' then
                if count = (n - 1) then
                    count := din;
                else
                    count := (count + 1) mod n;
                end if;
            else
                if count = 0 then
                    count := din;
                else
                    count := (count - 1) mod n;
                end if;
            end if;
        elsif wr = '1' then
            count := din;
        end if;
    end if;
    counter <= count;
end process;
end architecture;
