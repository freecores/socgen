`include "defines.v"


module `VARIANT
#(
  parameter BASE_WIDTH     = 8,
  parameter ADDR_WIDTH     = 16,
  parameter NMI_MODE       = 8'h00,
  parameter IRQ_MODE       = 8'h00,
  parameter TX_FIFO        = 0,
  parameter TX_FIFO_SIZE   = 3,
  parameter TX_FIFO_WORDS  = 8,
  parameter RX_FIFO        = 0,
  parameter RX_FIFO_SIZE   = 3,
  parameter RX_FIFO_WORDS  = 8,
  parameter STARTUP        = "NONE",  
  parameter FONT           = "NONE"  
)
( 

input   wire                                 clk,
input   wire                               reset,
input   wire                              enable,

input   wire                                  cs_i,
input   wire                                  cs_m,
			
input   wire                                  wr,

  
input   wire                                  rd,
input   wire  [ADDR_WIDTH-1:0]              addr,


input   wire  [ADDR_WIDTH-BASE_WIDTH-1:0]  waddr, 
input   wire    [7:0]                      wdata,
output  wire   [15:0]                      rdata

`ifdef GPIO
,  
output  wire   [7:0]                  gpio_0_out, 
output  wire   [7:0]                   gpio_0_oe,
output  wire   [7:0]                  gpio_0_lat,
input   wire   [7:0]                   gpio_0_in,

output  wire   [7:0]                  gpio_1_out,
output  wire   [7:0]                   gpio_1_oe,
output  wire   [7:0]                  gpio_1_lat,
input   wire   [7:0]                   gpio_1_in   

`endif //  `ifdef GPIO


`ifdef TIMER
  
,
output wire    [1:0]                   timer_irq

`endif
  

  

  
`ifdef PIC  

,  
output  wire                             pic_irq,
output  wire                             pic_nmi,
input   wire   [7:0]                  ext_irq_in

`endif
  
`ifdef UART
,  
output  wire                         txd_pad_out,
input   wire                          rxd_pad_in,
input   wire                          cts_pad_in,
output  wire                         rts_pad_out,  
output  wire                              rx_irq,
output  wire                              tx_irq 
`endif
  
`ifdef PS2  
,
output  wire                       ps2_clk_pad_oe,
input   wire                       ps2_clk_pad_in,
output  wire                      ps2_data_pad_oe,
input   wire                      ps2_data_pad_in,
output  wire                       ps2_data_avail,


output wire [9:0]                          y_pos,
output wire [9:0]                          x_pos,
output wire                           new_packet,
output wire                               ms_mid, 
output wire                             ms_right,  
output wire                              ms_left  


  
`endif



`ifdef VIC  

,  
output  wire                             int_out,
output  wire   [7:0]                     vector

`endif
  

,
input  wire                        cs_mem,
input wire    [15:0]               mem_add,  
output wire   [23:1]               ext_add,
output wire   [15:0]               ext_wdata,
input  wire   [15:0]               ext_rdata,
output wire                        ext_ub,
output wire                        ext_lb,
output wire                        ext_rd,
output wire                        ext_wr,
output wire    [1:0]               ext_cs


  


,
output wire [2:0]                 vgared_pad_out,
output wire [2:0]               vgagreen_pad_out,
output wire [1:0]                vgablue_pad_out,

output wire                      hsync_n_pad_out,
output wire                      vsync_n_pad_out


  
  
);









   
   
wire [7:0]              gpio_rdata;
wire [7:0]              timer_rdata;
wire [7:0]              uart_rdata;
wire [7:0]              pic_rdata;
wire [7:0]              ps2_rdata;
wire [7:0]              utim_rdata;
wire [7:0]              vga_rdata;
wire [7:0]              mem_rdata;
wire [7:0]              vic_rdata;

   
reg [7:0]              out_data;
   
assign  rdata      = (rd && cs_i)? {8'h00,out_data} : 16'hffff;

always@(posedge clk)   
 out_data        <=  gpio_rdata &  
                    timer_rdata & 
                     uart_rdata &
                      pic_rdata &
                      ps2_rdata &
		      mem_rdata &
		      vic_rdata &
                     utim_rdata ;
   

`ifdef GPIO

`VARIANT`GPIO_MICRO_REG
 #(.BASE_ADDR(4'h0),
   .BASE_WIDTH(4),
   .ADDR_WIDTH(8)
  )
gpio
( 
        .clk              ( clk          ),
        .reset            ( reset        ),
        .enable           ( enable       ),  
        .cs               ( cs_i         ),		      
        .wr               ( wr && enable ),
        .rd               ( rd           ),
        .waddr            ( addr[ADDR_WIDTH-BASE_WIDTH-1:0] ),
        .raddr            ( addr[ADDR_WIDTH-BASE_WIDTH-1:0] ),
        .wdata            ( wdata        ),
        .rdata            ( gpio_rdata   ),
        .gpio_0_out       ( gpio_0_out   ), 
        .next_gpio_0_out  ( gpio_0_out   ), 
        .gpio_0_oe        ( gpio_0_oe    ), 
        .next_gpio_0_oe   ( gpio_0_oe    ),
  
        .gpio_0_lat       ( gpio_0_lat   ), 
        .gpio_0_in        ( gpio_0_in    ), 

        .gpio_1_out       ( gpio_1_out   ), 
        .next_gpio_1_out  ( gpio_1_out   ),
  
        .gpio_1_oe        ( gpio_1_oe    ),
        .next_gpio_1_oe   ( gpio_1_oe    ),  

        .gpio_1_lat       ( gpio_1_lat   ), 
        .gpio_1_in        ( gpio_1_in    ) 

);

`else

  assign gpio_rdata = 8'hff;

`endif  

   
`ifdef TIMER

`VARIANT`TIMER
 #(.BASE_ADDR(4'h1),
   .BASE_WIDTH(4),
   .ADDR_WIDTH(8)
  )
