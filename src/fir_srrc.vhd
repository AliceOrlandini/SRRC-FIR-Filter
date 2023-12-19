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
        c_k : in signed(Nbit-1 downto 0);
        y : out std_logic_vector(NBit-1 downto 0)
    );
end entity fir_srrc;

architecture bhv_fir_srrc of fir_srrc is

    -- for the input data I need to use a NBit vector
    type std_logic_vector_Nbit_array is array (0 to FilterOrder-1) of std_logic_vector(NBit-1 downto 0);
    signal x_memory : std_logic_vector_Nbit_array;

    -- for the multiplication I need to use a 2*NBit vector
    type std_logic_vector_2NBit_array is array (0 to FilterOrder-1) of std_logic_vector((2*NBit)-1 downto 0);
    signal multiplications : std_logic_vector_2NBit_array;

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
                    q => x_memory(0) -- connect the output of the first register to the signal x_memory(0) 
                                     -- in order to connect it to the next register
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
                    d => x_memory(i-1), -- in this case d takes the value of the previous register that 
                                        -- I have already connected to the signal x_memory(i-1)
                    q => x_memory(i) 
                );
        end generate other_iterations;
    end generate input_reg_gen;

    -- multiplication between the input data and the coefficients
    -- multiplier_gen: for i in 0 to FilterOrder-1 generate
        
    -- end generate multiplier_gen;
    
end architecture bhv_fir_srrc;
