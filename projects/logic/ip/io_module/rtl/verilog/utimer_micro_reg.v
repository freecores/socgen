`include "defines.v"

`ifdef UTIMER



module `VARIANT`UTIMER_MICRO_REG
#(parameter BASE_ADDR     = 4'h0,
  parameter BASE_WIDTH    = 4,
  parameter ADDR_WIDTH    = 8
  
 )(
		       
input   wire                        clk,
input   wire                        reset,

input   wire                        cs,
input   wire                        wr,		       
input   wire                        rd,
input   wire   [ADDR_WIDTH-1:0]     waddr,
input   wire   [ADDR_WIDTH-1:0]     raddr,
   
input   wire   [7:0]                wdata,
output   reg   [7:0]                rdata,

output   reg   [7:0]                count,
output   reg   [7:0]                latch,

input   wire   [7:0]                next_count,
input   wire   [7:0]                next_latch   

);

parameter TIMER_LATCH  = 4'h0;
parameter TIMER_COUNT  = 4'h2;

reg 		         ras;
reg 		         was;
   





always@(waddr)     was = (waddr[ADDR_WIDTH-1:ADDR_WIDTH-BASE_WIDTH] == BASE_ADDR);
always@(raddr)     ras = (raddr[ADDR_WIDTH-1:ADDR_WIDTH-BASE_WIDTH] == BASE_ADDR);
   


   
always@(*)
  if(rd && cs && ras)
    begin
    case(raddr[3:0])
    TIMER_LATCH:     rdata  =  latch[7:0];
    TIMER_COUNT:     rdata  =  count[7:0];
    default:         rdata  =  8'h00;
    endcase
    end
  else               rdata  =  8'hFF;


   


always@(posedge clk)
if (reset)                                            latch <= 8'h00;
else 
if(wr && was && cs && waddr[3:0] == TIMER_LATCH)      latch <= wdata;
else                                                  latch <= next_latch;



always@(posedge clk)
if (reset)                                            count <= 8'h00;
else 
if(wr && was && cs && waddr[3:0] == TIMER_COUNT)      count <= wdata;
else                                                  count <= next_count;




endmodule

`endif //  `ifdef UTIMER
