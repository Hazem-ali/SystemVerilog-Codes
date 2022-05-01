module test();
    typedef union {int my_int; real my_float;} num_u;

    num_u test_number;

    initial begin
        test_number.my_int = 60;
        $display(test_number); // '{my_int:60, my_float:2.96439e-322}
    end

endmodule