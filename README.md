# Memory Project – Synchronous FIFO (Verilog)

### Overview
A clean and modular Verilog implementation of a **Synchronous FIFO (First-In-First-Out)** buffer. The design ensures reliable data buffering with essential status indicators—**empty**, **full**, **overflow**, **underflow**—and supports parameterized data width and depth.

---

### Features
- **Parameterized Width & Depth**: Easily configure FIFO bit-width and storage depth.
- **Simple Read/Write Interface**: Controlled via `write_enable`, `read_enable` signals.
- **Status Indicators**: Includes flags for `full`, `empty`, `overflow`, and `underflow`.
- **Testbench Included**: Provides automated functional verification through a standalone testbench.
- **Simulation Ready**: Includes a ModelSim/QuestaSim script (`run.do`) for quick simulation setup.

---

### Directory Structure
Synchronous_FIFO/
── src/ # RTL source files
 └── syn_fifo.v/n
 
── tb/ # Testbench
 └── tb.v/n
 
── sim/ # Simulation script
 └── run.do/n
 
── waveform.png # (Optional) Simulation waveform image
└── README.md # Project overview and instructions


---

### Getting Started

#### Prerequisites
- Verilog simulator (ModelSim, QuestaSim, or equivalent)
- Terminal with access to simulation tool

#### Simulation Steps
1. Navigate to project root directory.
2. Launch your simulator and compile RTL + testbench:
   ```tcl
   vlog src/syn_fifo.v tb/tb.v
