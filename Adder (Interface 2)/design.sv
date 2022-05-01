module adder (
    intf.dut abc
    //  when you define this, it is as if you instantiated an object and
    //  you can access its vars
);


  assign abc.c = abc.a + abc.b;
endmodule



module top;


    // IMPORTANT: HOW TO CALL INTERFACE AND USE ITS MODPORTS
    intf tf();
    adder a1(tf.dut);
    test t1(tf.tb);


endmodule