library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fir_srrc is 
    generic (
        FilterOrder : natural := 22;
        NBits : natural := 16
    );
    port (
        clk : in std_logic;
        resetn : in std_logic;
        enable : in std_logic;
        x : in std_logic_vector(NBits-1 downto 0);
        -- c_k : in std_logic_vector(NBits-1 downto 0);
        y : out std_logic_vector(NBits-1 downto 0)
    );
end entity fir_srrc;