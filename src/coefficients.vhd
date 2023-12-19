library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity coefficients is 
    generic (
        FilterOrder : natural;
        Nbit : natural
    );
    port (
        index : in natural range 0 to FilterOrder;
        coeff : out signed(Nbit-1 downto 0)
    );
end entity coefficients;

architecture struct of coefficients is 
    type coeff_array is array (0 to (FilterOrder/2)-1) of signed(Nbit-1 downto 0);
    constant coeff_values : coeff_array := (
        to_signed(-246, Nbit),
        to_signed(253, Nbit),
        to_signed(694, Nbit),
        to_signed(253, Nbit),
        to_signed(-1229, Nbit),
        to_signed(-2570, Nbit),
        to_signed(-1739, Nbit),
        to_signed(2569, Nbit),
        to_signed(9479, Nbit),
        to_signed(15966, Nbit),
        to_signed(18622, Nbit)
    );

begin
    coeff <= coeff_values(index);
end architecture;