library ieee;
    use ieee.std_logic_1164.all;

entity test_ripple_carry_adder is 
end test_ripple_carry_adder;

architecture tb of test_ripple_carry_adder is
    constant CLK_PERIOD : time := 100 ns;
    constant Nbit : natural := 16;

    component ripple_carry_adder is 
    generic (
        NBit : natural
    );
    port(
        a: in std_logic_vector(NBit-1 downto 0);
        b: in std_logic_vector(NBit-1 downto 0);
        c_in: in std_logic;
        sum: out std_logic_vector(NBit-1 downto 0);
        c_out: out std_logic
    );
    end component;

    signal clk : std_logic := '0';
    signal a : std_logic_vector(Nbit-1 downto 0) := (others => '0');
    signal b : std_logic_vector(Nbit-1 downto 0) := (others => '0');
    signal c_in : std_logic := '0';
    signal sum : std_logic_vector(Nbit-1 downto 0) := (others => '0');
    signal c_out : std_logic := '0';
    signal testing : boolean := true;
begin
    clk <= not clk after CLK_PERIOD/2 when testing else '0';

    DUT: ripple_carry_adder
        generic map (
            NBit => Nbit
        )
        port map (
            a => a,
            b => b,
            sum => sum,
            c_in => c_in,
            c_out => c_out
        );
    STIMULI: process begin
        a <= "0000000000000000";
        b <= "0000000000000000";
        c_in <= '0';

        wait until rising_edge(clk);
        a <= "0000000000000001";
        b <= "0000000000000000";
        c_in <= '0';

        wait until rising_edge(clk);
        a <= "0000000000000001";
        b <= "0000000000000001";
        c_in <= '0';

        wait until rising_edge(clk);
        a <= "0000000000000010";
        b <= "0000000000000001";
        c_in <= '0';

        wait until rising_edge(clk);
        a <= "1111111111111111";
        b <= "0000000000000001";
        c_in <= '0';

        wait for 1000 ns;
        testing <= false;

    end process;
end architecture;