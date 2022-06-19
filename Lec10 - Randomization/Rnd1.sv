class Stim;
  const bit [31:0] CONGEST_ADDR = 42;
  typedef enum {
    READ,
    WRITE,
    CONTROL
  } stim_e;

  randc stim_e kind;  // enumerated variable

  rand bit [31:0] len, src, dst;

  randc bit congestion_test;



  constraint c_stim {
    len < 1000;
    len > 0;

    if (congestion_test) {
      // if congestion_test is true so we make some constraints else other constraints are applied
      dst inside {[CONGEST_ADDR + 50 : CONGEST_ADDR + 100]};
      src == CONGEST_ADDR;


    } else {
      src inside {0, [2 : 10], [100 : 108]};
    }


  }

endclass


program test;

  Stim s;
  initial begin
    s = new();
    for (int i = 0; i < 3; ++i) begin

      label :
      assert (s.randomize())
      else $error("Assertion label failed!");
      $display(s);

    end


  end

endprogram






