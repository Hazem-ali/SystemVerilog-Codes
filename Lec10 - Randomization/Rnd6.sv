class Packet;
rand int length;
constraint c_short {length inside {[1 : 32]};}
constraint c_long {length inside {[1000 : 1023]};}
endclass


program test;
Packet p;
initial begin
  p = new();
  // creating long packet by disabling short packet
  p.c_short.constraint_mode(0);  // disable c_short
  assert (p.randomize()) $display("Length = %0d", p.length);


  // creating short packet by disabling long packet

  p.constraint_mode(0);  // disable all modes
  p.c_short.constraint_mode(1);  // enable c_short
  assert (p.randomize()) $display("Length = %0d", p.length);






end

endprogram
