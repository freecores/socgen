`include "defines.v"

`ifdef VIC

module `VARIANT`VIC

#(
  parameter BASE_ADDR     = 4'h0,
  parameter BASE_WIDTH    = 4,
  parameter ADDR_WIDTH    = 8,
  parameter IRQ_MODE      = 8'h00,
  parameter VEC_00        = 8'he0,
  parameter VEC_01        = 8'he2,
  parameter VEC_02        = 8'he4,
  parameter VEC_03        = 8'he6,
  parameter VEC_04        = 8'he8,  
  parameter VEC_05        = 8'hea,
  parameter VEC_06        = 8'hec,
  parameter VEC_07        = 8'hee,
  parameter VEC_NONE      = 8'h00  
  
)

( 

input   wire                       clk,
input   wire                       reset,
input   wire                       enable,
input   wire                       cs,		      
input   wire                       wr,
input   wire                       rd,
input   wire   [ADDR_WIDTH-1:0]    waddr,
input   wire   [ADDR_WIDTH-1:0]    raddr,
input   wire   [7:0]               wdata,
output  reg    [7:0]               rdata,

output  reg                        irq_out,
output  reg    [7:0]               vector,
input   wire   [7:0]               int_in


		      
		      
);

reg [7:0] 			   irq_enable;
reg [7:0] 			   irq_act;
   
parameter INT_IN         = 4'h0;
parameter IRQ_ENABLE     = 4'h2;
parameter IRQ_ACT        = 4'h6;
parameter IRQ_VEC        = 4'h8;

reg 	              was;
reg 	              ras;

   
always@(*)            was = (waddr[ADDR_WIDTH-1:ADDR_WIDTH-BASE_WIDTH] == BASE_ADDR);
always@(*)            ras = (raddr[ADDR_WIDTH-1:ADDR_WIDTH-BASE_WIDTH] == BASE_ADDR);
   
   
always@(*)
  if(rd && cs && ras)
    begin
    case(raddr[3:0])
    INT_IN:          rdata  = int_in;
    IRQ_ENABLE:      rdata  = irq_enable;
    IRQ_ACT:         rdata  = irq_act;
    IRQ_VEC:         rdata  = vector;
    default:         rdata  = 8'h00;
    endcase
    end
  else               rdata  = 8'hFF;
   

   
always@(posedge clk)
if (reset) 
   begin
   irq_enable  <= IRQ_MODE;
   end
else 
if(wr && was && cs && waddr[3:0] == IRQ_ENABLE) 
   begin
   irq_enable  <= wdata;
   end
else 
  begin
   irq_enable  <=  irq_enable; 
   end


always@(posedge clk)
if (reset) 
   begin
   irq_act     <= 8'h00;
   irq_out     <= 1'b0;
   end
else 
  begin
   irq_act     <=  irq_enable & int_in;
   irq_out     <=  | irq_act;
   end
  


always@(posedge clk)
if (reset) 
                   vector  <= VEC_NONE;
  
else 
if(irq_act[0])     vector  <= VEC_00;
else 
if(irq_act[1])     vector  <= VEC_01;
else 
if(irq_act[2])     vector  <= VEC_02;
else 
if(irq_act[3])     vector  <= VEC_03;
else 
if(irq_act[4])     vector  <= VEC_04;
else 
if(irq_act[5])     vector  <= VEC_05;
else 
if(irq_act[6])     vector  <= VEC_06;
else 
if(irq_act[7])     vector  <= VEC_07;
else 
                   vector  <= VEC_NONE; 
   


   


endmodule

`endif 
