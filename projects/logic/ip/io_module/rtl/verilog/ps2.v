`include "defines.v"

`ifdef PS2


module `VARIANT`PS2
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
output  wire            rcv_data_avail,

output wire             ps2_clk_pad_oe,   
input  wire             ps2_clk_pad_in,   
output wire             ps2_data_pad_oe,  
input  wire             ps2_data_pad_in,  


output  reg [9:0]       y_pos       ,
output  reg [9:0]       x_pos       ,
output  reg             new_packet  ,
output  reg             ms_mid      ,  
output  reg             ms_right    ,  
output  reg             ms_left
);



   

parameter PS2_DATA      = 4'h0;
parameter STATUS        = 4'h2;
parameter CNTRL         = 4'h4;
parameter X_POS         = 4'h6;   
parameter Y_POS         = 4'h8;

   
reg 	              was;
reg 	              ras;
   
reg   [7:0] 	      cntrl;
reg   [7:0]           wdata_buf;   
wire  [7:0] 	      rcv_data;
wire  [7:0] 	      status;
wire    	      busy;
wire    	      buffer_empty;

wire                  rx_parity_error;
wire                  rx_parity_rcv;
wire                  rx_parity_cal;
wire                  rx_frame_error;
wire                  tx_ack_error; 
wire         	      read;
wire                  poll_enable ;

reg [1:0]             byt_cntr    ;
reg                   ms_y_ovf    ;  
reg                   ms_x_ovf    ;  
reg                   ms_y_sign   ;  
reg                   ms_x_sign   ;  
reg                   ms_one      ;  




   

   

   
      
always@(*)     was = (waddr[ADDR_WIDTH-1:ADDR_WIDTH-BASE_WIDTH] == BASE_ADDR);
always@(*)     ras = (raddr[ADDR_WIDTH-1:ADDR_WIDTH-BASE_WIDTH] == BASE_ADDR);


   
always@(*)
  if(rd && cs && ras)
    begin
    case(raddr[3:0])
    PS2_DATA:     rdata  = rcv_data;
    STATUS:       rdata  = {
                            !buffer_empty,
                             rcv_data_avail,
                             busy,
                             rx_parity_error,
                             rx_parity_rcv  ,
                             rx_parity_cal  ,
                             rx_frame_error ,
                             tx_ack_error 
                            };

    CNTRL:        rdata  = cntrl;
    X_POS:        rdata  = x_pos[7:0];  
    Y_POS:        rdata  = y_pos[7:0];  

    default:      rdata  = 8'h00;
    endcase
    end
  else            rdata  = 8'hFF;
   


   


always@(posedge clk)
if(reset)                                          wdata_buf <= 8'h00;
else
if( wr && was && cs && enable && waddr[3:0] == PS2_DATA)
                                                   wdata_buf <= wdata;
else
                                                   wdata_buf <= wdata_buf;
       


always@(posedge clk)
if(reset)                                          cntrl     <= 8'h00;
else
if( wr && was && cs && enable  && waddr[3:0] == CNTRL)
                                                   cntrl     <= wdata;
else                                               cntrl     <= cntrl;






   
   
   
ps2_interface
#(.CLK_HOLD_DELAY(1),  
  .DATA_SETUP_DELAY(14)    
 )  

 ps2(
        .clk               ( clk              ),          
        .reset             ( reset            ),          
        .ps2_clk_pad_oe    ( ps2_clk_pad_oe   ),   
        .ps2_clk_pad_in    ( ps2_clk_pad_in   ),   
        .ps2_data_pad_oe   ( ps2_data_pad_oe  ),  
        .ps2_data_pad_in   ( ps2_data_pad_in  ),

        .busy              ( busy             ),
        .tx_buffer_empty   ( buffer_empty     ),
        .tx_data           ( wdata_buf        ),
        .tx_write          ( cntrl[1]         ),
        .rx_data           ( rcv_data         ),
        .rx_read           ( read             ),

        .rx_full           ( rcv_data_avail   ),
        .rx_parity_error   ( rx_parity_error  ),
        .rx_parity_rcv     ( rx_parity_rcv    ),
        .rx_parity_cal     ( rx_parity_cal    ),
        .rx_frame_error    ( rx_frame_error   ),
        .rx_clear          ( cntrl[0] ? read :rd && ras && cs && enable && (raddr[3:0] == PS2_DATA)),
        .tx_ack_error      ( tx_ack_error     ) 
);

 



assign        poll_enable  =   cntrl[0];

		    

  
     

   
   always@(posedge clk )
     if(reset || (!poll_enable)) 
       begin     
       byt_cntr       <= 2'b00;
       new_packet     <= 1'b0;
       end
     else
     if(read)  
       begin
     byt_cntr       <= byt_cntr + 2'b01;
     new_packet     <= 1'b0;
     end
     else      
     if (byt_cntr == 2'b11)
       begin
         byt_cntr       <= 2'b00;
         new_packet     <= 1'b1;
       end  
     else
       begin
       byt_cntr       <= byt_cntr;
       new_packet     <= 1'b0;
       end
   


   
     always@(posedge  clk)
     if( reset  || (!poll_enable) ) 
           begin
           ms_y_ovf   <= 1'b0;
           ms_x_ovf   <= 1'b0;
           ms_y_sign  <= 1'b0;
           ms_x_sign  <= 1'b0;
           ms_one     <= 1'b1;
           ms_mid     <= 1'b0;
           ms_right   <= 1'b0;
           ms_left    <= 1'b0;
           x_pos      <= 10'h000;
           y_pos      <= 10'h000;
        end
     else                  
         if( read) 
           begin
                if (byt_cntr == 2'b00)  {ms_y_ovf,ms_x_ovf,ms_y_sign,ms_x_sign,ms_one,ms_mid,ms_right,ms_left} <= rcv_data;
                else
        if (byt_cntr == 2'b01)   x_pos            <= x_pos +   {ms_x_sign,ms_x_sign,ms_x_sign,rcv_data};
                else
        if (byt_cntr == 2'b10)   y_pos            <= y_pos -   {ms_y_sign,ms_y_sign,ms_y_sign,rcv_data};
                else                     
                 begin
                    x_pos  <= x_pos;
                    y_pos  <= y_pos;
                 end

           end   
         else     
                    begin
                    x_pos  <= x_pos;
                    y_pos  <= y_pos;
                 end




   
endmodule

`endif //  `ifdef PS2
