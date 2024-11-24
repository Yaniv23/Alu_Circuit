# Top-Level ALU System

This project implements a **16-bit Arithmetic Logic Unit (ALU) System** with a shared data bus and control signals. The design uses a structural architecture to integrate components such as registers and an ALU. A testbench is provided to verify the functionality of the system.

## Features
- **16-bit Registers (A and B):** Load and store data.
- **16-bit ALU:**
  - Supports various arithmetic and logical operations based on control signals.
  - Outputs zero (`zr`) and negative (`ng`) flags.
- **Shared Data Bus:** Facilitates communication between components.
- **Tri-State Bus Control:** Ensures proper data flow and high-impedance behavior when not in use.

## Files
- **`Top_Level_ALU_System.vhd`**: VHDL description of the ALU system.
- **`Top_Level_ALU_Testbench.vhd`**: Testbench for simulating the ALU system.

## System Overview
### Ports
- **Inputs:**
  - `clk`: Clock signal.
  - `load_a`, `load_b`: Load signals for Registers A and B.
  - `enable_alu`: Enables the ALU to perform operations.
  - `zx, nx, zy, ny, f, no, cin`: Control signals for ALU operations.
  - `data_bus`: Shared bidirectional 16-bit data bus.
- **Outputs:**
  - `zr`: Zero flag.
  - `ng`: Negative flag.

### Internal Components
1. **Registers:**
   - Two 16-bit registers (`Register_A` and `Register_B`) for storing operands.
2. **ALU:**
   - Performs arithmetic and logical operations.
   - Operates based on the control signals.

## Usage
### Simulation
1. Load the VHDL files into a simulation tool (e.g., ModelSim, Vivado).
2. Run the **`Top_Level_ALU_Testbench`** for functional verification.
3. Observe waveforms to verify:
   - Register loading behavior.


### Testbench Highlights
- Loads values into registers A and B.
- Performs addition using the ALU.
- Validates results via the shared data bus and flag outputs.

## How to Run
1. Compile both `Top_Level_ALU_System.vhd` and `Top_Level_ALU_Testbench.vhd`.
2. Simulate the testbench.
3. Analyze the simulation results to ensure correct ALU behavior.

## Contributing
Feel free to open issues or submit pull requests for improvements to the ALU design or testbench.

