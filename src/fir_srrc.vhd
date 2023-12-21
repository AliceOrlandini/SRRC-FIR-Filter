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
    signal sum_index : natural range 0 to FilterOrder := 0;
    signal c_i : signed(Nbit-1 downto 0) := to_signed(-246, Nbit);

    component ripple_carry_adder is
        generic (
            NBit : natural := 16
        );
        port (
            a : in std_logic_vector(NBit-1 downto 0);
            b : in std_logic_vector(NBit-1 downto 0);
            c_in : in std_logic;
            sum : out std_logic_vector(NBit-1 downto 0);
            c_out : out std_logic
        );
    end component ripple_carry_adder;

    type sum_array is array (0 to (FilterOrder/2)-1) of std_logic_vector(NBit downto 0);
    signal sum : sum_array;

    signal x_resized : std_logic_vector(Nbit downto 0);
    type x_resized_array is array (0 to FilterOrder-1) of std_logic_vector(Nbit downto 0);
    signal x_resized_memory : x_resized_array;
begin
    -- register for input data
    input_reg_gen: for i in 0 to FilterOrder-1 generate
        input_reg_first_iteration : if i = 0 generate 
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
        end generate input_reg_first_iteration;
        
        input_reg_other_iterations : if i > 0 generate 
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
        end generate input_reg_other_iterations;
    end generate input_reg_gen;

    COEFF: coefficients
        generic map (
            FilterOrder => FilterOrder,
            NBit => Nbit
        )
        port map (
            index => sum_index,
            coeff => c_i
        );

    -- I have to convert the input data to signed in order to use the resize function
    -- resize(arg: signed, new_size: natural) that returns a signed vector. So I have to
    -- convert the output of the resize function to std_logic_vector.
    -- I have to use new signals because otherwire I get the error "is not globally static."
    x_resized <= std_logic_vector(resize(signed(x), Nbit+1)); 
    x_resized_memory_gen: for i in 0 to FilterOrder-1 generate
        x_resized_memory_i : x_resized_memory(i) <= std_logic_vector(resize(signed(x_memory(i)), Nbit+1));
    end generate x_resized_memory_gen;

    -- sum of the inputs resized to Nbit+1
    sum_gen: for i in 0 to ((FilterOrder/2)-1) generate
        sum_gen_0 : if i = 0 generate 
            ripple_carry_adder_0 : ripple_carry_adder
                generic map (
                    NBit => NBit + 1
                )
                port map (
                    a => x_resized, 
                    b => x_resized_memory(FilterOrder-1),
                    c_in => '0',
                    sum => sum(0),
                    c_out => open -- I don't need the carry out
                );
        end generate sum_gen_0;
        sum_gen_i : if i > 0 generate
            ripple_carry_adder_i : ripple_carry_adder
                generic map (
                    NBit => NBit + 1
                )
                port map (
                    a => x_resized_memory(i-1),
                    b => x_resized_memory((FilterOrder)-1-i),
                    c_in => '0',
                    sum => sum(i),
                    c_out => open 
                );
        end generate sum_gen_i;
    end generate sum_gen;

    -- multiplication of the sums with the coefficients
    
end architecture bhv_fir_srrc;
