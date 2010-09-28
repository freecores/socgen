`include "defines.v"

`ifdef UART

module `VARIANT`UART_MICRO_REG
#(parameter BASE_ADDR     = 4'h0,
  parameter BASE_WIDTH    = 4,
  parameter ADDR_WIDTH    = 8
)

( 
input   wire            clk,
input   wire            reset,
input   wire            enable,		      
input   wire            cs,		      
input   wire            wr,
input   wire            rd,
input   wire   [7:0]    waddr,
input   wire   [7:0]    raddr,
input   wire   [7:0]    wdata,
output   reg   [7:0]    rdata,
output   reg   [7:0] 	lat_wdata,
input   wire   [7:0] 	rcv_data,
input   wire   [7:0] 	status,

output   reg   [7:0] 	cntrl,
output   reg            txd_load,
output   reg            load,  
output   reg            rxd_data_avail_stb 

);



   

parameter XMIT_DATA     = 4'h0;
parameter RCV_DATA      = 4'h2;
parameter CNTRL         = 4'h4;
parameter STATUS        = 4'h6;
   
reg 	              was;
reg 	              ras;
   
always@(posedge clk)
if (reset)     lat_wdata  <= 8'h00;   
else           lat_wdata  <= wdata;   

 
always@(*)     was = (waddr[ADDR_WIDTH-1:ADDR_WIDTH-BASE_WIDTH] == BASE_ADDR);
always@(*)     ras = (raddr[ADDR_WIDTH-1:ADDR_WIDTH-BASE_WIDTH] == BASE_ADDR);

   
always@(*)
  if(rd && cs && ras)
    begin
    case(raddr[3:0])
    RCV_DATA:     rdata  = rcv_data;
    CNTRL:        rdata  = cntrl;
    STATUS:       rdata  = {status[7:0]};
    default:      rdata  = 8'h00;
    endcase
    end
  else            rdata  = 8'hFF;
   

always@(posedge clk)
if (reset) 
   begin
   cntrl <= 8'h00;
   end
else 
if(wr && was && cs && waddr[3:0] == CNTRL) 
   begin
   cntrl  <= wdata;
   end
else 
   begin
   cntrl  <= cntrl;
   end


always@(posedge clk)
if (reset) 
  begin
    load               <= 1'b0;
    txd_load           <= 1'b0;
    rxd_data_avail_stb <= 1'b0;
   end
else 
  begin
   load                <=   txd_load;  
   txd_load            <= (enable && wr && was && cs && (waddr[3:0] == XMIT_DATA));
   rxd_data_avail_stb  <= (enable && rd && was && cs && (waddr[3:0] == RCV_DATA ));
  end

   
endmodule


`endif //  `ifdef UART



