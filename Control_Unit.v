module Control_Unit(aluop, alusrc, pcsrc, memtoreg, regwrite ,memread, memwrite, branch, Iformat, LW, SW, BEQ, JAL, JALR, opcode, func3, func7);
  input [6:0] opcode, func7; 
  input [2:0] func3;
  output [2:0] aluop;
  output [1:0] memtoreg, pcsrc;
  output alusrc, regwrite, memread, memwrite, branch, Iformat, LW, SW, BEQ, JAL, JALR;		
  wire Rformat;
  assign  Rformat = ~opcode[6] & opcode[5] & opcode[4];
  assign  Iformat = ~opcode[6] & ~opcode[5] & opcode[4];
  assign  LW      = ~opcode[6] & ~opcode[5] & ~opcode[4];
  assign  SW      = ~opcode[6] & opcode[5] & ~opcode[4];
  assign  JAL     =  opcode[6] & opcode[3] & opcode[2];
  assign  JALR    =  opcode[6] & ~opcode[3] & opcode[2];
  assign  BEQ     =  opcode[6] & ~opcode[2];
  assign  branch = BEQ;
  assign  memwrite = SW;
  assign  memread = LW;
  assign  regwrite = Rformat | Iformat | LW |JAL | JALR;
  assign  memtoreg[1] = JAL | JALR;
  assign  memtoreg[0] = LW;
  assign  pcsrc[1] = JALR;
  assign  pcsrc[0] = JAL;
  assign  alusrc = Iformat | LW | SW | JAL | JALR;
  assign  aluop[2] = (Rformat & (~func3[2]&func3[1] | func7[5])) | (Iformat & (~func3[2]&func3[1] ));
  assign  aluop[1] = (Rformat & (func3[2]&~func3[1] | ~func3[2]&~func3[1]&~func3[0] | ~func3[2]&func3[1])) | (Iformat & (func3[2]&~func3[1] | ~func3[2]&~func3[1]&~func3[0] | ~func3[2]&func3[1])) | LW | SW | JALR;
  assign  aluop[0] = (Rformat & (func3[2]&func3[1]&func3[0]  | ~func3[2]&~func3[1]&~func3[0])) | (Iformat & (func3[2]&func3[1]&func3[0] | ~func3[2]&~func3[1]&~func3[0])) | LW | SW | JALR;             

endmodule
