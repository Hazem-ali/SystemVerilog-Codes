module test (
    input  logic [1:0] grant,
    output logic [1:0] request,
    output logic [1:0] rst,
    input  logic [1:0] clk
);

  initial begin
    #7 rst <= 1;
    #5 rst <= 0;
    @(posedge clk) request <= 2'b01;
    $display("## NOW Request 01 at time %t", $time);

    repeat (2) @(posedge clk);

    if (grant != 2'b01) begin
      $display("Error in grant, time is %t", $time);
    end else begin
      $display("Success, time is %t", $time);

    end

  end


endmodule
