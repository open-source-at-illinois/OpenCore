module not_tb();
    reg [7:0] A;
    reg [7:0] B;
    wire [7:0] Y;
    reg [3:0] error_cnt;

    not_func dut (
        .in1(A),
        .in2(B),
        .out(Y)
    );
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
    initial begin
	    error_cnt = 0;
        // Test 1
        A = 8'b00000000;
        #10;
        check(8'b11111111);

        // Test 2
        A = 8'b11111111;
        #10;
        check(8'b00000000);

        // Test 3
        A = 8'b10101010;
        #10;
        check(8'b01010101);

        // Test 4
        A = 8'b01010101;
        #10;
        check(8'b10101010);

        // Display total errors
        $display("error_cnt: %d", error_cnt);

        // End of tests
        $finish;
    end
endmodule
