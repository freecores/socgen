`include "defines.v"

`ifdef MEM

module `VARIANT`MEM

#(
  parameter BASE_ADDR     = 4'h0,
  parameter BASE_WIDTH    = 4,
  parameter ADDR_WIDTH    = 16,
  parameter MEM_WIDTH     = 23,
  parameter MEM_FRAME     = 10
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

output  reg    [7:0]               wait_st,
output  reg    [7:0]               bank,

input   wire                       cs_mem,
input   wire   [15:0]              mem_add,  
  
output reg    [23:1]               ext_add,
output reg    [15:0]               ext_wdata,
input  wire   [15:0]               ext_rdata,
output reg                         ext_ub,
output reg                         ext_lb,
output reg                         ext_rd,
output reg                         ext_wr,
output reg     [1:0]               ext_cs




		      
);
   
parameter WAIT_ST        = 4'h0;
parameter BANK           = 4'h2;

reg 	              was;
reg 	              ras;

always@(*)            was = (waddr[ADDR_WIDTH-1:ADDR_WIDTH-BASE_WIDTH] == BASE_ADDR);
always@(*)            ras = (raddr[ADDR_WIDTH-1:ADDR_WIDTH-BASE_WIDTH] == BASE_ADDR);
      
always@(*)
  if(rd && cs && ras)
    begin
    case(raddr[3:0])
    WAIT_ST:           rdata  = wait_st;
    BANK:              rdata  = bank;
    default:           rdata  = 8'h00;
    endcase
    end
  else                 rdata  = 8'hFF;
   

   
always@(posedge clk)
if (reset) 
   begin
   wait_st       <= 8'h04;
   bank          <= 8'h00;
   end
else 
if(wr && was && cs && waddr[3:0] == WAIT_ST) 
   begin
   wait_st       <= wdata;
   end
else 
if(wr && was && cs && waddr[3:0] == BANK) 
   begin
   bank          <= wdata;
   end
else 
   begin
   wait_st       <=  wait_st;
   bank          <=  bank;
   end
  







always@(posedge clk)
	  if(reset)
                      begin
                      ext_add   <=  'b0;
                      ext_wdata <= 16'b0000000000000;
                      ext_rd    <= 1'b0;
                      ext_wr    <= 1'b0;
                      ext_cs    <= 2'b00;
                      ext_ub    <= 1'b0;
                      ext_lb    <= 1'b0;
                      end
          else
                      begin
                      ext_add   <= {10'b0000000000, mem_add[13:1]};
                      ext_wdata <= {wdata,wdata};
                      ext_rd    <= cs_mem && rd;
                      ext_wr    <= cs_mem && wr;
                      ext_cs    <= {1'b0,cs_mem};
                      ext_ub    <= cs_mem && mem_add[0];
                      ext_lb    <= cs_mem && !mem_add[0];
                      end





   

endmodule

`endif 
