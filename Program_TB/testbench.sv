
// using module in tb makes the timing problem
// module test (
//     input bit [7:0] addr
// );
//   initial begin
//     $display("addr = %0d", addr);
//   end

// endmodule


// replace module with program
// this solves the timing problem by reading the data in the reactive region
program test (
    input bit [7:0] addr
);
  initial begin
    $display("addr = %0d", addr);
  end

endprogram
