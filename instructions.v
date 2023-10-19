module instructions(
    input  [3:0] addr,
    output  [8:0] output
); 
// 2 bit opcodes
// first four instructions are to load values into register file
// 3 bit registers
    always @(.*)
    begin
        case (addr)
            4'h0000: 
                output = 8'hfefe;
            4'd1: 
                output = 8'hf1f1;
            4'd2: 
                output = 8'h0000;
            4'd3: 
                output = 8'hffff
            4'd4: 
                output = 8'haaaa;
            4'd5: 
                output = 8'hbbbb;
            4'd6: 
                output = 8'hcccc;
            4'd7: 
                output = 8'h0101;


            // instructions
            4'd8: 
                output = 8'b00011111; // R3 &= R7

            4'd9:
                output = 8'b11001011; // R1 &= R7

        endcase
    end
endmodule