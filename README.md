# FIFO RTL to GDSII using OpenLane (SKY130)

## 📌 Overview
This project demonstrates a complete digital ASIC design flow, starting from RTL design and functional verification of a FIFO (First-In-First-Out) buffer, and ending with physical layout generation (GDSII) using an open-source toolchain.

The goal of this project was to understand and implement the full **RTL → GDSII** flow, including synthesis, placement, routing, and timing analysis.

---

## 🧠 What This Project Covers

- RTL design of a synchronous FIFO
- Functional verification using simulation
- Timing constraint definition (SDC)
- ASIC flow execution using OpenLane
- Layout generation and inspection (GDSII)
- Basic analysis of timing and design reports

---

## 🏗️ Design Details

### FIFO Specifications
- Parameterizable depth and data width
- Synchronous design (single clock domain)
- Control signals:
  - `wr_en` (write enable)
  - `rd_en` (read enable)
  - `full`
  - `empty`
- Internal structure:
  - Write pointer
  - Read pointer
  - Memory array (register-based)

---

## 🧪 Functional Verification

The FIFO was verified using simulation (ModelSim).

### Test scenarios included:
- Reset behavior
- Sequential writes and reads
- FIFO fill (full condition)
- FIFO drain (empty condition)
- Simultaneous read and write operations

Waveforms were analyzed to confirm:
- Correct data ordering (FIFO property)
- Proper assertion of `full` and `empty`
- No overflow or underflow conditions

---

## ⚙️ ASIC Flow (RTL → GDSII)

The design was implemented using the OpenLane flow with the SKY130 PDK.

### Flow Steps:
1. **Synthesis**
   - RTL converted to gate-level netlist
2. **Floorplanning**
   - Core area and placement regions defined
3. **Placement**
   - Standard cells placed in rows
4. **Clock Tree Synthesis (CTS)**
   - Clock buffering and distribution
5. **Routing**
   - Interconnects created using metal layers
6. **Signoff (STA)**
   - Timing checks (setup/hold)
7. **GDSII Generation**
   - Final layout produced

---

## 📂 Project Structure

designs/fifo/
│
├── src/
│ └── fifo.v # RTL design
│
├── constraints.sdc # Timing constraints
├── config.json # OpenLane configuration
│
└── runs/
└── fifo_run1/
├── logs/
├── reports/
├── results/
│ ├── synthesis/
│ ├── placement/
│ ├── routing/
│ └── final/
│ ├── gds/FIFO.gds
│ ├── def/
│ └── verilog/


---

## 📊 Results

### ✅ Flow Status
- Flow completed successfully

### ⏱ Timing
- No setup violations
- No hold violations

### ⚠️ Warnings
- Max fanout violations observed
- Default SDC used for PnR and signoff

*(These are common for small designs and can be improved with better constraints and buffering.)*

---

## 🧾 Key Output Files

| File | Description |
|------|------------|
| `FIFO.gds` | Final physical layout (GDSII) |
| `FIFO.v` (final) | Gate-level netlist |
| `FIFO.def` | Placement and routing information |
| Reports | Timing, area, and design checks |

---

## 🛠️ Tools & Resources Used

- OpenLane (ASIC flow automation)
- SKY130 PDK (open-source process design kit)
- Yosys (RTL synthesis)
- OpenROAD (placement, routing, CTS)
- Magic / KLayout (layout visualization)
- ModelSim (functional verification)
- Docker (Linux environment on Windows)

---

## 📚 Key Learnings

### Technical
- Complete understanding of ASIC design flow
- Difference between RTL, gate-level, and physical design
- Importance of timing constraints (SDC)
- Basics of placement, routing, and clock distribution
- Interpretation of STA reports and warnings

### Practical
- Setting up and debugging OpenLane environment
- Managing PDK dependencies using Volare
- Handling Docker-based workflows
- Debugging synthesis and flow errors

---

## 🚀 Future Improvements

- Add assertions and self-checking testbench (scoreboard)
- Improve SDC constraints for better timing control
- Fix fanout violations using buffering strategies
- Extend design to larger modules (e.g., ALU or RISC-V core)
- Integrate memory macros for realistic designs

---

## 🎯 Conclusion

This project successfully demonstrates a full open-source ASIC design flow from RTL to GDSII. It serves as a foundational step toward designing more complex digital systems such as processors and SoCs.

---

## 📎 Author

Akash Biyani  
Master’s Student – Embedded Computing Systems  
RPTU Kaiserslautern

---
