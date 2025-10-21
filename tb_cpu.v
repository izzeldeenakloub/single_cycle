`timescale 1ns / 1ps
module tb_cpu; 
  reg clk, reset, enable; 
  top_level p(clk, reset);

  integer i; // cycle counter

  // Initialization block
  initial begin 
    reset = 1;
    clk = 1;
    #80 reset = 0;
  end

  // Clock generation (period = 100ns → 10 MHz)
  always #50 clk = ~clk;

  // Stop after 100 cycles
  initial begin
    for (i = 0; i < 100; i = i + 1) begin
      @(posedge clk); // wait for clock edge
    end
    $stop; // stops the simulation (use $finish if you prefer closing it)
  end

endmodule