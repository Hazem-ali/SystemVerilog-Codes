module test();
    parameter OPSIZE = 8;
    typedef reg [OPSIZE - 1 :0] opreg_t;

    opreg_t a, b;

    typedef bit [31:0] unit_t;
    typedef int unsigned unit1_t;

    unit_t reg_a;
    unit1_t reg_b;

    typedef int fixedArray5_t[5];

    fixedArray5_t f5;
    initial begin
        foreach (f5[i]) begin
            f5[i] = i*2;
        end
        $displayb("Uninitialized a: ", a);
        $displayb("Uninitialized reg_a: ", reg_a);
        $displayb("Initialized f5: ", f5);
    
        // Uninitialized a: xxxxxxxx
        // Uninitialized reg_a: 00000000000000000000000000000000
        // Initialized f5: '{0, 2, 4, 6, 8} 

    end

endmodule