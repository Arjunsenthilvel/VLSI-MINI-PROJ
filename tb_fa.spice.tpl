* 1-bit full adder test
.include @HERE@/models_hdr.spice
.include @HERE@/fa_cell.spice
VDD vdd 0 1.8
VA  a   0 PULSE(0 1.8 40n 0.1n 0.1n 39.9n 80n)
VB  b   0 PULSE(0 1.8 20n 0.1n 0.1n 19.9n 40n)
VC  cin 0 PULSE(0 1.8 10n 0.1n 0.1n 9.9n 20n)
XU1 a b cin sum cout vdd 0 fa
CS sum 0 10f
CC cout 0 10f
.control
tran 0.1n 80n
foreach t 9n 19n 29n 39n 49n 59n 69n 79n
  meas tran vsum find v(sum) at=$t
  meas tran vcout find v(cout) at=$t
end
.endc
.end
