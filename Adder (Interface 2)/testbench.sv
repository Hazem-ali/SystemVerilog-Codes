interface intf ();
  logic [3:0] a;
  logic [3:0] b;
  logic [4:0] c;

  // modport is used to define the interface of a module or testbench (declares how to use the interface)
  modport tb(output a, b, input c);
  modport dut(input a, b, output c);

endinterface


module test (
    intf.tb xyz
);

  initial begin
    xyz.a = 6;
    xyz.b = 4;

    $display("Value of a = %0d, b = %0d", xyz.a, xyz.b);
    #5 $display("SUM EQUALS: %0d", xyz.c);
    $finish;
  end


endmodule
