bit running = 1;

typedef enum {
  INIT,
  DECODE,
  IDLE
} fsmState_e;


interface fsmifc (
    input bit clk
);
  bit pi, po;
  bit reset;
  fsmState_e state;


  clocking cbtb @(posedge clk);
    input state;
  endclocking



  clocking cbdut @(posedge clk);
    output state;
  endclocking


  modport tb(output pi, reset, clocking cbtb);
  modport dut(input pi, reset, output po, clocking cbdut);

endinterface


module fsm (
    fsmifc.dut abc
);
  fsmState_e pstate;
  always @(abc.cbdut) begin

    case (pstate)
      IDLE:
      if (abc.pi == 1) begin
        pstate = INIT;
        abc.po = 0;
      end

      INIT:
      if (abc.pi == 1) begin
        pstate = DECODE;
        abc.po = 1;
      end else begin
        pstate = IDLE;
        abc.po = 0;
      end

      DECODE:
      if (abc.pi == 1) begin
        pstate = IDLE;
        abc.po = 1;
      end else begin
        pstate = DECODE;
        abc.po = 1;
      end


    endcase
    abc.cbdut.state <= pstate;

  end


endmodule


module test (
    fsmifc.tb ifc
);

  class Transaction;
    rand bit x;
  endclass

  //  Covergroup: cg_fsm
  //
  covergroup cg_fsm;
    // cover point for state transitions
    CP1: coverpoint ifc.cbtb.state {
      bins t1 = (IDLE => INIT);
      bins t2 = (IDLE => IDLE);
      bins t3 = (INIT => DECODE);
      bins t4 = (INIT => IDLE);
      bins t5 = (DECODE => DECODE);
      bins t6 = (DECODE => IDLE);
    }

  endgroup : cg_fsm

  initial begin
    Transaction tr; // class that can hold random variables
    cg_fsm xyz;
    xyz = new();
    tr = new();

    ifc.reset = 1;
    #22 ifc.reset = 0;
    $display("------------------------------------------------------");
    repeat (10) begin
      assert (tr.randomize());  // create a transaction
      ifc.pi <= tr.x; // assigning x value to pi before sampling
      xyz.sample();
      @ifc.cbtb;
    end
    running = 0;



  end


endmodule

module top;
  bit clk;
  initial begin
    clk = 0;
    while (running) #5 clk = !clk;
  end
  fsmifc u1 (clk);
  test u2 (u1.tb);
  fsm u3 (u1.dut);


endmodule
