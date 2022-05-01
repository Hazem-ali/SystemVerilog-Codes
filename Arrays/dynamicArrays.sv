// Code your design here
module arrays();
  int dyn[],d2[];
  initial begin
    dyn = new[6];
    foreach (dyn[j])
      dyn[j] = j;
    $display(dyn);
    d2 = dyn; // each of them are isolated array (NO call by reference, JUST copy)
    d2[0] = 5;
    $display(dyn, d2); 
    dyn = new[20](dyn);
    $display(dyn);
    $display("Size of dyn = %0d",$size(dyn));

    
  
  
  end
  
  
endmodule
