`include "defines.v"

`ifdef PIC

module `VARIANT`PIC

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
input   wire                       enable,
input   wire                       cs,		      
input   wire                       wr,
input   wire                       rd,
input   wire   [ADDR_WIDTH-1:0]    waddr,
input   wire   [ADDR_WIDTH-1:0]    raddr,
input   wire   [7:0]               wdata,
output  reg    [7:0]               rdata,

output  reg                        nmi_out,
output  reg                        irq_out,

input   wire   [7:0]               int_in


		      
		      
);

reg [7:0] 			   irq_enable;
reg [7:0] 			   nmi_enable;
reg [7:0] 			   irq_act;
reg [7:0] 			   nmi_act;
   
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
   irq_enable  <= IRQ_MODE;
   nmi_enable  <= NMI_MODE;
   irq_act     <= 8'h00;
   nmi_act     <= 8'h00;
   irq_out     <= 1'b0;
   nmi_out     <= 1'b0;
   end
else 
if(wr && was && cs && waddr[3:0] == IRQ_ENABLE) 
   begin
   irq_enable  <= wdata;
   end
else 
if(wr && was && cs && waddr[3:0] == NMI_ENABLE) 
   begin
   nmi_enable   <= wdata;
   end
else 
   begin
   irq_act     <=  irq_enable & int_in;
   nmi_act     <=  nmi_enable & int_in;
   irq_out     <=  | irq_act;
   nmi_out     <=  | nmi_act;
   end
  



endmodule

`endif //  `ifdef PIC
