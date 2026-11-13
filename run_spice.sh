#!/bin/bash
# Runs the transistor-level Sky130 simulations of the 1-bit and 4-bit adders.
# Fixes the "Could not find include file corners/tt.spice" error by using the
# official SkyWater device-model repository directly.
set -e
HERE="$(cd "$(dirname "$0")/spice" && pwd)"
M="${SKY130_MODELS:-$HOME/sky130_models}"
if [ ! -d "$M/cells/nfet_01v8" ]; then
  git clone --depth 1 https://github.com/google/skywater-pdk-libs-sky130_fd_pr.git "$M"
fi
P="$M/models/parameters"; D="$M/cells"
cat > "$HERE/models_hdr.spice" << EOT
.param mc_mm_switch=0
.param mc_pr_switch=0
.include $P/lod.spice
.include $P/invariant.spice
.include $D/nfet_01v8/sky130_fd_pr__nfet_01v8__tt.pm3.spice
.include $D/nfet_01v8/sky130_fd_pr__nfet_01v8__mismatch.corner.spice
.include $D/pfet_01v8/sky130_fd_pr__pfet_01v8__tt.corner.spice
.include $D/pfet_01v8/sky130_fd_pr__pfet_01v8__mismatch.corner.spice
EOT
for f in adder4 tb_fa; do sed "s|@HERE@|$HERE|g" "$HERE/$f.spice.tpl" > "$HERE/$f.spice"; done
echo "=== 1-bit full adder (expect Sum/Cout = 0 or 1.8 V for the 8 input rows) ==="
ngspice -b "$HERE/tb_fa.spice" 2>&1 | grep -E "^vsum|^vcout|rror"
echo "=== 4-bit adder: delay and supply current ==="
ngspice -b "$HERE/adder4.spice" 2>&1 | grep -E "^tpd|^iavg|^ipk|rror"
echo "Waveform data written to $HERE/adder4_wave.txt"
