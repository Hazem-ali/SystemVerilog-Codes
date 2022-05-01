module test();
    string str;

    initial begin
        str = "Mofty";
        $display("%s", str.getc(0));
        // M

        str.putc(0,"m");
        $display("%s", str);
        // mofty

        str = {str,"XYZ"};
        $display("%s", str);
        // moftyXYZ
        
        str = str.substr(0,4); // Inclusive
        $display("%s", str);
        // mofty

    end
endmodule