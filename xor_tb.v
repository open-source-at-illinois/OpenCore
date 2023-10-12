module xor_tb;
     reg [7:0] A, B;
    wire [7:0] Y;
    reg [3:0] error_cnt;

    // Implement 'check' task

        initial 
        begin
            error_cnt = 0;
            $dumpfile("xor_func.vcd");
            $dumpvars(0, tb_xor);
            // Implement test vectors

// A = 8'b11111111, B = 8'b00000000
// Expected out = 8'b11111111

// A = 8'b11111111, B = 8'b11111111
// Expected out = 8'b00000000

// A = 8'b10101010, B = 8'b01010101
// Expected out = 8'b11111111

// A = 8'b11001100, B = 8'b00110011
// Expected out = 8'b11111111

// A = 8'b11110000, B = 8'b00001111
// Expected out = 8'b11111111

// A = 8'b10011001, B = 8'b01100110
// Expected out = 8'b11111111

            
        end

endmodule