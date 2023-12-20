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
        x <= (others => '0');

        wait until rising_edge(clk);
        resetn <= '1';

        wait until rising_edge(clk);
        enable <= '1';

        wait until rising_edge(clk);
        x <= "0000000000000001";

        wait until rising_edge(clk);
        x <= "0000000000000010";

        wait until rising_edge(clk);
        x <= "0000000000000011";

        wait until rising_edge(clk);
        x <= "0000000000000100";

        wait until rising_edge(clk);
        x <= "0000000000000101";

        wait until rising_edge(clk);
        x <= "0000000000000110";

        wait until rising_edge(clk);
        x <= "0000000000000111";

        wait until rising_edge(clk);
        x <= "0000000000001000";

        wait until rising_edge(clk);
        x <= "0000000000001001";

        wait until rising_edge(clk);
        x <= "0000000000001010";

        wait until rising_edge(clk);
        x <= "0000000000001011";

        wait until rising_edge(clk);
        x <= "0000000000001100";

        wait until rising_edge(clk);
        x <= "0000000000001101";

        wait until rising_edge(clk);
        x <= "0000000000001110";

        wait until rising_edge(clk);
        x <= "0000000000001111";

        wait until rising_edge(clk);
        x <= "0000000000010000";

        wait until rising_edge(clk);
        x <= "0000000000010001";

        wait until rising_edge(clk);
        x <= "0000000000010010";

        wait until rising_edge(clk);
        x <= "0000000000010011";

        wait until rising_edge(clk);
        x <= "0000000000010100";

        wait until rising_edge(clk);
        x <= "0000000000010101";

        wait until rising_edge(clk);
        x <= "0000000000010110";

        wait until rising_edge(clk);
        x <= "0000000000010111";
        

        wait until rising_edge(clk);
        enable <= '0';

        wait until rising_edge(clk);
        resetn <= '0';

        wait for 1000 ns;
        testing <= false;
    end process;
end architecture; 