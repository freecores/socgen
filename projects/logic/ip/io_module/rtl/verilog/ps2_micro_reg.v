`include "defines.v"

`ifdef PS2

module `VARIANT`PS2_MICRO_REG
#(parameter BASE_ADDR     = 4'h0,
  parameter BASE_WIDTH    = 4,
  parameter ADDR_WIDTH    = 8
)

( 
input   wire            clk,
input   wire            reset,
input   wire            cs,		      
input   wire            wr,
input   wire            rd,
input   wire   [7:0]    waddr,
input   wire   [7:0]    raddr,
input   wire   [7:0]    wdata,
output   reg   [7:0]    rdata,
input   wire   [7:0] 	rcv_data,
input   wire   [7:0] 	status,
input   wire   [7:0] 	x_pos,
input   wire   [7:0] 	y_pos,

output   reg   [7:0] 	cntrl,
output   reg   [7:0] 	wdata_buf, 
output   reg            ps2_data_read_stb 

);


parameter PS2_DATA      = 4'h0;
parameter STATUS        = 4'h2;
parameter CNTRL         = 4'h4;
parameter X_POS         = 4'h6;   
parameter Y_POS         = 4'h8;

   
reg 	              was;
reg 	              ras;
   
 
always@(*)     was = (waddr[ADDR_WIDTH-1:ADDR_WIDTH-BASE_WIDTH] == BASE_ADDR);
always@(*)     ras = (raddr[ADDR_WIDTH-1:ADDR_WIDTH-BASE_WIDTH] == BASE_ADDR);

always@(*)
  if(rd && cs && ras)
    begin
    case(raddr[3:0])
    PS2_DATA:     rdata  = rcv_data;
    STATUS:       rdata  = status;
    CNTRL:        rdata  = cntrl;
    X_POS:        rdata  = x_pos[7:0];  
    Y_POS:        rdata  = y_pos[7:0];  
    default:      rdata  = 8'h00;
    endcase
    end
  else            rdata  = 8'hFF;
   

always@(posedge clk)
if (reset) 
   begin
   wdata_buf <= 8'h00;
   end
else 
if(wr && was && cs && waddr[3:0] == PS2_DATA) 
   begin
   wdata_buf  <= wdata;
   end
else 
   begin
   wdata_buf  <= wdata_buf;
   end


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
    ps2_data_read_stb <= 1'b0;
   end
else 
  begin
   ps2_data_read_stb  <= ( rd && ras && cs && (raddr[3:0] == PS2_DATA ));
  end

   
endmodule


`endif //  `ifdef PS2



