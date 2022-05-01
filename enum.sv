module test();
    // Enum for states (init, decode, idle)
    typedef enum  { init, decode, idle } FSM_STATE;

    FSM_STATE present, next;
    // every variable of enum takes the first enum value by default (like init here)

    initial begin
        $display(present);
        $display(present.name);

        present = idle;
        case (present)
            init: next = decode;
            decode: next = idle;
            idle: next = init; // this the case it will pass through
            default: $display("error");

        endcase
        $display("Now");
        $display(present.name);
        $display(next.name);
    
    end

endmodule