module program_counter(
	input clk , rst,
	input [9:0] in,
	output reg [9:0] out

);
	always @(posedge clk or posedge rst)begin
		if(rst)begin
			out <= 10'b0;
		end
		else begin
			out <= in;
		end
		end
endmodule
