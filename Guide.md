# Verilog Crash Course
Note: `[]` is used to denote a general case of something

- Primitives:
```verilog
// Operators
// Verilog recognises standard C-style bitwise operations: & ^ ~ |

// Constants
//[bit-length]'[base][value];
// These are all the same:
7'b111; // Binary
7'h07; //Hex
7'd7; // Decimal

wire a; // wire is a 'type' that simply connects one signal to another. It doesn't hold values
wire [7:0] a_vector; // This is a 'bus', or an array of signals. Here it is 7 + 1 bits wide (Verilog uses 0 bit indexing)
reg b; // Registers hold values and can be set to new ones
reg [7:0] b; // 8-bit wide register
reg [7:0] c,d; // c, d are 8 bit wide buses

// Control structures
if (cond1)
begin
end
else if (cond2)
    // do something
    // if you only have a single statement begin/end can be omitted
else (cond3)
begin
end

case ([symbol])
[literal1] : [statement] // if you hhave multiple statements, use begin/end
...
default: [ statement]
endcase
```
- Circuits in Verilog are implemented as `modules`. When you use them in bigger
circuits, you 'instantiante' them by creating single instances of them.
- All expressions in verilog are terminated by `;`

## Modules
```verilog
module some_subcircuit  (input a, b, c;
    output out);
    // module body
endmodule

module big_supercircuit();
    reg a, b, c;
    output x;
    some_subcircuit [instance_name](.a(a), .b(b), .c(c), .out(x)); //Now an instance of some_subcircuit exists in big_supercircuit
endmodule
```
### Task 1
Take a look at and.v!
## Assign and always statements
- `always` is a very important keyword in Verilog. It is used to create `always` blocks for sequential and combinational parts of your module. It watches for whatever is implied by `@([condition])`
```verilog
always @(*) // since * is used in the condition, this always block is always true.
begin
    and_output = a & b;
end

always @(posedge clk) // allow this always block to run only when 'clk' goes from 0 to 1 (posedge)
begin
    // do something everytime clk becomes positive
end
```
- `assign` is simply a shorthand for a combinational always block
```verilog
assign and_output = a & b;
// is the same as
always @(*) 
begin
    and_output = a & b;
end
```

### Task 2
Finish the implementation of `not_func` in `not.v`!


## Testbenches
- Testbenches allow us to test the operation of a circuit, and also provide features that aren't synthesizable (meaning that they can't be physically implemented in say, a design file).
- A testbench is required to have a top level module with no inputs and outputs. 
- When designing testbenches, simply imagine yourself setting some sequence inputs in some sequence and checking for the correct output. 
- We can use `$display` as a debug print statement (which is printed when the binary is run by `vvp`)
- Our setup uses `gtkwave` to see our waveforms. Therefore every testbench must include:
```verilog
initial 
begin
         $dumpfile("[output].vcd");
         $dumpvars(0, [testbench top module]);
         //...
end
```

## Combinational Testbenches
- To see what I'm talking about, take a look at `add_tb.v`
- This defines registers and wires that we will use to send inputs and get outputs to an instance of `and_func`. 
- We define a `task` to use as a helper function to check our output against some expected value and set error_cnt accordingly.
- Our `inital` block works as a sequence of inputs we provide.

### Task 3
Use `add_tb.v` and `not_tb.v` as a reference to finish implement `xor_tb.v`

## Sequential Testbenches
- Very similar to combinational testbenches in that we still are essentially simulating a sequence of inputs, but our test bench module also needs to turn set a clock signal since our sequential circuits presumable use a clock and do certain operations only on a specific part of a clock cycle. We will look at this when we get to FSMs.


### Task 4
- Use what you have learnt to make test benches and modules to implement OR!
## ALU
### Task 5
Use the case syntax to finish the ALU in `alu.v`. The logical circuit modules have been instantiated for you. Test it against `alu_tb.v`!


## FSMs and CPU
To understand how FSMs can be implemented in Verilog, lets implement a simple
CPU that uses our ALU and can execute basic operations. It has an 8-bit register file with 8 registers for general use. It also has `PC` (program  counter, or the address in memory the CPU is on), and `IR` (hold the data from the memory pointed to by PC)

Our instructions are of the following format:
```
[2-bit opcode][register 1(3-bit)][register 2(3-bit)]
```
Which executes:
```
register 1 = register 1 (operation) register 2
```

Mind you, the operation can be `and`,`xor`, `not`, and `or`.

In `instructions.v` is a simple module that looks at an input address and returns an instruction residing in 'memory' (but its really just a big if-statement)

However, the first 8 instructions (and corresponding states) are simply loading initial values into the 8 registers in your register file.

What follows are instructions that you can test and check if they execute.


## How to use and build an FSM

An FSM has two components in HDL languages:
- Next State Logic: Use a combinational block to have the next state ready depending on your current state
- Execution logic: Use a sequantial block to do something depending on your current state. Also remember to set some behaviour for reset and always going to the next state!
We will discuss some intuition behind these concepts in the session!


### Task 6:
Finish `cpu.v` and use `gtkwave` to verify that the cpu executes the instructions correctly. Specifically, you need to implement next state logic for register load, along with logic to decide the instruction 'execution' stage you will jump to after incrementing `PC`!


### CPU FSM States
1) Load Registers (`reg[num]_load`)
2) Load IR (`ir_load`)
3) Increment PC (`pc_incr`) and also:

 - if opcode(IR) == AND: Go to `and_exec`
 - if opcode(IR) == XOR: Go to `xor_exec`
 - if opcode(IR) == NOT: Go to `not_exec`
 - if opcode(IR) == OR: Go to `or_exec`
4) Go to `ir_load` 

**If `rst` is high, reset PC to 0 and go to `reg_load`!**