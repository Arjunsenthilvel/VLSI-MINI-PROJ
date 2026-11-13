### Simulation Results

**Verilog (Icarus Verilog):** all 7 directed test cases pass, and the exhaustive test of all 512 input combinations reports 0 errors.

![Verilog waveform](images/1_verilog_waveform.png)

![Verilog console output](images/6_verilog_console_output.png)

**Transistor-level (ngspice, Sky130 tt, VDD = 1.8 V):** a 28-transistor mirror-adder cell, used 4 times (112 transistors). All 7 test cases match the Verilog reference.

![SPICE waveforms](images/2_spice_waveforms_4bit.png)

| Metric | Value |
|---|---|
| Worst-case delay, Cin to Cout | 0.45 ns |
| Worst-case delay, Cin to Sum3 | 0.50 ns |
| Average supply current (test sequence) | 4.26 uA |
| Peak supply current | 1.23 mA |

![Carry ripple](images/3_carry_ripple_delay.png)

![SPICE results](images/7_spice_console_output.png)

Note: for 5 + 6 + 1 the correct result is Sum = 1100, Cout = 0.

### How to run

```bash
# Verilog
cd verilog
iverilog -o d tb_directed.v four_bit_adder.v full_adder.v && vvp d
iverilog -o e tb_exhaustive.v four_bit_adder.v full_adder.v && vvp e

# Transistor-level SPICE (downloads the Sky130 device models on first run)
./run_spice.sh
```

### Repository files

- `verilog/` - full adder, 4-bit adder, directed and exhaustive testbenches
- `spice/` - 28-transistor full-adder cell and SPICE testbenches (Sky130)
- `images/` - waveforms and result images
- `Minor_Project_1_Report.pdf` / `.docx` - project report
