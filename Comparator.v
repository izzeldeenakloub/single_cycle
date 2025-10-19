module Comparator(equal, a, b); 
input [31:0] a, b; 
output equal; 
reg equal;
always @(a or b)
  begin
  if ((a-b)==0)
      equal=1;
      else
      equal=0;
  end
endmodule 