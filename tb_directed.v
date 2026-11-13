`timescale 1ns/1ps
module tb_directed;
  reg [3:0] A, B; reg Cin;
  wire [3:0] Sum; wire Cout;
  four_bit_adder uut(A, B, Cin, Sum, Cout);
  task apply(input [3:0] a, b, input c, input [3:0] es, input ec, input integer n);
    begin
      A = a; B = b; Cin = c; #20;
      $display("TC%0d | A=%b B=%b Cin=%b | Sum=%b Cout=%b | expected Sum=%b Cout=%b | %s",
               n, A, B, Cin, Sum, Cout, es, ec, ({Cout,Sum}==={ec,es}) ? "PASS" : "FAIL");
    end
  endtask
  initial begin
    $dumpfile("adder.vcd"); $dumpvars(0, tb_directed);
    apply(4'b0001, 4'b0011, 0, 4'b0100, 0, 1);
    apply(4'b0101, 4'b0110, 1, 4'b1100, 0, 2);
    apply(4'b1111, 4'b1111, 0, 4'b1110, 1, 3);
    apply(4'b0000, 4'b0000, 0, 4'b0000, 0, 4);
    apply(4'b1111, 4'b1111, 1, 4'b1111, 1, 5);
    apply(4'b1111, 4'b0000, 0, 4'b1111, 0, 6);
    apply(4'b1111, 4'b0000, 1, 4'b0000, 1, 7);
    $finish;
  end
endmodule
