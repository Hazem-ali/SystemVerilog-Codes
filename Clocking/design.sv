module memory (
    intf.dut a
);
  logic [7:0] mem[256];
  initial begin
    foreach (mem[i]) begin
      mem[i] = i * i;
    end
  end

  always @(a.enable, a.read) begin

    if (a.enable == 1 && a.read == 1) a.data = mem[a.addr];


  end

endmodule



module top;

  bit clk;
  always #20 clk = ~clk;


  intf i1 (clk);
  memory m1 (i1.dut);
  testbench t1 (i1.tb);

  initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    #200 $finish;
  end
  


endmodule
