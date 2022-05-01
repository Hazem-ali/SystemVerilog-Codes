module arrays();
    int switch[string];
    int min_a, max_a;

    initial begin
    int file_handle;
    int i;
    string s;
    file_handle = $fopen("switch.txt","r");

    while (! $feof(file_handle)) begin
        $fscanf(file_handle, "%d %s",i,s); // the expected scanline format
        switch[s] = i;

        end
    $fclose(file_handle);
    $display(switch);
    end
    
endmodule