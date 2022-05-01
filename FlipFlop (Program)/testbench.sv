interface ff_if (
    input logic clk
);

  logic rst, d, q;

  clocking cb @(posedge clk);
    // make the output synchronised with clock
    // to avoid race condition
    output q;
  endclocking


  modport dut(clocking cb, input d, rst);
  modport tb(input q, output rst, d);

endinterface

program test(ff_if.tb xyz);

initial begin
    $monitor("At time %t, q = %b", $time, xyz.q);

    xyz.rst = 1;
    xyz.d = 0;
    #22 xyz.rst = 0;
    #10 xyz.d = 1
    #5 xyz.d = 0;
    #10;
    
end
    
endprogram