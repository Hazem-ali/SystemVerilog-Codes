// Code your design here
module arrays();
  initial begin
    bit[31:0] src[5],dst[5];
    
    for (int i=0; i < $size(src); i++)
      src[i] = i;
    
    foreach(dst[j])
      dst[j] = src[j]*2;
    
    foreach(src[j])
        $display("src[%0d] = %b = %0d       dst[%0d] = %b = %0d",
                 j,src[j],src[j],j,dst[j],dst[j]);
  end
endmodule
