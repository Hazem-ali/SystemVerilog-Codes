// ################## USING VARIABLE DISTRIBUTION WEIGHTS ##################

class BusOps;
  // Operation Length
  typedef enum  { BYTE, WORD, LWORD } length_e;
  rand length_e len;

  // Weights for dist constraint
  bit [31:0] w_byte=1, w_word=3, w_lword=5;

  constraint c_len {
    len dist {
      BYTE := w_byte,
      WORD := w_word,
      LWORD := w_lword
    };
  }

endclass

//------------------------------

program test;
  BusOps s;
  initial begin
    s = new();
    for (int i=0; i<10; ++i) begin
      $display(" ");
      for (int j=0; j<10; ++j) begin
        assert (s.randomize()) 
        else   error_process
        $write(s.len.name,", ");
      end
    end
  end

endprogram