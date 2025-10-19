// 32x32 Register File
// Two read ports (combinational), one write port (synchronous).
// Register 0 is always zero (writes to addr 0 ignored).

module Register_file(
    input  wire         clk,
    input  wire         reset,       // synchronous reset: clears all registers to 0
    input  wire         wen,         // write enable
    input  wire [4:0]   waddr,       // write address
    input  wire [31:0]  wdata,       // write data
    input  wire [4:0]   raddr1,      // read address port 1
    output wire [31:0]  rdata1,      // read data port 1
    input  wire [4:0]   raddr2,      // read address port 2
    output wire [31:0]  rdata2       // read data port 2
);

    // internal register array. regs[0] will remain 0.
    reg [31:0] regs [31:0];
    integer i;

    // synchronous reset and write
    always @(posedge clk) begin
        if (reset) begin
            // clear all registers
            for (i = 0; i < 32; i = i + 1)
                regs[i] <= 32'b0;
        end else begin
            // write on rising edge when enabled; ignore writes to register 0
            if (wen && (waddr != 5'd0)) begin
                regs[waddr] <= wdata;
            end
            // ensure regs[0] stays zero (in case reset is not asserted)
            regs[0] <= 32'b0;
        end
    end

    // asynchronous (combinational) read ports
    // If you want register forwarding for the case when reading the same
    // register that is being written in the same cycle (write-through),
    // you can add logic to forward wdata when (wen && (waddr == raddrX)).
    assign rdata1 = (raddr1 == 5'd0) ? 32'b0 :
                    (wen && (waddr == raddr1) ? wdata : regs[raddr1]);

    assign rdata2 = (raddr2 == 5'd0) ? 32'b0 :
                    (wen && (waddr == raddr2) ? wdata : regs[raddr2]);

endmodule
