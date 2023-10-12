module alu(
    input [7:0] in1, in2;
    input clk;
    input [1:0] opcode;
    output [7:0] o;
)
    wire [7:0] and_out, not_out, or_out, xor_out;
    and_func alu_and(.in1(A), in2(B), .out(and_out));
    or_func alu_or(.in1(A), in2(B), .out(or_out));
    not_func alu_not(.in1(A), in2(B), .out(not_out));
    xor_func alu_xor(.in1(A), in2(B), .out(xor_out));
    always @(*)    
    begin
        // Implement Mux
        // 00 = AND
        // 01 = NOT
        // 10 = XOR
        // 11 = OR
        case(opcode)
        endcase
    end

endmodule