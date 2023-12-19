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
            c_k : in signed(Nbit-1 downto 0);
            y : out std_logic_vector(NBit-1 downto 0)
        );
    end component;

    component coefficients is
        generic (
            FilterOrder : natural;
            NBit : natural
        );
        port (
            index : in natural range 0 to FilterOrder;
            coeff : out signed(Nbit-1 downto 0)
        );
    end component;

    signal clk : std_logic := '0';
    signal resetn : std_logic := '0';
    signal enable : std_logic := '0';
    signal x : std_logic_vector(Nbit-1 downto 0) := (others => '0');
    signal y : std_logic_vector(Nbit-1 downto 0) := (others => '0');
    signal c_k : signed(Nbit-1 downto 0) := to_signed(-246, Nbit);
    signal testing : boolean := true;

    signal sum_index : natural range 0 to FilterOrder := 0;
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
            c_k => c_k,
            y => y
        );

    COEFF: coefficients
        generic map (
            FilterOrder => FilterOrder,
            NBit => Nbit
        )
        port map (
            index => sum_index,
            coeff => c_k
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
        sum_index <= 0;

        wait until rising_edge(clk);
        x <= "0000000000000010";
        sum_index <= 1;
        

        wait until rising_edge(clk);
        enable <= '0';

        wait until rising_edge(clk);
        resetn <= '0';

        wait for 1000 ns;
        testing <= false;
    end process;
end architecture; 