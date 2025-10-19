module ALU (
    input  [31:0] op1,
    input  [31:0] op2,
    input  [2:0]  aluop,
    output reg [31:0] result
);

    always @(*) begin
        case (aluop)
            3'b000: result = op1 | op2;              // OR
            3'b001: result = op1 & op2;              // AND
            3'b010: result = op1 ^ op2;              // XOR
            3'b011: result = op1 + op2;              // ADD
            3'b100: result = ~(op1 | op2);           // NOR
            3'b101: result = ~(op1 & op2);           // NAND
            3'b110: result = (op1 < op2) ? 32'd1 : 32'd0; // SLT (Set Less Than)
            3'b111: result = op1 - op2;              // SUBTRACT
            default: result = 32'b0;                 // default case
        endcase
    end

endmodule
