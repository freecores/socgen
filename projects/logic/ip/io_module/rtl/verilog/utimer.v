`include "defines.v"

`ifdef UTIMER



module `VARIANT`UTIMER
#(parameter BASE_ADDR     = 4'h0,
  parameter BASE_WIDTH    = 4,
  parameter ADDR_WIDTH    = 8,
  parameter FREQ          = 25
  
 )(
		       
input   wire                        clk,
input   wire                        reset,
input   wire                        enable,
input   wire                        cs,
input   wire                        wr,		       
input   wire                        rd,
input   wire   [ADDR_WIDTH-1:0]     waddr,
input   wire   [ADDR_WIDTH-1:0]     raddr,
   
input   wire   [7:0]                wdata,
output  reg    [7:0]                rdata
);

parameter TIMER_LATCH  = 4'h0;
parameter TIMER_COUNT  = 4'h2;

reg 		         ras;
reg 		         was;
   
reg [7:0]              count;
reg [7:0]              latch;

reg [5:0]              u_sec;



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


   

always@( posedge clk)
if(reset)                                                                  u_sec <= FREQ-1;
else
if((u_sec == 0) ||   (wr && was && cs && waddr[3:0] == TIMER_COUNT) )      u_sec <= FREQ-1;
else                                                                       u_sec <= u_sec-1;


    

always@(posedge clk)
if (reset)                                            latch <= 8'h00;
else 
if(wr && was && cs && waddr[3:0] == TIMER_LATCH)      latch <= wdata;
else                                                  latch <= latch;



always@(posedge clk)
if (reset)                                            count <= 8'h00;
else 
if(wr && was && cs && waddr[3:0] == TIMER_COUNT)      count <= wdata;
else
if(u_sec == 0)
  begin
  if(count == 8'h00)                                  count <= 8'h00;
  else
  if(count == 8'h01)                                  count <= latch;
  else                                                count <= count-1;
  end
else                                                  count <= count;














endmodule

`endif //  `ifdef UTIMER
