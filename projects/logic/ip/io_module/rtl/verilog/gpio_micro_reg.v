`include "defines.v"


`ifdef GPIO

module `VARIANT`GPIO_MICRO_REG

#(
  parameter BASE_ADDR     = 4'h0,
  parameter BASE_WIDTH    = 4,
  parameter ADDR_WIDTH    = 8
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

output   reg   [7:0]               gpio_0_out,
input   wire   [7:0]               next_gpio_0_out,

output   reg   [7:0]               gpio_0_oe,
input   wire   [7:0]               next_gpio_0_oe,  

output   reg   [7:0]               gpio_0_lat,
input   wire   [7:0]               gpio_0_in,

output   reg   [7:0]               gpio_1_out,
input   wire   [7:0]               next_gpio_1_out,  

output   reg   [7:0]               gpio_1_oe,
input   wire   [7:0]               next_gpio_1_oe,  

output   reg   [7:0]               gpio_1_lat,
input   wire   [7:0]               gpio_1_in

		      
		      
);


   
parameter GPIO_0_IN      = 4'h0;
parameter GPIO_0_OE      = 4'h1;
parameter GPIO_0_OUT     = 4'h2;

parameter GPIO_1_IN      = 4'h4;
parameter GPIO_1_OE      = 4'h5;
parameter GPIO_1_OUT     = 4'h6;
   

   


   
reg 	              ras;
reg 	              was;   
   
always@(*)     ras = (raddr[ADDR_WIDTH-1:ADDR_WIDTH-BASE_WIDTH] == BASE_ADDR);
always@(*)     was = (waddr[ADDR_WIDTH-1:ADDR_WIDTH-BASE_WIDTH] == BASE_ADDR);


   
always@(*)
  if(rd && cs && ras)
    begin
    case(raddr[3:0])
    GPIO_0_OUT:     rdata  = gpio_0_out;
    GPIO_0_OE:      rdata  = gpio_0_oe;
    GPIO_0_IN:      rdata  = gpio_0_lat;
    GPIO_1_OUT:     rdata  = gpio_1_out;
    GPIO_1_OE:      rdata  = gpio_1_oe;
    GPIO_1_IN:      rdata  = gpio_1_lat;     
    default:        rdata  = 8'h00;
    endcase
    end
  else            rdata  = 8'hFF;
   

always@(posedge clk)
if (reset) 
   begin
   gpio_0_out  <= 8'h00;
   end
else 
if(enable &&wr && was && cs && (waddr[3:0] == GPIO_0_OUT)) 
   begin
   gpio_0_out  <= wdata;
   end
else
   begin
   gpio_0_out  <=  next_gpio_0_out;
   end



always@(posedge clk)
if (reset) 
   begin
   gpio_0_oe   <= 8'h00;
   end
else 
if(enable && wr && was && cs && (waddr[3:0] == GPIO_0_OE)) 
   begin
   gpio_0_oe   <= wdata;
   end
else 
   begin
   gpio_0_oe   <=  next_gpio_0_oe;
   end



always@(posedge clk)
if (reset) 
   begin
   gpio_1_out  <= 8'h00;
   end
else 
if(enable && wr && was && cs && (waddr[3:0] == GPIO_1_OUT)) 
   begin
   gpio_1_out  <= wdata;
   end
else 
   begin
   gpio_1_out  <=  next_gpio_1_out;
   end

  


always@(posedge clk)
if (reset) 
   begin
   gpio_1_oe   <= 8'h00;
   end
else
if(enable && wr && was && cs && (waddr[3:0] == GPIO_1_OE)) 
   begin
   gpio_1_oe   <= wdata;
   end 
else 
   begin
   gpio_1_oe   <=  next_gpio_1_oe;
   end

   


always@(posedge clk)
if (reset) 
   begin
   gpio_0_lat <= 8'h00;
   end
else
if(enable && rd && ras && cs && (raddr[3:0] == GPIO_0_IN)) 
   begin
      gpio_0_lat <= gpio_0_lat;
   end 
else 
   begin
   gpio_0_lat   <=  gpio_0_in;
   end


always@(posedge clk)
if (reset) 
   begin
   gpio_1_lat <= 8'h00;
   end
else
if(enable && rd && ras && cs && (raddr[3:0] == GPIO_1_IN)) 
   begin
      gpio_1_lat <= gpio_1_lat;
   end 
else 
   begin
   gpio_1_lat   <=  gpio_1_in;
   end

   
  



   


   



endmodule

`endif
