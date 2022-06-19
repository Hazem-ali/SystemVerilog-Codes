class good;
  rand int len[];
  constraint c_len {
    foreach (len[i]) 
     len[i] inside {[1:255]}; 
  
  len.sum < 1024;
  len.size() inside {[1:8]};
  }  
endclass

program test;
  good a;

  initial begin
    a = new();

    for (int i=0; i<10; ++i) begin
      assert (a.randomize()); 
      $display("sum = %0d, size = %0d, array = ", a.len.sum, a.len.size, a.len);
    end

  end
  
endprogram