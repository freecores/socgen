//*---------------------------------------------------------------------
//*
//*             -------
//*            /   SOC  \
//*           /    GEN   \
//*          /  COMPONENT \
//*          ==============
//*         | uart_engine  |
//*         |______________|
//*
//*  <one line to give the program's name and a brief idea of what it does.>
//*
//*
//*    Copyright (C) <2009>  <John T Eaton>
//*
//*    This program is free software: you can redistribute it and/or modify
//*    it under the terms of the GNU General Public License as published by
//*    the Free Software Foundation, either version 3 of the License, or
//*    (at your option) any later version.
//*
//*    This program is distributed in the hope that it will be useful,
//*    but WITHOUT ANY WARRANTY; without even the implied warranty of
//*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//*    GNU General Public License for more details.
//*
//*    You should have received a copy of the GNU General Public License
//*    along with this program.  If not, see <http://www.gnu.org/licenses/>.
//*
//*   Also add information on how to contact you by electronic and paper mail.
//*
//*---------------------------------------------------------------------

`include "defines.v"


module
`VARIANT   
#(parameter     PRESCALE=5'b01100,
  parameter     PRE_SIZE=5,
  parameter     SIZE=8,
  parameter     DIV=0,
  parameter     DIV_SIZE=4,
  parameter     TX_FIFO=0,
  parameter     TX_FIFO_SIZE=3,
  parameter     TX_FIFO_WORDS=8,
  parameter     RX_FIFO=0,
  parameter     RX_FIFO_SIZE=3,
  parameter     RX_FIFO_WORDS=8  


    )  


(
input  wire                 clk,
input  wire                 reset,
input  wire                 parity_enable,
input  wire [DIV_SIZE-1:0]  divider_in,
 
input  wire                 cts_pad_in,
output  reg                 rts_pad_out,
output wire                 txd_pad_out,
input  wire                 rxd_pad_in,
 
output  reg                 cts_out,
input  wire                 rts_in,

input  wire                 txd_parity,
input  wire                 txd_force_parity,
input  wire                 txd_load,
input  wire                 txd_break,
input  wire [SIZE-1:0]      txd_data_in,
output wire                 txd_buffer_empty,


input  wire                 rxd_data_avail_stb, 
output wire                 rxd_data_avail,

input  wire                 rxd_parity,
input  wire                 rxd_force_parity,
output wire [SIZE-1:0]      rxd_data_out,
output wire                 rxd_parity_error,
output wire                 rxd_stop_error
                         );


wire 	                 baud_clk;
wire 	                 baud_clk_div;
wire [7:0]               fifo_data_out;
wire                     fifo_full;
wire                     fifo_empty;   
wire                     fifo_over_run;   
wire                     fifo_under_run;   
wire                     cde_buffer_empty;
 reg                     xmit_start;

   
always@(posedge clk)
  if(reset)            rts_pad_out  <= 1'b0;
  else                 rts_pad_out  <= rts_in;

always@(posedge clk)
  if(reset)            cts_out      <= 1'b0;
  else                 cts_out      <= cts_pad_in;

   

cde_divider
#(.SIZE(PRE_SIZE))  
divider  (
         .clk             ( clk          ),
         .reset           ( reset        ),
	 .divider_in      ( PRESCALE     ),
         .enable          ( 1'b1         ),
	 .divider_out     ( baud_clk )
         );


generate

if(DIV == 0)
  begin   
assign    baud_clk_div = baud_clk;
  end
else   
begin
cde_divider
#(.SIZE(DIV_SIZE))  
baud_divider  (
         .clk             ( clk          ),
         .reset           ( reset        ),
	 .divider_in      ( divider_in   ),
         .enable          ( baud_clk     ),
	 .divider_out     ( baud_clk_div )
         );
end  

endgenerate


cde_divider
#(.SIZE(4))  
x_divider  (
         .clk             ( clk             ),
         .reset           ( reset           ),
	 .divider_in      ( 4'b1111         ),
         .enable          ( baud_clk_div    ),
	 .divider_out     ( xmit_enable     )
         );




generate

if(TX_FIFO == 0)
  begin

     always@(*)  xmit_start       = txd_load;
     assign fifo_data_out    = txd_data_in;
     assign txd_buffer_empty = cde_buffer_empty;     
     
  end
else
  begin

   

always@(posedge clk)
  if(reset)
    begin
       xmit_start     <= 1'b0;
    end
  else
  if( !fifo_empty &&   cde_buffer_empty &&  !xmit_start )  
    begin
       xmit_start     <= 1'b1;
    end
  else
    begin
       xmit_start     <= 1'b0;
    end



cde_fifo
#(.WIDTH(SIZE),
  .SIZE(TX_FIFO_SIZE),  
  .WORDS(TX_FIFO_WORDS))
fifo  
(
      .clk        ( clk            ),
      .reset      ( reset          ),
      .push       ( txd_load       ),
      .din        ( txd_data_in    ),
      .pop        ( !fifo_empty &&   cde_buffer_empty && ! xmit_start ),
      .dout       ( fifo_data_out  ),
      .full       ( fifo_full      ),
      .empty      ( fifo_empty     ),
      .over_run   ( fifo_over_run  ),
      .under_run  ( fifo_under_run )
);


assign txd_buffer_empty =      !fifo_full;
  end

endgenerate
    

cde_serial_xmit
cde_serial_xmit (
               .clk              ( clk               ),
               .reset            ( reset             ),
               .edge_enable      ( xmit_enable       ),                 
               .parity_enable    ( parity_enable     ),               
               .parity_force     ( txd_force_parity  ),                 
               .parity_type      ( txd_parity        ),                 
               .load             ( xmit_start        ),                        
               .start_value      ( 1'b0              ),                 
               .stop_value       (!txd_break         ),                  
               .data             ( fifo_data_out     ),                        
               .buffer_empty     ( cde_buffer_empty  ),                
               .ser_out          ( txd_pad_out       )            
                );
   
serial_rcvr
          #(.RX_FIFO(RX_FIFO),
            .RX_FIFO_SIZE(RX_FIFO_SIZE),
            .RX_FIFO_WORDS(RX_FIFO_WORDS))
serial_rcvr(
           .clk                ( clk                 ),
           .reset              ( reset               ),
           .edge_enable        ( baud_clk_div        ),                 
           .parity_enable      ( parity_enable       ),               
           .parity_type        ( rxd_parity          ),                 
           .parity_force       ( rxd_force_parity    ),                 
           .start_value        ( 1'b0                ),                 
           .stop_value         ( 1'b1                ),                  
           .pad_in             ( rxd_pad_in          ),                      
           .rcv_stb            ( rxd_data_avail_stb  ),
           .data_out           ( rxd_data_out        ),
      	   .parity_error       ( rxd_parity_error    ),
           .stop_error         ( rxd_stop_error      ),
	   .data_avail         ( rxd_data_avail      )
           );




   

   
`ifdef SYNTHESIS

`else
   
always@(posedge serial_rcvr.frame_rdy)
   begin
   $display("%t %m              Received   %h   stop error %b parity error %b",
            $realtime,serial_rcvr.shift_buffer, serial_rcvr.frame_error,serial_rcvr.frame_parity_error );
   end

always@(posedge clk)
   begin
   if(!reset &&  xmit_start)
     begin
     $display("%t %m              Sending    %h",    $realtime,fifo_data_out );
     end
   end

 `endif





   
   
endmodule



