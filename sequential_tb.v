module tb_counter_4bit;

reg clk;
reg rst;
wire [3:0] q;

counter_4bit u1 (
    .clk(clk),
    .rst(rst),
    .q(q)
);

// Clock generation
always begin
    #5 clk = ~clk;
end

initial begin
 $dumpfile("sequential.vcd");
    $dumpvars(0, tb_counter_4bit);
    clk = 0;               // Initial clock value
    rst = 1;               // Reset the counter
    #10 rst = 0;           // Release reset
    #100 $finish;          // Stop simulation after some time
end

initial begin
    $monitor("At time %5d: q = %b", $time, q);
end

endmodule