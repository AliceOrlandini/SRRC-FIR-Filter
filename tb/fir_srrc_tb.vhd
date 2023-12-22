library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity test_fir_srrc is
end entity;

architecture test of test_fir_srrc is
    constant CLK_PERIOD : time := 100 ns;
    constant Nbit : natural := 16;
    constant FilterOrder : natural := 22;
    
    component fir_srrc is 
        generic (
            FilterOrder : natural;
            NBit : natural
        );
        port (
            clk : in std_logic;
            resetn : in std_logic;
            enable : in std_logic;
            x : in std_logic_vector(NBit-1 downto 0);
            y : out std_logic_vector(NBit-1 downto 0)
        );
    end component;

    signal clk : std_logic := '0';
    signal resetn : std_logic := '0';
    signal enable : std_logic := '0';
    signal x : std_logic_vector(Nbit-1 downto 0) := (others => '0');
    signal y : std_logic_vector(Nbit-1 downto 0) := (others => '0');
    signal testing : boolean := true;

begin
    clk <= not clk after CLK_PERIOD/2 when testing else '0';

    DUT: fir_srrc
        generic map (
            FilterOrder => FilterOrder,
            NBit => Nbit
        )
        port map (
            clk => clk,
            resetn => resetn,
            enable => enable,
            x => x,
            y => y
        );


    STIMULI: process
    begin
        resetn <= '0';
        enable <= '0';
        x <= "1000000000000000";

        wait until rising_edge(clk);
        resetn <= '1';

        wait until rising_edge(clk);
        enable <= '1';

        wait for 1000 ns;
        x <= "1000000000000000";

        wait for 2000 ns;
        x <= "1000000000000001";

        wait for 3000 ns;
        x <= "0111111111111110";

        wait for 5000 ns;
        x <= "1000000000000000";

        wait for 7000 ns;
        enable <= '0';

        wait for 8000 ns;
        resetn <= '0';

        wait for 9000 ns;
        testing <= false;
    end process;
end architecture; 