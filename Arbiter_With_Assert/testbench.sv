// ########### INTERFACE ###########

interface arbif (
    input bit clk
);

  logic [1:0] grant, request;
  logic rst;

endinterface


// ########### TESTBENCH ###########

program test (
    arbif xyz
);

  initial begin
    #7 xyz.rst <= 1;
    #5 xyz.rst <= 0;
    @(posedge xyz.clk) xyz.request <= 2'b01;
    $display("## NOW Request 01 at time %t", $time);

    repeat (2) @(posedge xyz.clk);

    // if (xyz.grant != 2'b01) begin
    //   $display("Error in grant, time is %t", $time);
    // end else begin
    //   $display("Success, time is %t", $time);
    // end


  end

  property abc;
    @(posedge xyz.clk) disable iff (xyz.rst) $isunknown(
        xyz.request
    ) == 0;
  endproperty

  ax :
  assert property (abc) $display("OK TMAM");
  else $display("moshkeleaa");

endprogram
