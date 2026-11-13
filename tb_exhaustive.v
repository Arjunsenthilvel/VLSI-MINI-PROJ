module tb_exhaustive;
  reg [3:0] A, B; reg Cin; wire [3:0] Sum; wire Cout;
  integer i, errors;
  four_bit_adder uut(A, B, Cin, Sum, Cout);
  initial begin
    errors = 0;
    for (i = 0; i < 512; i = i + 1) begin
      {Cin, A, B} = i[8:0]; #1;
      if ({Cout, Sum} !== A + B + Cin) begin
        $display("ERROR: %d + %d + %d gave %d", A, B, Cin, {Cout, Sum}); errors = errors + 1;
      end
    end
    $display("Exhaustive test: 512 vectors applied, Errors = %0d", errors);
    $finish;
  end
endmodule
