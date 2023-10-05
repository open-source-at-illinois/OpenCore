module counter_4bit( input clk, input rst,      // Asynchronous reset
		    output [3:0] q  // 4-bit output
	    );

	    reg [3:0] count;

	    always @(posedge clk or posedge rst) begin
		        if (rst)
				        count <= 4'b0000;
		        else
			            count <= count + 1'b1;
		        end
				assign q = count;
endmodule
