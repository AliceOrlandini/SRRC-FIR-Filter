library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity multiplier is 
    generic (
        NBit : natural := 16
    );
    port (
        a : in std_logic_vector(NBit-1 downto 0);
        b : in std_logic_vector(NBit-1 downto 0);
        result : out std_logic_vector((2*NBit)-1 downto 0)
    );
end entity multiplier;

architecture bhv_multiplier of multiplier is
begin
    process(a, b)
    begin
        result <= std_logic_vector(signed(a) * signed(b));
    end process;
end architecture; 

