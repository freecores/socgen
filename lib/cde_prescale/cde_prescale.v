
module 
cde_prescale
  
#(parameter   PRESCALE=5'b01100,
  parameter   PRE_SIZE=5      )  
(
input  wire              clk,
input  wire              reset,
output  reg              prescale_out
                         );

reg  [PRE_SIZE-1:0]    prescale_cnt;

always@(posedge clk)
  if(reset)            prescale_out  <= 1'b1;
  else                 prescale_out  <= !(|prescale_cnt);       



always@(posedge clk)
  if(reset)              prescale_cnt  <= {PRE_SIZE{1'b0}};
  else
  if(!(|prescale_cnt))   prescale_cnt  <= PRESCALE;
  else                   prescale_cnt  <= prescale_cnt - 'b1;





   
endmodule



