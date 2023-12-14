library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;


entity fir_srrc is 
    generic (
        FilterOrder : natural := 22;
        NBit : natural := 16
    );
    port (
        clk : in std_logic;
        resetn : in std_logic;
        enable : in std_logic;
        x : in std_logic_vector(NBit-1 downto 0);
        -- c_k : in std_logic_vector(NBit-1 downto 0);
        y : out std_logic_vector(NBit-1 downto 0)
    );
end entity fir_srrc;

architecture bhv_fir_srrc of fir_srrc is

    type std_logic_vector_array is array (0 to FilterOrder-1) of std_logic_vector(NBit-1 downto 0);
    signal x_reg : std_logic_vector_array := (others => (others => '0'));

    component d_flip_flop is
        generic (
            NBit : natural := 16
        );
        port (
            clk : in std_logic;
            resetn : in std_logic;
            enable : in std_logic;
            d : in std_logic_vector(NBit-1 downto 0);
            q : out std_logic_vector(NBit-1 downto 0)
        );
    end component d_flip_flop;
begin
    -- register for input data
    input_reg_gen: for i in 0 to FilterOrder-1 generate
        first_iteration : if i = 0 generate 
            d_flip_flop_0 : d_flip_flop
                generic map (
                    NBit => NBit
                )
                port map (
                    clk => clk,
                    resetn => resetn,
                    enable => enable,
                    d => x,
                    q => x_reg(0) -- connect the output of the first register to the signal x_reg(0) in order to connect it to the next register
                );
        end generate first_iteration;
        
        other_iterations : if i > 0 generate 
            d_flip_flop_i : d_flip_flop
                generic map (
                    NBit => NBit
                )
                port map (
                    clk => clk,
                    resetn => resetn,
                    enable => enable,
                    d => x_reg(i-1), -- in this case d takes the value of the previous register that i have already connected to the signal x_reg(i-1)
                    q => x_reg(i) 
                );
        end generate other_iterations;
    end generate input_reg_gen;
    
end architecture bhv_fir_srrc;
