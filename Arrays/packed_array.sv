// Code your design here
module arrays();
    bit [3:0][7:0] barray[3]; 
    // array of 3 elements, each element contains 4 elements each 8 bits (Packed Array)
    
    bit [31:0] lw = 32'h0123_4567;
    bit [7:0][3:0] nibbles;
    
  initial begin
    barray[0] = lw;
    $displayb("barray: ", barray);
    $displayb("barray[0]: ", barray[0]);
    $displayb("barray[0][3]: ", barray[0][3]);
    $displayb("barray[0][3][0]: ",barray[0][3][0]);

    barray[0][3] = 8'hAF;
    barray[0][1][6]=1'b1;
    nibbles = barray[0];
    $displayh("nibbles: ", nibbles);
    


  end
endmodule