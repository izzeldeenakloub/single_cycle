module Mux_2_to_1(out, s, i1, i0); 
input [31:0] i1, i0; 
input s; 
output [31:0]out; 
reg [31:0] out;
always @ (s or i0 or i1)
case(s) 
1'b0:out=i0;
1'b1:out=i1;
endcase
endmodule 
