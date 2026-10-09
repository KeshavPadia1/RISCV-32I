# RISCV-32I — Single-Cycle RISC-V (RV32I) Processor in Verilog
 
A synthesizable, single-cycle implementation of the **RISC-V RV32I base integer instruction set**, written in Verilog HDL, together with a self-checking testbench and an assembled test program that exercises all 37 base instructions.

---

## Module hierarchy
 
```
t1_riscv_cpu
├── riscv_cpu
│   ├── controller
│   │   ├── main_decoder
│   │   └── alu_decoder
│   └── datapath
│       ├── mux2      (pcmux, ResultPC, srcbmux, lauipcmux)
│       ├── reset_ff  (PC register)
│       ├── adder     (pcadd4, pcaddbranch)
│       ├── reg_file
│       ├── imm_extend
│       ├── alu
│       └── mux4      (resultmux)
├── instr_mem
└── data_mem
```

## 11. References
 
- *The RISC-V Instruction Set Manual, Volume I: Unprivileged ISA* — RISC-V International.
- Harris & Harris, *Digital Design and Computer Architecture: RISC-V Edition* — single-cycle processor organisation.
- [`riscv_isa.jpg`](riscv_isa.jpg) — one-page RV32I encoding and instruction reference included in this repository.

---
<img width="1598" height="872" alt="image" src="https://github.com/user-attachments/assets/538791dc-fa61-4bf3-852e-a3b5b50e016d" />
