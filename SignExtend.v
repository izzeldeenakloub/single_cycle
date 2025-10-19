module SignExtend (SEout, in, Iformat, LW, SW, BEQ, JAL, JALR);
input [31:0] in;
input Iformat, LW, SW, BEQ, JAL, JALR;
output [31:0] SEout;
reg [31:0] SEout;
always @ (in)
begin 

  if (Iformat | LW | JALR)
  SEout={{20{in[31]}},in[31:20]};
  if (SW)
  SEout={{20{in[31]}},in[31:25],in[11:7]};
  if(BEQ)
  SEout={{20{in[31]}},in[31],in[7],in[30:25],in[11:8]};
  if (JAL)
  SEout={{12{in[31]}},in[31],in[19:12],in[20],in[30:21]};  
end           
endmodule 