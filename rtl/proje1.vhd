library IEEE;
use IEEE.std_logic_1164.all;

entity proje1 is
    generic(
        cnt_end_add:  integer := 7;
        cnt_end_mult: integer := 5
    );
    port(
        rst      : in std_logic := '1';
        clock_50 : in std_logic;
        x        : in std_logic_vector(31 downto 0) := x"3fc00000";
        y        : out std_logic_vector(31 downto 0)
    );
end entity;

architecture rtl of proje1 is
    signal aclr  : std_logic;
    signal clock : std_logic;
    
    component fp_add is
        port(
            aclr    : in std_logic;
            clk_en  : in std_logic;
            clock   : in std_logic;
            dataa   : in std_logic_vector(31 downto 0);
            datab   : in std_logic_vector(31 downto 0);
            result  : out std_logic_vector(31 downto 0)
        );
    end component;
    
    signal clk_en_add0 : std_logic;
    signal dataa_add0  : std_logic_vector(31 downto 0);
    signal datab_add0  : std_logic_vector(31 downto 0);
    signal result_add0 : std_logic_vector(31 downto 0);
    
    signal clk_en_add1 : std_logic;
    signal dataa_add1  : std_logic_vector(31 downto 0);
    signal datab_add1  : std_logic_vector(31 downto 0);
    signal result_add1 : std_logic_vector(31 downto 0);

    component fp_mult is
        port(
            aclr    : in std_logic;
            clk_en  : in std_logic;
            clock   : in std_logic;
            dataa   : in std_logic_vector(31 downto 0);
            datab   : in std_logic_vector(31 downto 0);
            result  : out std_logic_vector(31 downto 0)
        );
    end component;
    
    signal clk_en_mult0 : std_logic;
    signal dataa_mult0  : std_logic_vector(31 downto 0);
    signal datab_mult0  : std_logic_vector(31 downto 0);
    signal result_mult0 : std_logic_vector(31 downto 0);
    
    signal clk_en_mult1 : std_logic;
    signal dataa_mult1  : std_logic_vector(31 downto 0);
    signal datab_mult1  : std_logic_vector(31 downto 0);
    signal result_mult1 : std_logic_vector(31 downto 0);
    
    type state_type is (s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10);
    signal state        : state_type;
    signal next_state   : state_type;
    signal cnt          : integer := 0;
    signal cnt_end      : integer range 0 to 7;
    
	signal x_reg : std_logic_vector(31 downto 0) := x; --x is assigned
begin
    clock <= clock_50;

    process (rst, clock)
    begin
        if rst = '1' then
            aclr <= '1';
            clk_en_add0  <= '0';
            clk_en_add1  <= '0';
            clk_en_mult0 <= '0';
            clk_en_mult1 <= '0';
			
            cnt <= 0;
            state <= s0;
            next_state <= s0;
			x_reg <= x; 
			
        elsif rising_edge(clock) then
            case state is
                when s0 =>
                    aclr <= '0';
                    
                    dataa_mult0 <= x_reg;
                    datab_mult0 <= x_reg; 
                    
                    dataa_mult1 <= x"40800000";
                    datab_mult1 <= x_reg; 
                    
                    cnt_end <= 1;
                    next_state <= s1;
                    
                when s1 => 
                    clk_en_mult0 <= '1';
                    clk_en_mult1 <= '1';
                    
                    cnt_end <= cnt_end_mult;
                    next_state <= s2;
                    
                when s2 =>
                    clk_en_mult0 <= '0';
                    clk_en_mult1 <= '0';
                    
                    dataa_add0 <= result_mult0;
                    datab_add0 <= result_mult1;
                    
                    cnt_end <= 1;
                    next_state <= s3;
                    
                when s3 =>
                    clk_en_add0 <= '1';
                    
                    cnt_end <= cnt_end_add;
                    next_state <= s4;
                    
                when s4 =>
                    clk_en_add0 <= '0';
                    
                    dataa_add1 <= result_add0;
                    datab_add1 <= x"c0000000";
                    
                    cnt_end <= 1;
                    next_state <= s5;
                    
                when s5 =>
                    clk_en_add1 <= '1';
                    
                    cnt_end <= cnt_end_add;
                    next_state <= s6;
                    
                when s6 =>
                    clk_en_add1 <= '0';
                    
                    y     <= result_add1;
                    x_reg <= result_add1;
					
                    cnt_end <= 1;
                    next_state <= s7;
					
					
                when others =>
                    cnt_end <= 1;
                    next_state <= s0;
                    state <= s0;
            end case;
            
            cnt <= cnt + 1;
            if cnt > cnt_end then
                cnt <= 0;
                state <= next_state;
            end if;
        end if;    
    end process;

    fp_add_inst0: fp_add port map(
            aclr    => aclr,
            clk_en  => clk_en_add0,
            clock   => clock,
            dataa   => dataa_add0,
            datab   => datab_add0,
            result  => result_add0
        );
    
    fp_add_inst1: fp_add port map(
            aclr    => aclr,
            clk_en  => clk_en_add1,
            clock   => clock,
            dataa   => dataa_add1,
            datab   => datab_add1,
            result  => result_add1
        );
        
    fp_mult_inst0: fp_mult port map(
            aclr    => aclr,
            clk_en  => clk_en_mult0,
            clock   => clock,
            dataa   => dataa_mult0,
            datab   => datab_mult0,
            result  => result_mult0
        );
    
    fp_mult_inst1: fp_mult port map(
            aclr    => aclr,
            clk_en  => clk_en_mult1,
            clock   => clock,
            dataa   => dataa_mult1,
            datab   => datab_mult1,
            result  => result_mult1
        );
        
end rtl;
