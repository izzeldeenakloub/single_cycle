module SignExtend (
  output reg [31:0] SEout,
  input [31:0] in,
  input Iformat, LW, SW, BEQ, JAL, JALR
);
always @(*) begin
  // Default assignment to prevent latch
  SEout = 32'b0;

  if (Iformat | LW | JALR)
    SEout = {{20{in[31]}}, in[31:20]};
  else if (SW)
    SEout = {{20{in[31]}}, in[31:25], in[11:7]};
  else if (BEQ)
    SEout = {{20{in[31]}}, in[31], in[7], in[30:25], in[11:8]};
  else if (JAL)
    SEout = {{12{in[31]}}, in[31], in[19:12], in[20], in[30:21]};
end
endmodule
