library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Top_Level_ALU_Testbench is
end Top_Level_ALU_Testbench;

architecture Behavioral of Top_Level_ALU_Testbench is

    -- Component under test
    component Top_Level_ALU_System
        Port (
            clk       : in  std_logic;                      -- Clock input
            load_a    : in  std_logic;                      -- Load signal for Register A
            load_b    : in  std_logic;                      -- Load signal for Register B
            enable_alu: in  std_logic;                      -- Enable signal for ALU
            data_bus  : inout std_logic_vector(15 downto 0);
            zx, nx, zy, ny, f, no, cin : in std_logic;      -- Control signals for ALU
            zr        : out std_logic;                      -- Zero flag output
            ng        : out std_logic                       -- Negative flag output
        );
    end component;

    -- Signals for stimulus
    signal clk       : std_logic := '0';
    signal load_a    : std_logic := '0';
    signal load_b    : std_logic := '0';
    signal enable_alu: std_logic := '0';
    signal D_in      : std_logic_vector(15 downto 0) := (others => '0');
    signal data_bus  : std_logic_vector(15 downto 0) := (others => 'Z');  -- Tri-state behavior for data bus
    signal zx, nx, zy, ny, f, no, cin : std_logic := '0';
    signal zr        : std_logic;
    signal ng        : std_logic;

    -- Clock period definition
    constant clk_period : time := 20 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: Top_Level_ALU_System
        port map (
            clk       => clk,
            load_a    => load_a,
            load_b    => load_b,
            enable_alu=> enable_alu,
            data_bus  => data_bus,  -- Connect shared data bus
            zx => zx, nx => nx, zy => zy, ny => ny, f => f, no => no, cin => cin,
            zr => zr, ng => ng
        );

    -- Clock process definitions
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stimulus_process: process
    begin
        -- Initialize inputs
        -- Load initial value into Register A
        D_in <= x"0001";
        wait for clk_period;
        data_bus <= D_in;    -- Drive the data bus with initial value
        
        wait for clk_period;
        load_a <= '1';
        load_b <= '0';
        wait for clk_period;
        data_bus <= (others => 'Z');  -- Release the bus after loading values
        load_a <= '0';
        D_in <= x"0002";
        
        wait for clk_period;
        data_bus <= D_in;    -- Drive the data bus with new value
        
        wait for clk_period;
        load_b <= '1';
        
        wait for clk_period;
        load_b <= '0';
        data_bus <= (others => 'Z');
        wait for clk_period;

        -- Enable ALU and perform ADD operation
        zx <= '0'; nx <= '0'; zy <= '0'; ny <= '0'; f <= '1'; no <= '0'; cin <= '0';
        enable_alu <= '1';
        wait for 2 * clk_period;
        enable_alu <= '0';
        load_a <= '1';
        
        wait for clk_period;
        load_a <= '0';
        data_bus <= (others => 'Z');
        wait for clk_period;
        enable_alu <= '1'; -- adding another time reg A + reg B
        wait for 2 * clk_period;
        enable_alu <= '0'; 
        load_a <= '1';
        
        wait for clk_period;
        load_a <= '0';
        data_bus <= (others => 'Z');
        -- Finish simulation
        wait;
    end process;

end Behavioral;
