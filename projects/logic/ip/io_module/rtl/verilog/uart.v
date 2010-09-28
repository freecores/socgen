`include "defines.v"

`ifdef UART

module `VARIANT`UART
#(parameter BASE_ADDR     = 4'h0,
  parameter BASE_WIDTH    = 4,
  parameter ADDR_WIDTH    = 8,
  parameter TX_FIFO       = 0,
  parameter TX_FIFO_SIZE  = 3,
  parameter TX_FIFO_WORDS = 8,
  parameter RX_FIFO       = 0,
  parameter RX_FIFO_SIZE  = 3,
  parameter RX_FIFO_WORDS = 8  
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
output  wire   [7:0]    rdata,
output  wire            txd_pad_out,
input   wire            rxd_pad_in,
input   wire            cts_pad_in,
output  wire            rts_pad_out,
output   reg            rx_irq,
output   reg            tx_irq   
);



wire  [7:0] 	      status;   
wire  [7:0] 	      rcv_data;
wire  [7:0]           cntrl;
wire  [7:0]           lat_wdata;
wire                  txd_load;
wire                  rxd_data_avail_stb;
wire                  rxd_data_avail;   


   
 `VARIANT`UART_MICRO_REG

#(.BASE_ADDR(BASE_ADDR   ),
  .BASE_WIDTH(BASE_WIDTH ),
  .ADDR_WIDTH(ADDR_WIDTH )    
)
   uart_micro_reg
( 
   .clk                ( clk                ),
   .reset              ( reset              ),
   .enable             ( enable             ),
   .cs                 ( cs                 ),		      
   .wr                 ( wr                 ),
   .rd                 ( rd                 ),
   .waddr              ( waddr              ),
   .raddr              ( raddr              ),
   .wdata              ( wdata              ),
   .rdata              ( rdata              ),
   .lat_wdata          ( lat_wdata          ),
   .rcv_data           ( rcv_data           ),
   .status             ( status             ),
   .cntrl              ( cntrl              ),
   .txd_load           ( txd_load           ),
   .rxd_data_avail_stb ( rxd_data_avail_stb ) 
);

   


   

   
  
// TX_IRQ_EN,RX_IRQ_EN,0,0,RTS,TX_BREAK,FORCE_PARITY,PARITY
// cntrl



   always@(posedge clk)
   if (reset)                                       rx_irq <= 1'b0;
   else                                             rx_irq <= cntrl[6] && rxd_data_avail;

   always@(posedge clk)
   if (reset)                                       tx_irq <= 1'b0;
   else                                             tx_irq <= cntrl[7] && status[5];
   


   
 assign  status[2] = 1'b0;
 assign  status[0] = rxd_data_avail;
   
uart
#(
            .DIV           (0),
            .TX_FIFO       (TX_FIFO),       
            .TX_FIFO_SIZE  (TX_FIFO_SIZE),  
            .TX_FIFO_WORDS (TX_FIFO_WORDS), 
            .RX_FIFO       (RX_FIFO),       
            .RX_FIFO_SIZE  (RX_FIFO_SIZE),  
            .RX_FIFO_WORDS (RX_FIFO_WORDS) 
)
 uart(
         .clk                 ( clk                ),
         .reset               ( reset              ),
         .divider_in          ( 4'b1011            ),  // 9600 @ 25Mhz when DIV=1
         .txd_parity          ( cntrl[0]           ),
         .txd_force_parity    ( cntrl[1]           ),
         .txd_break           ( cntrl[2]           ),
         .rts_in              ( cntrl[3]           ),
         .parity_enable       ( cntrl[4]           ),
         .txd_data_in         ( lat_wdata          ),	
         .txd_load            ( txd_load           ),
         .rxd_data_out        ( rcv_data           ),
         .rxd_parity          ( cntrl[0]           ),
         .rxd_force_parity    ( cntrl[1]           ),	
         .rxd_stop_error      ( status[1]          ),
         .rxd_parity_error    ( status[3]          ),
         .rxd_data_avail_stb  ( rxd_data_avail_stb ),
         .rxd_data_avail      ( rxd_data_avail     ),     
         .cts_out             ( status[4]          ),
         .txd_buffer_empty    ( status[5]          ),
         .txd_pad_out         ( txd_pad_out        ),
         .rxd_pad_in          ( rxd_pad_in         ),
         .cts_pad_in          ( cts_pad_in         ),
         .rts_pad_out         ( rts_pad_out        )
);


   
endmodule

`endif //  `ifdef UART
