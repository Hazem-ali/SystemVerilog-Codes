module arbiter (
    output logic [1:0] grant,
    input logic [1:0] request,
    input logic rst,
    input logic clk
);
  always @(posedge clk or posedge rst) begin
    if (rst == 1 || request == 2'b00) begin
      grant <= 2'b00;
    end else if (request == 2'b10 || request == 2'b11) begin
      grant <= 2'b10;
    end else if (request == 2'b01) begin
      grant <= 2'b01;
    end

  end

endmodule

// TOP MODULE: the driver of both module and testbench
module top;
    logic [1:0] grant, request;
    logic clk, rst;
    // optimized move: clock can be of type bit so that no need for initialization

    initial clk = 0;

    always #5 clk = ~clk;

    arbiter a1(grant, request, rst, clk);
    test t1(grant, request, rst, clk);
    initial begin
        $dumpfile('test.vcd');
        $dumpvars;
        #100 $finish;
    end


endmodule
