bit running = 1;

module bus (
    busifc.dut abc
);

endmodule

interface busifc (
    input bit clk
);
  bit [31:0] data;
  bit [ 2:0] port;

  clocking cb @(posedge clk);

    output data, port;

  endclocking

  modport tb(clocking cb);
  modport dut(input data, port);



endinterface

module test (
    busifc.tb ifc
);
  class Transaction;

    bit reset;
    rand bit [2:0] p;
    rand bit [3:0] k;
  endclass

  Transaction tr;

  //  Covergroup: CovPort (inside the tb itself)
  covergroup CovPort;
    CP1: coverpoint tr.p iff (!tr.reset);  // here we sample tr.p if and only if tr.reset is false
  endgroup : CovPort

  initial begin
    CovPort xyz;
    xyz = new();
    tr = new();

    tr.reset = 0;

    // we're stopping sampling partially using stop() to see its functionality
    xyz.stop();
    for (int i = 0; i < 100; i++) begin

      // start sampling when i >= 90
      if (i >= 90) xyz.start();

      assert (tr.randomize);
      xyz.sample();  // takes the random sample and add it to the covergroup
      @ifc.cb;  // wait a cycle
    end

    // after this for loop, we have a covergroup with 10 samples only (when i >= 90)


    tr.reset = 1;
    // this sampling loop will not be covered because tr.reset is true (try it and see)
    repeat (50) begin
      assert (tr.randomize);
      xyz.sample();  // takes the random sample and add it to the covergroup
      @ifc.cb;  // wait a cycle
    end

    running = 0;
    $display("Coverage: %.2f%%", xyz.get_coverage());
  end


endmodule


module top;
  bit clk;
  initial begin
    clk = 0;
    while (running == 1) begin
      #5 clk = ~clk;
    end

  end
  busifc u1 (clk);
  bus b1 (u1.dut);
  test t1 (u1.tb);

endmodule
