library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity test_multiplier is
end entity;

architecture test of test_multiplier is
    constant CLK_PERIOD : time := 100 ns;
    constant Nbit : natural := 16;

    component multiplier is 
        generic (
            NBit : natural
        );
        port (
            a : in std_logic_vector(NBit-1 downto 0);
            b : in std_logic_vector(NBit-1 downto 0);
            result : out std_logic_vector(NBit*2-1 downto 0)
        );
    end component;

    signal clk : std_logic := '0';
    signal a : std_logic_vector(Nbit-1 downto 0) := (others => '0');
    signal b : std_logic_vector(Nbit-1 downto 0) := (others => '0');
    signal result : std_logic_vector(Nbit*2-1 downto 0) := (others => '0');
    signal testing : boolean := true;

begin
    clk <= not clk after CLK_PERIOD/2 when testing else '0';

    DUT: multiplier
        generic map (
            NBit => Nbit
        )
        port map (
            a => a,
            b => b,
            result => result
        );
    
    STIMULI: process
    begin 
        a <= (others => '0');
        b <= (others => '0');

        wait until rising_edge(clk);
        a <= "0000000000000001";
        b <= "0000000000000001";

        wait until rising_edge(clk);
        a <= "0000000000000010";
        b <= "0000000000000010";

        wait until rising_edge(clk);
        a <= "0000000000000100";
        b <= "0000000000000100";

        wait for 1000 ns;
        testing <= false;
    end process;
end architecture;