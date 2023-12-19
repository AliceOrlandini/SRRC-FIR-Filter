library ieee;
    use ieee.std_logic_1164.all;

entity d_flip_flop is
    generic (
        Nbit : natural := 16
    );
    port (
        clk : in std_logic;
        resetn: in std_logic;
        enable: in std_logic;
        d   : in std_logic_vector(Nbit-1 downto 0);
        q   : out std_logic_vector(Nbit-1 downto 0)
    );
end entity d_flip_flop;

architecture bhv_d_flip_flop of d_flip_flop is
begin
    PROC: process(clk, resetn)
    begin 
        if resetn = '0' then
            -- reset of the output of the flip-flop
            q <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                -- update the output of the flip-flop
                q <= d;
            end if;
        end if;
    end process PROC;
end architecture bhv_d_flip_flop;