module arrays();
    bit [4:0] on[10];
    int total;
    longint j;
    initial begin
       foreach (on[i]) begin
           on[i] = i;
           $display("%0d: %b",i,on[i]);
       end
       
       $display("Sum of array = ", on.sum());
       $display("Sum of array = %0d", on.sum() with (int'(item)));
    end
    
endmodule