tim_0
( 
        .clk       ( clk          ),
        .reset     ( reset        ),
        .enable    ( enable       ),
        .cs        ( cs_i         ),
        .wr        ( wr && enable ),		       
        .rd        ( rd           ),
        .waddr     ( addr[ADDR_WIDTH-BASE_WIDTH-1:0] ),
        .raddr     ( addr[ADDR_WIDTH-BASE_WIDTH-1:0] ),
        .wdata     ( wdata        ),
        .rdata     ( timer_rdata  ),
        .irq       ( timer_irq    )

);


`else

  assign timer_rdata = 8'hff;

`endif  

   
`ifdef UART

  
`VARIANT`UART
 #(.BASE_ADDR     (4'h2),
   .BASE_WIDTH    (4),
   .ADDR_WIDTH    (8),
   .TX_FIFO       (TX_FIFO),       
   .TX_FIFO_SIZE  (TX_FIFO_SIZE),  
   .TX_FIFO_WORDS (TX_FIFO_WORDS), 
   .RX_FIFO       (RX_FIFO),       
   .RX_FIFO_SIZE  (RX_FIFO_SIZE),  
   .RX_FIFO_WORDS (RX_FIFO_WORDS) 
  )
uart
 ( 
        .clk         ( clk          ),
        .reset       ( reset        ),
        .enable      ( enable       ),
        .cs          ( cs_i         ),
        .wr          ( wr && enable ),		       
        .rd          ( rd           ),
        .waddr       ( addr[ADDR_WIDTH-BASE_WIDTH-1:0] ),
        .raddr       ( addr[ADDR_WIDTH-BASE_WIDTH-1:0] ),
        .wdata       ( wdata        ),
        .rdata       ( uart_rdata   ),
        .txd_pad_out ( txd_pad_out  ),
        .rxd_pad_in  ( rxd_pad_in   ),
        .cts_pad_in  ( cts_pad_in   ),
        .rts_pad_out ( rts_pad_out  ),
        .rx_irq      ( rx_irq       ),
        .tx_irq      ( tx_irq       )   
   
);



`else

  assign uart_rdata = 8'hff;

`endif  

   
`ifdef PIC

   

`VARIANT`PIC
 #(.BASE_ADDR(4'h3),
   .BASE_WIDTH(4),
   .ADDR_WIDTH(8),
   .NMI_MODE(NMI_MODE),
   .IRQ_MODE(IRQ_MODE)
  )
pic
 ( 
        .clk         ( clk          ),
        .reset       ( reset        ),
        .enable      ( enable       ),
        .cs          ( cs_i         ),
        .wr          ( wr && enable ),		       
        .rd          ( rd           ),
        .waddr       ( addr[ADDR_WIDTH-BASE_WIDTH-1:0] ),
        .raddr       ( addr[ADDR_WIDTH-BASE_WIDTH-1:0] ),
        .wdata       ( wdata        ),
        .rdata       ( pic_rdata    ),
        .int_in      ( ext_irq_in   ),
        .irq_out     ( pic_irq      ),
        .nmi_out     ( pic_nmi      )
);

		

`else

  assign pic_rdata = 8'hff;

`endif  

   
`ifdef PS2

 
`VARIANT`PS2
 #(.BASE_ADDR(4'h4),
   .BASE_WIDTH(4),
   .ADDR_WIDTH(8)
  )
ps2
 ( 
        .clk             ( clk              ),
        .reset           ( reset            ),
        .enable          ( enable           ),
        .cs              ( cs_i             ),
        .wr              ( wr               ),		       
        .rd              ( rd               ),
        .waddr           ( addr[ADDR_WIDTH-BASE_WIDTH-1:0] ),
        .raddr           ( addr[ADDR_WIDTH-BASE_WIDTH-1:0] ),
        .wdata           ( wdata            ),
        .rdata           ( ps2_rdata        ),
        .rcv_data_avail  ( ps2_data_avail   ),
        .ps2_clk_pad_oe  ( ps2_clk_pad_oe   ),
        .ps2_clk_pad_in  ( ps2_clk_pad_in   ),
        .ps2_data_pad_oe ( ps2_data_pad_oe  ),
        .ps2_data_pad_in ( ps2_data_pad_in  ),
        .y_pos           ( y_pos            ),
        .x_pos           ( x_pos            ),
        .new_packet      ( new_packet       ),
        .ms_mid          ( ms_mid           ), 
        .ms_right        ( ms_right         ),  
        .ms_left         ( ms_left          )  

   
);



`else

  assign ps2_rdata = 8'hff;

