module PC_Adder(
	input [9:0]address,
	output [9:0] N_address
);

N_address = address+1;
endmodule
