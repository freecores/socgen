`include "defines.v"

`ifdef PIC

module `VARIANT`PIC_MICRO_REG

#(
  parameter BASE_ADDR     = 4'h0,
  parameter BASE_WIDTH    = 4,
  parameter ADDR_WIDTH    = 8,
  parameter IRQ_MODE      = 8'h00,
  parameter NMI_MODE      = 8'h00
)

( 

input   wire                       clk,
input   wire                       reset,

input   wire                       cs,		      
input   wire                       wr,
input   wire                       rd,
input   wire   [ADDR_WIDTH-1:0]    waddr,
input   wire   [ADDR_WIDTH-1:0]    raddr,
input   wire   [7:0]               wdata,
output  reg    [7:0]               rdata,


output  reg    [7:0] 	           irq_enable,
output  reg    [7:0] 	           nmi_enable,
output  reg    [7:0] 	           irq_act,
output  reg    [7:0] 	           nmi_act,
  
input   wire   [7:0]               int_in,
input   wire   [7:0]               next_irq_enable,  
input   wire   [7:0]               next_nmi_enable,
input   wire   [7:0]               irq_act_in,
input   wire   [7:0]               nmi_act_in

		      
		      
);


   
parameter INT_IN         = 4'h0;
parameter IRQ_ENABLE     = 4'h2;
parameter NMI_ENABLE     = 4'h4;
parameter IRQ_ACT        = 4'h6;
parameter NMI_ACT        = 4'h8;


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
    NMI_ENABLE:      rdata  = nmi_enable;
    IRQ_ACT:         rdata  = irq_act;
    NMI_ACT:         rdata  = nmi_act;
    default:         rdata  = 8'h00;
    endcase
    end
  else               rdata  = 8'hFF;
   

   
always@(posedge clk)
if (reset) 
   begin
   irq_enable     <= IRQ_MODE;
   end
else 
if(wr && was && cs && waddr[3:0] == IRQ_ENABLE) 
   begin
   irq_enable     <= wdata;
   end
else 
   begin
   irq_enable     <=  next_irq_enable;
   end


always@(posedge clk)
if (reset) 
   begin
   nmi_enable     <= NMI_MODE;
   end
else 
if(wr && was && cs && waddr[3:0] == NMI_ENABLE) 
   begin
   nmi_enable     <= wdata;
   end
else 
   begin
   nmi_enable     <=  next_nmi_enable;
   end
   


   
always@(posedge clk)
if (reset) 
   begin
   irq_act        <= 8'h00;
   end
else 
if(rd && ras && cs && raddr[3:0] == IRQ_ACT) 
   begin
   irq_act        <= irq_act;
   end
else 
   begin
   irq_act        <=  irq_act_in;
   end


always@(posedge clk)
if (reset) 
   begin
   nmi_act        <= 8'h00;
   end
else 
if(rd && ras && cs && raddr[3:0] == NMI_ACT) 
   begin
   nmi_act        <= nmi_act;
   end
else 
   begin
   nmi_act        <=  nmi_act_in;
   end
   
   
  



endmodule

`endif //  `ifdef PIC
