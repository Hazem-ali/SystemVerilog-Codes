module designx (
    output bit [7:0] addr
);

  initial begin
    addr <= 10;
  end

endmodule



module top;
  logic [7:0] addr;
  designx d (addr);
  test u1 (addr);
endmodule
