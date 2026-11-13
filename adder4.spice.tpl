* 4-bit ripple-carry adder, Sky130 tt, transistor level
.include @HERE@/models_hdr.spice
.include @HERE@/fa_cell.spice
VDD vdd 0 1.8
VA0 a0 0 PWL(0n 1.8 60n 1.8 60.1n 0.0 80n 0.0 80.1n 1.8 140n 1.8)
VB0 b0 0 PWL(0n 1.8 20n 1.8 20.1n 0.0 40n 0.0 40.1n 1.8 60n 1.8 60.1n 0.0 80n 0.0 80.1n 1.8 100n 1.8 100.1n 0.0 140n 0.0)
VA1 a1 0 PWL(0n 0.0 40n 0.0 40.1n 1.8 60n 1.8 60.1n 0.0 80n 0.0 80.1n 1.8 140n 1.8)
VB1 b1 0 PWL(0n 1.8 60n 1.8 60.1n 0.0 80n 0.0 80.1n 1.8 100n 1.8 100.1n 0.0 140n 0.0)
VA2 a2 0 PWL(0n 0.0 20n 0.0 20.1n 1.8 60n 1.8 60.1n 0.0 80n 0.0 80.1n 1.8 140n 1.8)
VB2 b2 0 PWL(0n 0.0 20n 0.0 20.1n 1.8 60n 1.8 60.1n 0.0 80n 0.0 80.1n 1.8 100n 1.8 100.1n 0.0 140n 0.0)
VA3 a3 0 PWL(0n 0.0 40n 0.0 40.1n 1.8 60n 1.8 60.1n 0.0 80n 0.0 80.1n 1.8 140n 1.8)
VB3 b3 0 PWL(0n 0.0 40n 0.0 40.1n 1.8 60n 1.8 60.1n 0.0 80n 0.0 80.1n 1.8 100n 1.8 100.1n 0.0 140n 0.0)
VCIN cin 0 PWL(0n 0.0 20n 0.0 20.1n 1.8 40n 1.8 40.1n 0.0 80n 0.0 80.1n 1.8 100n 1.8 100.1n 0.0 120n 0.0 120.1n 1.8 140n 1.8)
XFA0 a0 b0 cin  s0 c1 vdd 0 fa
XFA1 a1 b1 c1   s1 c2 vdd 0 fa
XFA2 a2 b2 c2   s2 c3 vdd 0 fa
XFA3 a3 b3 c3   s3 cout vdd 0 fa
CL_s0 s0 0 10f
CL_s1 s1 0 10f
CL_s2 s2 0 10f
CL_s3 s3 0 10f
CL_cout cout 0 10f
.control
tran 0.05n 140n
set wr_vecnames
option numdgt=7
wrdata @HERE@/adder4_wave.txt v(a0) v(a1) v(a2) v(a3) v(b0) v(b1) v(b2) v(b3) v(cin) v(s0) v(s1) v(s2) v(s3) v(cout) v(c1) v(c2) v(c3) i(vdd)
meas tran tpd_cin_cout trig v(cin) val=0.9 rise=1 td=110n targ v(cout) val=0.9 rise=1 td=110n
meas tran tpd_cin_s3 trig v(cin) val=0.9 rise=1 td=110n targ v(s3) val=0.9 fall=1 td=110n
meas tran iavg avg i(vdd) from=0 to=140n
meas tran ipk  min i(vdd) from=0 to=140n
.endc
.end