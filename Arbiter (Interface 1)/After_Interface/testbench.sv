// ########### INTERFACE ###########

interface arbif(input bit clk);

logic [1:0] grant,request;
logic rst;
    
endinterface


// ########### TESTBENCH ###########

module test (
    arbif xyz
);

  initial begin
    #7 xyz.rst <= 1;
    #5 xyz.rst <= 0;
    @(posedge xyz.clk) xyz.request <= 2'b01;
    $display("## NOW Request 01 at time %t", $time);

    repeat (2) @(posedge xyz.clk);

    if (xyz.grant != 2'b01) begin
      $display("Error in grant, time is %t", $time);
    end else begin
      $display("Success, time is %t", $time);

    end

  end


endmodule
