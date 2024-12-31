module FIR_FILTER #(parameter N = 4, WIDTH = 16)(
  
  input logic clk,
  input logic rst_n,
  input logic [WIDTH-1:0] Xn,
  output logic [WIDTH-1:0] Yn);
  
  parameter [WIDTH-1:0] CO_EFF[0:N-1] = {16'sd1, 16'sd2, 16'sd3, 16'sd4};   //Co-efficients of the FIR Filter (given as operands to each of the multipliers. These can be customized)
  
  logic [WIDTH-1:0] SHIFT_REG[ N-1:0];
  logic [WIDTH+N-1:0] ACCUMULATOR;
  
 //Shift Register Logic 
  
  always_ff @(posedge clk or negedge rst_n)
    begin
      if(!rst_n)
        begin
          for(int i =0; i< N; i++)
            SHIFT_REG[i] <= '0;
        end
      
      else begin
        for(int i=N-1; i>0; i--)
          begin
            SHIFT_REG[i] <= SHIFT_REG[i-1];
          end
        SHIFT_REG[0] <= Xn;
        
      end    
    end

  //FIR Filter computational logic
  
  always_comb
    begin
      ACCUMULATOR =0;
      
      for(int i =0; i< N; i++)
        begin
          ACCUMULATOR = ACCUMULATOR + (SHIFT_REG[i] * CO_EFF[i]);
        end
                                        
    end
                                        
    assign Yn = ACCUMULATOR[WIDTH-1:0];     //Accumulator truncated and assigned to the output port.
                                        
endmodule
