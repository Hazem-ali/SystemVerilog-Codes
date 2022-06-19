class random;
  rand logic [15:0] r, s, t;

  constraint c_bidir {
    r < t;
    s == r;
    t < 30;
    s > 25;
  }
endclass


program test;
  random y;
  initial begin
    y = new();
    for (int i = 0; i < 10; ++i) begin
      assert (y.randomize())
      else $display("LOL");
      $display("r = %0d, s = %0d, t = %0d", y.r, y.s, y.t);
    end
  end
endprogram
