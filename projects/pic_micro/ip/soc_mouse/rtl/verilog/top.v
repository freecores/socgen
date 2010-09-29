`include "defines.v"



module 
`VARIANT

#( 
   parameter  ROM_FILE          = "NONE",
   parameter  ROM_WORDS         = 0,
   parameter  ROM_ADDR          = 0,
   parameter  ROM_WIDTH         = 0,
   parameter  TX_FIFO           = 0,
   parameter  TX_FIFO_SIZE      = 3,
   parameter  TX_FIFO_WORDS     = 8,
   parameter  RX_FIFO           = 0,
   parameter  RX_FIFO_SIZE      = 3,
   parameter  RX_FIFO_WORDS     = 8    
 )
(


input    wire           clk,
input    wire           reset,

output   wire [10:0]	inst_addr,
 
output   wire [7:0]     portaout,
output   wire [7:0]     portbout,
output   wire [7:0]     portcout,

output   wire           ps2_data_pad_oe,
output   wire           ps2_clk_pad_oe,

input    wire           ps2_data_pad_in,
input    wire           ps2_clk_pad_in,

output wire [9:0]       y_pos,
output wire [9:0]       x_pos,
output wire             new_packet,
output wire             ms_mid, 
output wire             ms_right,  
output wire             ms_left,  



output  wire            txd_pad_out,
input   wire            rxd_pad_in,
input   wire            cts_pad_in,
output  wire            rts_pad_out  


 
);



wire  [7:0]     portain; 
wire  [7:0]     portbin;
wire  [7:0]     portcin;


 // Declare I/O Port connections

wire 	        porta_we;
wire 	        portb_we;
wire 	        portc_we;
   

wire  [7:0]     trisa;
wire  [7:0]     trisb;
wire  [7:0]     trisc;

reg             wr;
wire            rd;
wire   [15:0]   addr;
wire    [7:0]   wdata;

wire   [7:0]    rdata;

wire   [7:0]    gpio_0_out;
wire   [7:0]    gpio_0_oe;
wire   [7:0]    gpio_0_lat;

wire   [7:0]    gpio_1_out;
wire   [7:0]    gpio_1_oe;
wire   [7:0]    gpio_1_lat;

wire            ps2_data_avail;
wire            rx_irq;   
wire            tx_irq;   

`ifdef CPU   

// Instantiate one CPU to be tested.
pic16c5x 
#(
.ROM_WORDS (  ROM_WORDS ), 
.ROM_ADDR  (  ROM_ADDR  ),  
.ROM_WIDTH (  ROM_WIDTH ), 
.ROM_FILE  (  ROM_FILE  )
)
pic(
   .clk		( clk      ),
   .rst_in	( reset    ),
   .inst_addr	( inst_addr),
    
   .portain	( portain  ),
   .portbin	( portbin  ),
   .portcin	( portcin  ),

   .portaout	( portaout ),
   .portbout	( portbout ),
   .portcout	( portcout ),

   .porta_we    ( porta_we ),
   .portb_we    ( portb_we ),
   .portc_we    ( portc_we ),
    
    
   .trisa	( trisa    ),
   .trisb	( trisb    ),
   .trisc	( trisc    ),
   .option      (          ),
   .wdt_clr     (          )

   );


`else // !`ifdef CPU






// Declare ROM and rom signals

wire [11:0]	inst_data;





// Instantiate one CPU to be tested.
mrisc pic(
   .clk		( clk      ),
   .rst_in	( reset    ),
	 
   .inst_addr	( inst_addr),
   .inst_data	( inst_data),

   .portain	( portain  ),
   .portbin	( portbin  ),
   .portcin	( portcin  ),

   .portaout	( portaout ),
   .portbout	( portbout ),
   .portcout	( portcout ),

   .porta_we    ( porta_we ),
   .portb_we    ( portb_we ),
   .portc_we    ( portc_we ),
	 
   .trisa	( trisa    ),
   .trisb	( trisb    ),
   .trisc	( trisc    ),
   
   .tcki	( 1'b0     ),
   .wdt_en	( 1'b0     )

   );


// Instantiate the Program RAM.
cde_sram
#(
.WORDS(ROM_WORDS), 
.ADDR(ROM_ADDR  ),  
.WIDTH (ROM_WIDTH ), 
.INIT_FILE(ROM_FILE)
)


 u1 (
   .clk		( clk              ),
   .raddr	( inst_addr        ),
   .waddr      ( inst_addr        ),
   .rd          ( 1'b1             ),
   .cs          ( 1'b1             ),
   .wr		( 1'b0             ),
   .wdata	( 12'b000000000000 ),
   .rdata	( inst_data        )
);






`endif // !`ifdef CPU
   











// IO buffers for IO Ports

   wire [7:0] 	dummy;
   

assign portbin = portbout;
assign portcin = portcout;





io_module_mouse
#(
  .BASE_WIDTH     ( 0             ),
  .ADDR_WIDTH     ( 8             ),
  .TX_FIFO        ( TX_FIFO       ),     
  .TX_FIFO_SIZE   ( TX_FIFO_SIZE  ),   
  .TX_FIFO_WORDS  ( TX_FIFO_WORDS ),  
  .RX_FIFO        ( RX_FIFO       ),
  .RX_FIFO_SIZE   ( RX_FIFO_SIZE  ),  
  .RX_FIFO_WORDS  ( RX_FIFO_WORDS )  
 )
  
io_module ( 
      .clk               ( clk             ),
      .reset             ( reset           ),
      .enable            (1'b1             ),
      .cs_i              (1'b1             ),
      .wr                ( wr              ),
      .rd                (!wr              ),
      .addr              (       portbout  ),
      .waddr             (       portbout  ),
      .wdata             ( portaout        ),
      .rdata             ( {dummy,portain} ),
      .ps2_data_pad_in   ( ps2_data_pad_in ),
      .ps2_data_pad_oe   ( ps2_data_pad_oe ),
      .ps2_clk_pad_in    ( ps2_clk_pad_in  ),
      .ps2_clk_pad_oe    ( ps2_clk_pad_oe  ),
      .ps2_data_avail    ( ps2_data_avail  ),
      .y_pos             ( y_pos           ),
      .x_pos             ( x_pos           ),
      .new_packet        ( new_packet      ),
      .ms_mid            ( ms_mid          ), 
      .ms_right          ( ms_right        ),  
      .ms_left           ( ms_left         ), 
      .txd_pad_out       ( txd_pad_out     ),
      .rxd_pad_in        ( rxd_pad_in      ),
      .cts_pad_in        ( cts_pad_in      ),
      .rts_pad_out       ( rts_pad_out     ),  
      .rx_irq            ( rx_irq          ),
      .tx_irq            ( tx_irq          ), 
      .ext_irq_in        ( {3'b000,ps2_data_avail,tx_irq,rx_irq,2'b00}),
      .pic_irq           (                 ),
      .pic_nmi           (                 )


	    
	    

    );


always@(posedge clk)
  if (reset) wr <= 1'b0;
  else       wr <= porta_we;
   
  

   
   
endmodule
