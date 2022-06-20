// illegal bins

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

    rand bit [2:0] port_a, port_b;
    rand bit [3:0] k;
  endclass

  Transaction tr;

  //  Covergroup: CovPort (inside the tb itself)

  // making a covergroup with arguments that can be called with data changes (like functions)
  covergroup CovPort(ref bit [2:0] port, input int mid);
    CP1: coverpoint port {
      bins lo = {[0 : mid - 1]};  // assign low values below mid
      bins hi = {[mid : $]};  // after mid is considered high
    }
  endgroup : CovPort

  initial begin
    CovPort cov1, cov2;
    tr  = new();
    cov1 = new(tr.port_a, 4);
    cov2 = new(tr.port_b, 2);

    for (int i = 0; i < 100; i++) begin
      assert (tr.randomize);
      cov1.sample(); 
      cov2.sample(); 
      @ifc.cb;  // wait a cycle
    end


    running = 0;
    $display("Coverage of 1: %.2f%%", cov1.get_coverage());
    $display("Coverage of 2: %.2f%%", cov2.get_coverage());
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
