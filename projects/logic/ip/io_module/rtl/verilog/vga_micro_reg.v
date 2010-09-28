`include "defines.v"

`ifdef VGA

module `VARIANT`VGA_MICRO_REG
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
input   wire  [15:0]    vga_address,

output   reg   [7:0] 	rdata,
  
output   reg   [7:0] 	lat_wdata,
output   reg   [7:0] 	cntrl,
output   reg   [7:0] 	char_color,
output   reg   [7:0] 	back_color,
output   reg   [7:0] 	cursor_color,
output   reg            ascii_load,
output   reg            add_l_load,  
output   reg            add_h_load 

);



   

parameter ASCII_DATA     = 4'h0;
parameter ADD_L          = 4'h2;
parameter ADD_H          = 4'h4;
parameter CNTRL          = 4'h6;
parameter CHAR_COLOR     = 4'h8;
parameter BACK_COLOR     = 4'ha;
parameter CURSOR_COLOR   = 4'hc;
   
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
    CNTRL:        rdata  = cntrl;
    ADD_L:        rdata  = vga_address[7:0];
    ADD_H:        rdata  = vga_address[15:8];
    CHAR_COLOR:   rdata  = char_color;
    BACK_COLOR:   rdata  = back_color;
    CURSOR_COLOR: rdata  = cursor_color;
    default:      rdata  = 8'h00;
    endcase
    end
  else            rdata  = 8'hFF;
   

always@(posedge clk)
if (reset) 
   begin
   cntrl  <= 8'h00;
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
   char_color  <= 8'h1c;
   end
else 
if(wr && was && cs && waddr[3:0] == CHAR_COLOR) 
   begin
   char_color  <= wdata;
   end
else 
   begin
   char_color  <= char_color;
   end

always@(posedge clk)
if (reset) 
   begin
   back_color  <= 8'h01;
   end
else 
if(wr && was && cs && waddr[3:0] == BACK_COLOR) 
   begin
   back_color  <= wdata;
   end
else 
   begin
   back_color  <= back_color;
   end

   
always@(posedge clk)
if (reset) 
   begin
   cursor_color  <= 8'he0;
   end
else 
if(wr && was && cs && waddr[3:0] == CURSOR_COLOR) 
   begin
   cursor_color  <= wdata;
   end
else 
   begin
   cursor_color  <= cursor_color;
   end





   
always@(posedge clk)
if (reset) 
  begin
    ascii_load         <= 1'b0;
    add_l_load         <= 1'b0;
    add_h_load         <= 1'b0;
   end
else 
  begin
   ascii_load            <= (enable && wr && was && cs && (waddr[3:0] == ASCII_DATA));
   add_l_load            <= (enable && wr && was && cs && (waddr[3:0] == ADD_L));
   add_h_load            <= (enable && wr && was && cs && (waddr[3:0] == ADD_H));
  end

   
endmodule


`endif //  `ifdef VGA



