interface intf (
    input clk
);
  logic read, enable;
  logic [7:0] addr, data;

  // clocking is used to synchronize the read and write (by default in testbench)
  clocking cb @(posedge clk);
    default input #10ns output #2ns;
    // output comes after 2ns from clk
    // input gets read before 10ns from clk
    output read, enable, addr;
    input data;
  endclocking

  modport dut(input enable, read, addr, output data);
  modport tb(clocking cb);  // because by default we use clocking in testbench only



endinterface




module testbench (
    intf.tb x
);
  initial begin
    x.cb.read   <= 1;
    x.cb.enable <= 1;
    x.cb.addr   <= 7;

  end
endmodule
