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

    rand bit [3:0] kind;
    rand bit [2:0] port;
  endclass

  Transaction tr;

  //  Covergroup: CovPort (inside the tb itself)
  covergroup CovPort;
    port: coverpoint tr.port {
      bins port[] = {[0 : $]};  // bins for port values
    }
    kind: coverpoint tr.kind {
      bins zero = {0};  // bin for zero
      bins lo = {[1 : 3]};  // one bin for these values 
      bins hi[] = {[8 : $]};  // array of bins for the rest
      bins misc = default;  // bin for uncovered values
    }
    cross kind, port{
      // here we have a cross between the two coverpoints
      // but excluding some combinations (if happened, it will not be recorded in coverage)
      ignore_bins hi = binsof (port) intersect {7};
      ignore_bins md = binsof (port) intersect {0} && binsof (kind) intersect {[9 : 11]};
      ignore_bins lw = binsof (kind.lo);

    }

  // cross coverage (all combinations of the two variables)


  endgroup : CovPort

  initial begin
    CovPort xyz;
    xyz = new();
    tr  = new();


    for (int i = 0; i < 100; i++) begin
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
