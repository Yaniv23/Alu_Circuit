library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Top_Level_ALU_System is
    Port (
        clk       : in  std_logic;                      -- Clock input
        load_a    : in  std_logic;                      -- Load signal for Register A
        load_b    : in  std_logic;                      -- Load signal for Register B
        enable_alu: in  std_logic;                      -- Enable signal for ALU
        data_bus  : inout std_logic_vector(15 downto 0);-- Shared data bus
        zx, nx, zy, ny, f, no, cin : in std_logic;      -- Control signals for ALU
        zr        : out std_logic;                      -- Zero flag output
        ng        : out std_logic                       -- Negative flag output
    );
end Top_Level_ALU_System;

architecture Structural of Top_Level_ALU_System is

    -- Declare the Register and ALU components
    component Register_16Bit
        Port (
            D_in  : in  std_logic_vector(15 downto 0);
            clk   : in  std_logic;
            load  : in  std_logic;
            D_out : out std_logic_vector(15 downto 0)
        );
    end component;

    component ALU
        Port (
            x         : in  std_logic_vector(15 downto 0);
            y         : in  std_logic_vector(15 downto 0);
            zx        : in  std_logic;
            nx        : in  std_logic;
            zy        : in  std_logic;
            cin       : in  std_logic;
            ny        : in  std_logic;
            f         : in  std_logic;
            no        : in  std_logic;
            clk       : in  std_logic;
            enable_alu: in  std_logic;
            ALU_out   : out std_logic_vector(15 downto 0);
            zr        : out std_logic;
            ng        : out std_logic
        );
    end component;

    -- Signals to connect components internally
    signal reg_a_out : std_logic_vector(15 downto 0);
    signal reg_b_out : std_logic_vector(15 downto 0);
    signal alu_result : std_logic_vector(15 downto 0);

begin

    -- Instantiate Register A
    Register_A: Register_16Bit
        port map (
            D_in  => data_bus, -- Connect shared bus to the input of Register A
            clk   => clk,
            load  => load_a,
            D_out => reg_a_out
        );

    -- Instantiate Register B
    Register_B: Register_16Bit
        port map (
            D_in  => data_bus, -- Connect shared bus to the input of Register B
            clk   => clk,
            load  => load_b,
            D_out => reg_b_out
        );

    -- Instantiate the ALU
    ALU_Unit: ALU
        port map (
            x          => reg_a_out,
            y          => reg_b_out,
            zx         => zx,
            nx         => nx,
            zy         => zy,
            cin        => cin,
            ny         => ny,
            f          => f,
            no         => no,
            clk        => clk,
            enable_alu => enable_alu,
            ALU_out    => alu_result,
            zr         => zr,
            ng         => ng
        );

-- Tri-State Control Process for data_bus
tri_state_process: process(clk, load_a, load_b, enable_alu)
begin
    if rising_edge(clk) then
        if load_a = '1' or load_b = '1' then
            null;  -- Release the bus for external driving during load operations
        elsif enable_alu = '1' then
            data_bus <= alu_result;  -- ALU drives the bus when enabled
        else
            data_bus <= (others => 'Z');  -- Release the bus to high-impedance in all other cases
        end if;
    end if;
end process;

end Structural;


