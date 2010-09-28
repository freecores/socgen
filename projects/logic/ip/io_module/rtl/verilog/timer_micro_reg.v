`include "defines.v"

`ifdef TIMER


module `VARIANT`TIMER_MICRO_REG
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
output  reg    [7:0]                rdata,

input   wire   [7:0]                count_0,
input   wire   [7:0]                start_0,

input   wire   [7:0]                count_1,
input   wire   [7:0]                start_1   


);
   
parameter TIMER_0_START  = 4'h0;
parameter TIMER_0_COUNT  = 4'h2;
parameter TIMER_0_END    = 4'h4;

parameter TIMER_1_START  = 4'h8;
parameter TIMER_1_COUNT  = 4'hA;
parameter TIMER_1_END    = 4'hC;
   
   
reg 		        was;
reg 		        ras;


always@(*)     was = (waddr[ADDR_WIDTH-1:ADDR_WIDTH-BASE_WIDTH] == BASE_ADDR);
always@(*)     ras = (raddr[ADDR_WIDTH-1:ADDR_WIDTH-BASE_WIDTH] == BASE_ADDR);

   



always@(*)
  if(rd && cs && ras)
    begin
    case(raddr[3:0])
    TIMER_0_START:     rdata  =  start_0;
    TIMER_0_COUNT:     rdata  =  count_0;
    TIMER_1_START:     rdata  =  start_1;
    TIMER_1_COUNT:     rdata  =  count_1;
    default:           rdata  = 8'h00;
    endcase
    end
  else
    begin
                       rdata  = 8'hFF;
    end   
   
   





endmodule

`endif //  `ifdef TIMER
