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
    rand bit [31:0] d;
    rand bit [ 2:0] p;
    rand bit [ 3:0] k;
  endclass

  Transaction tr;

  //  Covergroup: CovPort (inside the tb itself)
  //
  covergroup CovPort;
    CP1: coverpoint tr.k {
      bins zero = {0};  // a specific bin for zero and named zero for clarity
      bins low = {[1 : 3], 5};  // one bin for low numbers: [1, 2, 3, 5]
      bins hi[] = {[8 : $]};  // array of bins for numbers 8 and higher (8, 9, 10, 11, ..., 15)
      bins misc = default; // bin for all other numbers (not covered by bins above, so they're not counted in coverage)
    }
  endgroup : CovPort

  initial begin
    CovPort xyz;
    xyz  = new();
    tr   = new();

    // Manual Coverage
    // tr.p = 0;
    // xyz.sample();

    repeat (100) begin
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
