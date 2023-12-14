library ieee;
    use ieee.std_logic_1164.all;

entity test_d_flip_flop is
end entity;

architecture test of test_d_flip_flop is
    constant CLK_PERIOD : time := 100 ns;
    constant Nbit : natural := 16;

    component d_flip_flop is
        generic (
            Nbit : natural
        );
        port (
            clk : in std_logic;
            resetn: in std_logic;
            enable: in std_logic;
            d   : in std_logic_vector(Nbit-1 downto 0);
            q   : out std_logic_vector(Nbit-1 downto 0)
        );
    end component;

    signal clk : std_logic := '0';
    signal resetn : std_logic := '0';
    signal enable : std_logic := '0';
    signal d : std_logic_vector(Nbit-1 downto 0) := (others => '0');
    signal q : std_logic_vector(Nbit-1 downto 0) := (others => '0');
    signal testing : boolean := true;

begin
    clk <= not clk after CLK_PERIOD/2 when testing else '0';

    DUT: d_flip_flop
        generic map (
            Nbit => Nbit
        )
        port map (
            clk => clk,
            resetn => resetn,
            enable => enable,
            d => d,
            q => q
        );

    STIMULI: process
    begin
        resetn <= '0';
        enable <= '0';
        d <= (others => '0');

        wait until rising_edge(clk);
        resetn <= '1';

        wait until rising_edge(clk);
        enable <= '1';

        wait until rising_edge(clk);
        d <= "0000000000000001";

        wait until rising_edge(clk);
        d <= "0000000000000010";

        wait until rising_edge(clk);
        d <= "0000000000000100";

        wait until rising_edge(clk);
        d <= "0000000000001000";

        wait until rising_edge(clk);
        d <= "0000000000010000";

        wait until rising_edge(clk);
        d <= "0000000000100000";

        wait until rising_edge(clk);
        enable <= '0';

        wait until rising_edge(clk);
        resetn <= '0';

        wait for 1000 ns;
        testing <= false;
    end process;
end architecture;