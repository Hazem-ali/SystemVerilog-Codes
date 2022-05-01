// Code your design here
module arrays();
  initial begin
    bit[31:0] src[5] = '{0,1,2,3,4},
              dst[5] = '{5,4,3,2,1};
    

    if(src == dst)
        $display("1: src == dst");
    else
        $display("1: src != dst");
    
    dst = src; 

    src[0] = 5; // [5,1,2,3,4]
    
    $display("2: src %s dst", (src == dst)? "==":"!=");
    $display("3: src[1:4] %s dst[1:4]",(src[1:4] == dst[1:4])? "==":"!=");
 
  end
endmodule