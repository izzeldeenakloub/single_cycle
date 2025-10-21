module top_level(
	input clk , rst
	
);
//module program_counter(
//	input clk , rst
//	input [31:0] in
//	output reg [31:0] out
//
//);
wire [9:0] pc;
wire [31:0] instruction;
wire [31:0] next_PC , PC_plus_4;
wire write_enable;
wire [31:0]  reg_1 , reg_2;
wire alusrc, memread, memwrite, branch, Iformat, LW, SW, BEQ, JAL, JALR;
wire [2:0] aluop;
wire [1:0] memtoreg, pcsrc;
wire equal;
wire [31:0] SEout;
wire [31:0]op2;
wire [31:0] alu_result;
wire [31:0] branch_address;
wire [31:0] mux_out_1;
wire [31:0] read_data;
wire[31:0] F_result;
program_counter pc1(.clk(clk) , .rst(rst),
	.in(next_PC), .out(pc)
);
Adder addr2(.A({22'b0, pc}), .B(32'h00000001), .out(PC_plus_4));
//module instruction_memory (
//	address,
//	clock,
//	q);
instruction_memory IM(
	.address(pc),
	.clock(clk),
	.q(instruction)
);
//module Register_file(
//    input  wire         clk,
//    input  wire         reset,       // synchronous reset: clears all registers to 0
//    input  wire         wen,         // write enable
//    input  wire [4:0]   waddr,       // write address
//    input  wire [31:0]  wdata,       // write data
//    input  wire [4:0]   raddr1,      // read address port 1
//    output wire [31:0]  rdata1,      // read data port 1
//    input  wire [4:0]   raddr2,      // read address port 2
//    output wire [31:0]  rdata2       // read data port 2
//);


Register_file RF(
	.clk(clk) , .reset(rst),
	.wen(write_enable) , .waddr(instruction[11:7]),
	.wdata(F_result) , .raddr1(instruction[25:19]),
	.rdata1(reg_1) , .raddr2(instruction[24:20]) ,
	.rdata2(reg_2)
);

Control_Unit CU(.aluop(aluop	), .alusrc(alusrc), .pcsrc(pcsrc), .memtoreg(memtoreg), .regwrite(write_enable) ,
.memread(memread), .memwrite(memwrite), .branch(branch), .Iformat(Iformat),
.LW(LW),.SW(SW), .BEQ(BEQ), .JAL(JAL), .JALR(JALR), 
.opcode(instruction[6:0]), .func3(instruction[14:12]), .func7(instruction[31:25])
);

SignExtend SE(
.SEout(SEout), .in(instruction),  .Iformat(Iformat), .LW(LW), .SW(SW), .BEQ(BEQ), .JAL(JAL), .JALR(JALR)
);

Comparator C1(.equal(equal), .a(reg_1), .b(reg_2));

Mux_2_to_1 M1(.out(op2), .s(alusrc), .i1(SEout), .i0(reg_2)); 

//module ALU (
//    input  [31:0] op1,
//    input  [31:0] op2,
//    input  [2:0]  aluop,
//    output reg [31:0] result
//);

ALU alu(
	.op1(reg_1),
	.op2(op2),
	.aluop(aluop),
	.result(alu_result)
);

Adder adder1(.A(pc) , .B(SEout) , .out(branch_address));
Mux_2_to_1 M2(.out(mux_out_1), .s(equal & branch), .i1(branch_address), .i0(PC_plus_4)); 

Mux_3_to_1 M3(.out(next_PC), .s(pcsrc), .i2(alu_result), .i1(branch_address), .i0(mux_out_1)); 
memory mem(
	.address(alu_result[11:0]),
	.clock(clk),
	.data(reg_2),
	.rden(memread),
	.wren(memwrite),
	.q(read_data));
Mux_3_to_1 M4(.out(F_result), .s(memtoreg), .i2(PC_plus_4), .i1(read_data), .i0(alu_result)); 
endmodule
