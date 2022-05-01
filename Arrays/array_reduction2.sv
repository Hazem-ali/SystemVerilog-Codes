module arrays();
    int count, d[] = '{9,1,8,3,4,4};
    int q[$];
    initial begin
    count = d.sum with ((item > 7 ? item : 0));
    $display(count);
    q = d.find with (item > 7);
    $display(q);
    
    end
    
endmodule