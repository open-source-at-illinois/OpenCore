module cpu( 
    input Clk,
    input rst);


     reg [3:0] PC;
     reg [7:0] IR;

    reg [3:0] state, next_state;
    reg [7:0] register_file[7:0];
    parameter reg0_load = 4'b0000;
    parameter reg1_load = 4'b0001;
    parameter reg2_load = 4'b0010;
    parameter reg3_load = 4'b0011;
    parameter reg4_load = 4'b0100;
    parameter reg5_load = 4'b0101;
    parameter reg6_load = 4'b0110;
    parameter reg7_load = 4'b0111;
    parameter ir_load = 4'b1000;
    parameter pc_incr = 4'b1001;

    wire curr_inst;
    instructions inst(.addr(pc), .output(curr_inst));
    parameter and_exec = 4'b1010;
    parameter or_exec = 4'b1011;
    parameter xor_exec = 4'b1100;
    parameter not_exec = 4'b1101;
     always @(posedge Clk) 
     begin 
        if (rst)
        begin
            PC <= 4'b0000;
            state = reg0_load;
        end
        else 
        begin
            state <= next_state
        end
        if (state == curr_inst) 
        begin
            IR <= curr_inst;
        end
        if (state == pc_incr)
        begin
            PC <= PC + 1;
        end
        if (state <= 4'b0111)   // in the nth register load state, load the value in IR into the n'th register
        begin
            register_file[state] <= IR;
        end

        // load register file with alu output for any of the *_exec states
     end

    always @(.*)
    begin
        // create the ALU circuitry
        //1. Set an appropriate control signal
        //2. Instantiate an alu with the correct register input
        //3. Make input mechanism for registers
    end

     always @(.*) 
     begin
        // make next states!

        case (state)

            // add register load states


            ir_load:
                next_state = pc_incr;
            pc_incr:
                ; // add logic to set next state depending on instruction in IR

            // instruction states
            and_exec:
                next_state = ir_load;
            or_exec:
                next_state = ir_load;
            or_exec:
                next_state = ir_load;
            xor_exec:
                next_state = ir_load;
            not_exec:
                next_state = ir_load;

            default:
                next_state = ir_load;
        endcase
     end
endmodule