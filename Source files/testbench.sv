// Code your testbench here
// or browse Examples
module fir_filter_tb;

  // Parameters
  parameter WIDTH = 16;
  parameter N = 4;  // No:of taps

  reg clk;
  reg rst_n;
  reg [WIDTH-1:0] Xn;
  wire [WIDTH-1:0] Yn;

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk; // 10ns clock period

  FIR_FILTER #(.N(N), .WIDTH(WIDTH)) dut (
    .clk(clk),
    .rst_n(rst_n),
    .Xn(Xn),
    .Yn(Yn)
  );

  // Testbench process
  initial begin
    // Initialize signals
    rst_n = 0;
    Xn = 0;

    // Apply reset
    #20 rst_n = 1;  // Deassert reset after 20ns

    
    #10 Xn = 16'sd100;   // Input sample 1
    #10 Xn = 16'sd200;   // Input sample 2
    #10 Xn = -16'sd50;   // Input sample 3
    #10 Xn = 16'sd25;    // Input sample 4
    #10 Xn = 0;         // No input (rest of the inputs are zero)


    #50;

    // Finish simulation
    $finish;
  end

  // Monitor outputs
  initial begin
    $monitor( " x_in=%d, y_out=%d", Xn, Yn);
  end
  
     initial 
    begin 
      		  
      $dumpfile("dump.vcd");
       $dumpvars(1);
    end


endmodule