`endif  

   
`ifdef UTIMER


`VARIANT`UTIMER
 #(.BASE_ADDR(4'h5),
   .BASE_WIDTH(4),
   .ADDR_WIDTH(8)
  )
utimer
( 
        .clk       ( clk          ),
        .reset     ( reset        ),
        .enable    ( enable       ),
        .cs        ( cs_i         ),
        .wr        ( wr && enable ),		       
        .rd        ( rd           ),
        .waddr     ( addr[ADDR_WIDTH-BASE_WIDTH-1:0] ),
        .raddr     ( addr[ADDR_WIDTH-BASE_WIDTH-1:0] ),
        .wdata     ( wdata        ),
        .rdata     ( utim_rdata   )

);


`else

  assign utim_rdata = 8'hff;

`endif  





`ifdef VGA


`VARIANT`VGA
 #(.BASE_ADDR(4'h6),
   .BASE_WIDTH(4),
   .ADDR_WIDTH(8),
   .STARTUP(STARTUP),
   .FONT(FONT)
  )
vga
( 
        .clk       ( clk          ),
        .reset     ( reset        ),
        .enable    ( enable       ),
        .cs        ( cs_i         ),
        .wr        ( wr && enable ),		       
        .rd        ( rd           ),
        .waddr     ( addr[ADDR_WIDTH-BASE_WIDTH-1:0] ),
        .raddr     ( addr[ADDR_WIDTH-BASE_WIDTH-1:0] ),
        .wdata     ( wdata        ),
        .rdata     ( vga_rdata   ),

        .vgared_pad_out   (vgared_pad_out),
        .vgagreen_pad_out (vgagreen_pad_out),
        .vgablue_pad_out  (vgablue_pad_out),

        .hsync_n_pad_out  (hsync_n_pad_out),
        .vsync_n_pad_out  (vsync_n_pad_out)

  
);


`else

assign vga_rdata = 8'hff;

assign vgared_pad_out= 3'b000;
assign vgagreen_pad_out= 3'b000;
assign vgablue_pad_out= 2'b00;

assign hsync_n_pad_out= 1'b1;
assign vsync_n_pad_out= 1'b1;

   
`endif  

   






`ifdef MEM


`VARIANT`MEM
 #(.BASE_ADDR(4'h7),
   .BASE_WIDTH(4),
   .ADDR_WIDTH(8)
  )
mem
( 
        .clk       ( clk          ),
        .reset     ( reset        ),
        .enable    ( enable       ),
        .cs        ( cs_i         ),
        .wr        ( wr           ),		       
        .rd        ( rd           ),
        .waddr     ( addr[ADDR_WIDTH-BASE_WIDTH-1:0] ),
        .raddr     ( addr[ADDR_WIDTH-BASE_WIDTH-1:0] ),
        .mem_add   ( mem_add[15:0]),
        .wdata     ( wdata        ),
        .rdata     ( mem_rdata    ),
        .cs_mem    ( cs_mem       ),
        .ext_add   ( ext_add      ),
        .ext_wdata ( ext_wdata    ),
        .ext_rdata ( ext_rdata    ),
        .ext_ub    ( ext_ub       ),
        .ext_lb    ( ext_lb       ),
        .ext_rd    ( ext_rd       ),
        .ext_wr    ( ext_wr       ),
        .ext_cs    ( ext_cs       ) 
);


`else

assign  mem_rdata =  8'hff;
assign  ext_add   = 23'b00000000000000000000000;
assign  ext_wdata = 16'b0000000000000000;
assign  ext_ub    =  1'b1;
assign  ext_lb    =  1'b1;
assign  ext_rd    =  1'b1;
assign  ext_wr    =  1'b1;
assign  ext_cs    =  2'b11;

   
   
`endif  

   









`ifdef VIC

   

`VARIANT`VIC
 #(.BASE_ADDR(4'h8),
   .BASE_WIDTH(4),
   .ADDR_WIDTH(8)
  )
vic
 ( 
        .clk         ( clk          ),
        .reset       ( reset        ),
        .enable      ( enable       ),
        .cs          ( cs_i         ),
        .wr          ( wr && enable ),		       
        .rd          ( rd           ),
        .waddr       ( addr[ADDR_WIDTH-BASE_WIDTH-1:0] ),
        .raddr       ( addr[ADDR_WIDTH-BASE_WIDTH-1:0] ),
        .wdata       ( wdata        ),
        .rdata       ( vic_rdata    ),
        .int_in      ( ext_irq_in   ),
        .irq_out     ( int_out      ),
        .vector      ( vector       )
);

		

`else

  assign vic_rdata = 8'hff;

`endif  


   

   
   
endmodule

