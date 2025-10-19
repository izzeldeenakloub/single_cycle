module Mux_3_to_1(out, s, i2, i1, i0); 
 input [31:0] i2, i1, i0; 
 input [1:0]s; 
 output [31:0]out; 
reg [31:0] out;
always @(s or i2 or i1 or i0)
case(s)
2'b00 : out= i0;
2'b01 : out= i1;
2'b10 : out= i2;
2'b11 : out= 32'b0;
endcase
endmodule 