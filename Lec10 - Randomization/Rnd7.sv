//################## adding runtime constraints ##################


class Transaction;
  rand bit [31:0] addr, data;
  constraint c1 {addr inside {[0 : 100], [1000 : 2000]};}

endclass


program test;
  Transaction t;
  initial begin
    t = new();
    for (int i = 0; i < 10; ++i) begin

      // addr is 50-100, 1000-1500, data < 10
      assert (t.randomize() with {
        // additional constraint
        addr >= 50;
        addr <= 1500;
        data < 10;
      });

      $display("Addr = %0d, Data = %0d", t.addr, t.data);

      // force addr to a value, data > 10
      assert (t.randomize() with {
        addr == 2000;
        data > 10;
        data < 100;
      });

      $display("Addr = %0d, Data = %0d", t.addr, t.data);
      $display("-----------------------");

    end
  end
endprogram
