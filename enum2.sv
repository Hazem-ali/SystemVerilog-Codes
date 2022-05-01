module test();
    typedef enum  { red, green = 3, blue = 1, yellow } color;

    color my_color;


 
    initial begin
        
        my_color = green;
        $display(my_color, ": ", my_color.name);

        my_color = my_color.next;
        $display(my_color, " (Applying Next): ", my_color.name);
        
        my_color = my_color.last;
        $display(my_color, " (Applying Last): ", my_color.name);
        
        my_color = my_color.prev;
        $display(my_color, " (Applying Prev): ", my_color.name);
        
        my_color = my_color.first;
        $display(my_color, " (Applying first): ", my_color.name);

        // 3: green
        // 1 (Applying Next): blue
        // 2 (Applying Last): yellow
        // 1 (Applying Prev): blue
        // 0 (Applying first): red
    end

endmodule