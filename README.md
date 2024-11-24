#Top Level ALU System - VHDL Project

This project implements a top-level Arithmetic Logic Unit (ALU) system using VHDL. The design includes two 16-bit registers and an ALU capable of performing arithmetic and logic operations on the data stored in these registers. The design is simulated using a testbench in Vivado.

Project Structure

Files

Top_Level_ALU_System.vhd: Implements the top-level ALU system, which includes two 16-bit registers (Register_A and Register_B) and an ALU component (ALU_Unit). The data_bus is used as a shared inout port to manage data input and ALU output.

Top_Level_ALU_Testbench.vhd: A testbench used to simulate the behavior of the top-level ALU system. The testbench initializes the system, loads data into the registers, and performs an addition operation using the ALU.

Components

Register_16Bit: Stores a 16-bit value. Includes load control to determine when data is loaded into the register.

ALU: Performs arithmetic and logic operations (e.g., addition) based on control signals provided.

Control Signals

clk: Clock signal used to synchronize operations.

load_a, load_b: Load signals for Register A and Register B, respectively.

enable_alu: Enables the ALU operation, allowing it to perform the arithmetic or logic operation.

zx, nx, zy, ny, f, no, cin: Control signals for ALU operations (e.g., zero input, negate, add, etc.).

Data Flow

The data_bus is used for both input and output.

When loading data into registers (load_a or load_b), the bus is set to high-impedance ('Z') so that external input can drive it.

When the ALU is enabled, the result is driven onto the data_bus.

How to Run the Simulation

Open Vivado and create a new project.

Add the VHDL files (Top_Level_ALU_System.vhd and Top_Level_ALU_Testbench.vhd) to the project.

Synthesize the design to ensure there are no errors.

Run the simulation using Top_Level_ALU_Testbench.vhd.

Observe the waveforms to verify the correctness of the operations (e.g., register loading, ALU addition).

Usage Notes

The ALU performs an ADD operation when f is set to '1'. The other control signals (zx, nx, zy, ny, no, cin) modify the inputs to the ALU for various logical or arithmetic operations.

The data bus behavior is controlled by the tri-state logic, ensuring it is either driven by the ALU or available for external input during loading operations.

Key Considerations

Timing: The clock (clk) is used throughout the design to synchronize operations for both the registers and the ALU.

Tri-State Logic: The data_bus is managed with high-impedance ('Z') states to avoid contention when multiple components need access.

Dependencies

Vivado (recommended for synthesis and simulation).

Basic understanding of VHDL, clocked processes, and tri-state buffers is required to modify or extend the project.

Future Improvements

Add support for more ALU operations such as subtraction or logical shifts.

Implement more complex test cases in the testbench to fully verify the ALU's functionality.

