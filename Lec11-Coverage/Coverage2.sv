// Same as Coverage1 but adding coverage inside the class

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
  endclass

  class Transactor;
    Transaction tr;

    //  Covergroup: CovPort
    //
    covergroup CovPort;

      // for global coverage bin customizations
      // option.auto_bin_max = 2;

      CP1: coverpoint tr.p {
        option.auto_bin_max = 2;
      }  // customized for this line only

    endgroup : CovPort

    // To activate: Comment sample
    //  covergroup CovPort @(ifc.cb);
    //   CP1: coverpoint tr.p;
    // endgroup : CovPort


    function new;
      CovPort = new();
      tr = new();

    endfunction

    task main;

      assert (tr.randomize);

      ifc.cb.port <= tr.p;
      ifc.cb.data <= tr.d;

      CovPort.sample();  // takes the random sample and add it to the covergroup
      @ifc.cb;  // wait a cycle


    endtask

  endclass

  // Transaction tr;

  initial begin

    Transactor tx = new();

    // // Manual Coverage
    // tr.p = 4;
    // xyz.sample();

    repeat (8) begin
      tx.main();

    end

    running = 0;
    $display("Coverage: %.2f%%", tx.CovPort.get_coverage());
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
