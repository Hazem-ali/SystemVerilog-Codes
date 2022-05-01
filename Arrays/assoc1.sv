module arrays();
    initial begin
        bit [39:0] xyz[int];
        // associative array (key-value pairs)
        // bit [value_type] name[key_type]
        int idx = 1;

        repeat(20) begin
            xyz[idx] = idx;
            idx = idx << 1; // shift left once (multiply by 2)
        end

        $display(xyz);
    end
    
endmodule