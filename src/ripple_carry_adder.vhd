library ieee;
    use ieee.std_logic_1164.all;

entity ripple_carry_adder is
    generic(
        NBit : natural := 16
    );
    port(
        a : in std_logic_vector(NBit-1 downto 0);
        b : in std_logic_vector(NBit-1 downto 0);
        c_in : in std_logic;
        sum : out std_logic_vector(NBit-1 downto 0);
        c_out : out std_logic
    );
end ripple_carry_adder;

architecture bhv_ripple_carry_adder of ripple_carry_adder is
    component full_adder is
        port(
            a : in std_logic;
            b : in std_logic;
            c_in : in std_logic;
            sum : out std_logic;
            c_out : out std_logic
        );
    end component;
    signal carry : std_logic_vector(NBit downto 0);
begin 
        carry(0) <= c_in;
        FA : for i in 0 to NBit-1 generate
            FA_i : full_adder port map (
                a => a(i), -- a(i) is the ith bit of a
                b => b(i),
                c_in => carry(i),
                sum => sum(i), 
                c_out => carry(i+1) -- carry(i+1) takes the value of c_out of the ith full adder
            );
        end generate;
        c_out <= carry(NBit-1); -- c_out is the last carry
end bhv_ripple_carry_adder;