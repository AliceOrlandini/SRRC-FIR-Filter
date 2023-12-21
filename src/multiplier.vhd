library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity multiplier is 
    generic (
        NBit : natural := 16
    );
    port (
        a : in signed(NBit-1 downto 0);
        b : in signed(NBit-1 downto 0);
        result : out signed(NBit*2-1 downto 0)
    );
end entity multiplier;

architecture bhv_multiplier of multiplier is
begin
    process(a, b)
    begin
        result <= a * b;
    end process;
end architecture; 

