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
    CP1: coverpoint (tr.p + tr.k + 5'b00000) {bins test[] = {[0 : 22]};}
    // (tr.p + tr.k + 5'b00000) we made this 5'b00000 to produce the output on 5 bits to cover number 22
    // {bins test[] = {[0 : 22]};} is to limit bins that we want to cover.
  endgroup : CovPort

  initial begin
    CovPort xyz;
    xyz = new();
    tr  = new();

    // Manual Coverage
    tr.p = 0;
    xyz.sample();

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
