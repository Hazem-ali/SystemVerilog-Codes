// ########### MAIN MODULE ###########
module arbiter (
    arbif abc
);
  always @(posedge abc.clk or posedge abc.rst) begin
    if (abc.rst == 1 || abc.request == "00") begin
      abc.grant <= 2'b00;
    end else if (abc.request == "10" || abc.request == "11") begin
      abc.grant <= 2'b10;
    end else if (abc.request == 2'b01) begin
      abc.grant <= 2'b01;
    end

  end

endmodule



// ########### TOP MODULE ###########

// TOP MODULE: the driver of both module and testbench
module top;
    
    bit clk;
    always #5 clk = ~clk;


    arbif ai(clk);
    arbiter a1(ai);
    test t1(ai);
    
    
    initial begin
        $dumpfile("test.vcd");
        $dumpvars;
        #100 $finish;
    end


endmodule
