module tb_ALU();

    // Declare wires, registers, and error count
    reg [7:0] A, B;
    wire [7:0] Y;
    reg [1:0] select;
    reg [31:0] error_cnt = 0; // Assuming a max of 2^32-1 errors

    // Instantiate the ALU
    ALU u_ALU(
        .A(A),
        .B(B),
        .opcode(select),
        .Y(Y)
    );

    // Function to check results
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

    // Apply test vectors and check results
    initial begin
         $dumpfile("alu.vcd");
    $dumpvars(0, tb_ALU);
        // Test AND operation (00)
        select = 2'b00;
        A = 8'b11001100; B = 8'b10101010;
        #10;

        // Test NOT (01)
        check(8'b10001000);
        select = 2'b01;
        A = 8'b11001100;
        #10;
        check(8'b00110011);


        // Test XOR operation (10)
        select = 2'b10;
        A = 8'b11001100; B = 8'b10101010;
        #10;
        check(8'b01100110);

        // Test OR (11) 
        select = 2'b11; // Assuming 11 for OR as it wasn't originally defined
        A = 8'b11001100; B = 8'b10101010;
        #10;
        check(8'b11101110);


        // Display total errors
        $display("Total Errors: %d", error_cnt);

        // End of tests
        $finish;
    end

endmodule
