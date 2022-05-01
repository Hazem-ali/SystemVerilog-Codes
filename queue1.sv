module queue();
    int j = 7;
    int q[$] = {3,4};
    int tq[$] = {0,2,5};
    initial begin
        q.insert(1,j);
        $display(q);
        q = {q[0],15,q[1:$],tq};
        $display(q);

    end
    
endmodule