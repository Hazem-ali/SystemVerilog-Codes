// Code your design here
module arrays();
  initial begin
    bit[31:0] src[5] = '{5{8}};

    foreach(src[j])
        $display("src[%0d] = %b", j, src[j]);

    $displayb(src[0],,src[0][0],,src[0][3:1]);
    // src[0][3:1] inclusive (from index 3 to index 1 inclusive both)

  end
endmodule