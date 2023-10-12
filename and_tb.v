module tb_and();

    reg [7:0] A, B;
    wire [7:0] Y;
    reg [3:0] error_cnt;

    task check;
        input [7:0] expected;
        begin
            if (Y != expected)
            begin
                $display("ERROR: A=%b B=%b != Y=%b (gives Y=%b)", A, B, expected, Y);
                error_cnt++;
            end
            else 
            begin
                $display("PASS");                
            end

        end
    endtask
    and_func u_and8bit(
        .A(A),
        .B(B),
        .Y(Y)
    );

    // Clock not needed for combinational logic like AND

    // Apply test vectors
    initial begin
        error_cnt = 0;
         $dumpfile("and_func.vcd");
    $dumpvars(0, tb_and);
        // Test 1: A=0x00, B=0x00
        A = 8'b00000000; B = 8'b00000000;
        #10 
        check(8'b00000000);

        // Test 2: A=0xFF, B=0x00
        A = 8'b11111111; B = 8'b00000000;
        #10 
        check(8'b00000000);

        // Test 3: A=0xFF, B=0xFF
        A = 8'b11111111; B = 8'b11111111;
        #10 
        check(8'b11111111);

        // Test 4: A=0x55, B=0xAA
        A = 8'b01010101; B = 8'b10101010;
        #10 
        check(8'b00000000);

        $display("error_cnt=%b", error_cnt);
        // End of tests
        $finish;
    end

endmodule
