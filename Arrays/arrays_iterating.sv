// Code your design here
module arrays();
  initial begin
    int abc[3][5];
    foreach(abc[i,j]) 
    /*

      similar to
      foreach (abc[i])
        foreach (abc[i][j])
          .......
    
    */
    
        abc[i][j] = 10 * i + j;
    
    
    foreach(abc[i])
    begin
        $write("%2d:", i);
        foreach(abc[, j])
            $write("%3d", abc[i][j]);
        $display;
    end
  end
endmodule
