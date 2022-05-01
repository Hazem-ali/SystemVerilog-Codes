module ff (
    ff_if.dut abc
);

  always @(abc.cb) begin
    if (abc.rst == 1) begin
      abc.cb.q <= 0;
      // NOTE clocking uses non blocking assingment

    end else begin
      abc.cb.q <= abc.d;
    end
  end
endmodule


module top (
    output logic clk
);

  initial clk = 0;
  initial forever #5 clk = ~clk;

  ff_if i1 (clk);

  ff u1 (i1.dut);
  test t1 (i1.tb);

  initial begin
    $dumpfile("test.vcd");
    $dumpvars;
  end



endmodule
