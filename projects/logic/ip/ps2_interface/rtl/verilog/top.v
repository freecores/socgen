////////////////////////////////////////////////////////////////////
//     --------------                                             //
//    /      SOC     \                                            //
//   /       GEN      \                                           //
//  /     COMPONENT    \                                          //
//  ====================                                          //
//  |digital done right|                                          //
//  |__________________|                                          //
//                                                                //
//                                                                //
//                                                                //
//    Copyright (C) <2009>  <Ouabache DesignWorks>                //
//                                                                //
//                                                                //  
//   This source file may be used and distributed without         //  
//   restriction provided that this copyright statement is not    //  
//   removed from the file and that any derivative work contains  //  
//   the original copyright notice and the associated disclaimer. //  
//                                                                //  
//   This source file is free software; you can redistribute it   //  
//   and/or modify it under the terms of the GNU Lesser General   //  
//   Public License as published by the Free Software Foundation; //  
//   either version 2.1 of the License, or (at your option) any   //  
//   later version.                                               //  
//                                                                //  
//   This source is distributed in the hope that it will be       //  
//   useful, but WITHOUT ANY WARRANTY; without even the implied   //  
//   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      //  
//   PURPOSE.  See the GNU Lesser General Public License for more //  
//   details.                                                     //  
//                                                                //  
//   You should have received a copy of the GNU Lesser General    //  
//   Public License along with this source; if not, download it   //  
//   from http://www.opencores.org/lgpl.shtml                     //  
//                                                                //  
////////////////////////////////////////////////////////////////////


`include "defines.v"


module  `VARIANT
#(parameter FREQ=24,                     // clk frequency in Mhz
  parameter CLK_HOLD_DELAY   =100,       // number of microsecs to hold clk before host-> device xfer
  parameter DATA_SETUP_DELAY =20,        // number of microsecs to hold data startbit for host-> device xfer
  parameter DEBOUNCE_DELAY   =4'b1111    // number of clks to wait for debounce of ps2_clk and ps2_data
 )  


(

input  wire        clk,          
input  wire        reset,          
 
output wire        ps2_clk_pad_oe,   
input  wire        ps2_clk_pad_in,   
output wire        ps2_data_pad_oe,  
input  wire        ps2_data_pad_in,  

output  wire       busy,          

input  wire [7:0]  tx_data,      
input  wire        tx_write,        
   
output reg  [7:0]  rx_data,      
output reg         rx_read,         
output  reg        rx_full,
output  reg        rx_parity_error,
output  reg        rx_parity_rcv,
output  reg        rx_parity_cal,
output  reg        rx_frame_error,
 
input  wire        rx_clear, 
output wire        tx_buffer_empty,
output  reg        tx_ack_error
);

   
reg  [7:0]  usec_prescale_count;
reg  [6:0]  usec_delay_count;
reg         usec_delay_done;
reg         usec_tick;
reg         force_startbit;
reg         sending;
reg  [10:0] frame;
reg  [3:0]  bit_count;

wire        enable_usec_delay;
wire        start_xmit;
wire        ps2_clk_s;
wire        ps2_clk_rise;
wire        ps2_clk_fall;
wire        ps2_data_s;
wire        shift_frame;
wire        load_tx_data;
wire [7:0] x_shift_buffer;
wire       x_stop_cnt;
wire       x_last_cnt;
wire       x_parity_calc;
wire       x_parity_samp;
wire       x_frame_err;


cde_sync_with_hysteresis
#(.DEBOUNCE_DELAY(DEBOUNCE_DELAY))
clk_filter   
( 
           .clk         ( clk           ),          
           .reset       ( reset         ),          
           .data_in     ( ps2_clk_pad_in),   
           .data_out    ( ps2_clk_s     ),
           .data_rise   ( ps2_clk_rise  ),
           .data_fall   ( ps2_clk_fall  )
);


cde_sync_with_hysteresis
#(.DEBOUNCE_DELAY(DEBOUNCE_DELAY))
data_filter
( 
          .clk          ( clk            ),          
          .reset        ( reset          ),          
          .data_in      ( ps2_data_pad_in),   
          .data_out     ( ps2_data_s     ),
          .data_rise    (                ),
          .data_fall    (                )
);

   
always@(posedge clk)
    begin
       if (reset)                                  tx_ack_error <= 1'b0 ;
       else
       if (tx_write)                               tx_ack_error <= 1'b0 ;
       else
       if ((bit_count == 4'b1010)&& ps2_clk_fall)  tx_ack_error <= ps2_data_s && sending ;
       else                                        tx_ack_error <= tx_ack_error ;

    end      

  

ps2_interface_fsm
  #(.NUMBITS(11))
fsm
(
    .clk                        ( clk                         ),          
    .reset                      ( reset                       ),          
    .ps2_idle                   ( ps2_data_s &&   ps2_clk_s   ),  
    .ps2_clk_fall               ( ps2_clk_fall                ),  
    .bit_count                  ( bit_count                   ),
    .write                      ( tx_write                    ),        
    .force_startbit             ( force_startbit              ),
    .usec_delay_done            ( usec_delay_done             ),
    .load_tx_data               ( load_tx_data                ),
    .ps2_clk_oe                 ( ps2_clk_pad_oe              ),
    .busy                       ( busy                        ),
    .shift_frame                ( shift_frame                 ),
    .enable_usec_delay          ( enable_usec_delay           )
);



always@(posedge clk )
	if(reset)  
         begin
         usec_prescale_count        <= FREQ-1;
         usec_tick                  <= 1'b0;  
	 end
   	else
        begin				 
         if(enable_usec_delay )
	   begin
            if(usec_prescale_count == 0) 
              begin
               usec_prescale_count  <= FREQ-1;
               usec_tick            <= 1'b1;  	 
	      end
            else
	      begin
               usec_prescale_count  <= usec_prescale_count - 1;
               usec_tick            <= 1'b0;  
              end
            end 
         else
            begin
            usec_prescale_count     <= FREQ-1;
            usec_tick               <= 1'b0;  
            end 
         end 

	   

always@(posedge clk )
	if(reset)                                       force_startbit  <= 1'b0;
   	else 
        if(usec_delay_count <= DATA_SETUP_DELAY)        force_startbit  <= 1;
        else                                            force_startbit  <= 0;
      



 always@(posedge clk )
	if(reset)  
          begin
          usec_delay_count        <=  CLK_HOLD_DELAY + DATA_SETUP_DELAY;
          usec_delay_done         <=  0;
          end
   	else
        if(enable_usec_delay )
	  begin
          if(usec_delay_count == 7'b0000000) 
            begin
            usec_delay_count      <=  usec_delay_count;
            usec_delay_done       <=  1;
	    end
          else      
	  if(usec_tick)  
	    begin
            usec_delay_count      <=  usec_delay_count - 1;
            usec_delay_done       <=  0;
            end
          else
            begin
            usec_delay_count      <=  usec_delay_count;
            usec_delay_done       <=  usec_delay_done;
            end  
          end 
        else
          begin
          usec_delay_count        <=  CLK_HOLD_DELAY + DATA_SETUP_DELAY;
          usec_delay_done         <=  1'b0;
          end 
       
       

     
    always@(posedge clk ) 
      if(reset)               bit_count  <= 4'b0000;
      else
      if(!busy)               bit_count  <= 4'b0000;
      else 
      if(shift_frame)         bit_count  <= bit_count + 1;
      else                    bit_count  <= bit_count; 



   
    always@(posedge clk ) 
      if(reset)               sending    <= 1'b0;
      else
      if(tx_write)            sending    <= 1'b1;
      else 
      if(busy)                sending    <= sending;
      else                    sending    <= 1'b0; 

 


       
	   


   


cde_serial_xmit
cde_serial_xmit
          (
          .clk              ( clk             ),
          .reset            ( reset           ),
          .edge_enable      ( ( load_tx_data && force_startbit) || ps2_clk_fall ), // one pulse per bit time for data rate timing
          .parity_enable    (1'b1             ),     // 0 = no parity bit sent, 1= parity bit sent
          .parity_type      (1'b0             ),     // 0= odd
          .parity_force     (1'b0             ),     // no force
          .load             ( load_tx_data && force_startbit ),     // start transmiting data
          .start_value      (1'b1             ),     // value out at start bit time
          .stop_value       (1'b0             ),     // value out for stop bit also used for break
          .data             (~tx_data         ),     // data byte
          .buffer_empty     ( tx_buffer_empty ),     // ready for next byte
          .ser_out          ( ps2_data_pad_oe )      // to pad_ring
          );
   


cde_serial_rcvr
cde_serial_rcvr
(
          .clk               ( clk            ),
          .reset             ( reset ||(ps2_clk_s && ps2_data_s && !busy)         ),
          .edge_enable       ( ps2_clk_fall   ),               // one pulse per bit time for 16 x data rate timing
          .parity_enable     (1'b1            ),               // 0 = no parity bit sent, 1= parity bit sent
          .parity_type       (1'b1            ),               // 1= odd,0=even
          .parity_force      (1'b0            ),               // don't force 
          .stop_value        (1'b1            ),               // value out for stop bit
          .ser_in            ( ps2_data_s     ),               // from pad_ring
          .shift_buffer      ( x_shift_buffer ),
          .stop_cnt          ( x_stop_cnt     ),
          .last_cnt          ( x_last_cnt     ),
          .parity_calc       ( x_parity_calc  ),
          .parity_samp       ( x_parity_samp  ),
          .frame_err         ( x_frame_err    )
);  



   always@(posedge clk)
     if(reset)                    
       begin
        rx_data          <=  8'h00;
        rx_read          <=  1'b0;	  
        rx_full          <=  1'b0;
        rx_parity_error  <=  1'b0;
        rx_parity_rcv    <=  1'b0;
	rx_parity_cal    <=  1'b0;
        rx_frame_error   <=  1'b0;		   
	end
     else
     if(rx_clear)      
        begin
        rx_full          <=  1'b0;
        rx_read          <=  1'b0;
        rx_parity_error  <=  1'b0;
	rx_parity_cal    <=  1'b0;	
        rx_frame_error   <=  1'b0;	
        end
     else                    
     if(x_last_cnt && !sending )      
       begin
	rx_data          <=   x_shift_buffer;
	rx_read          <=  1'b1;  
        rx_full          <=  1'b1;
        rx_parity_error  <=  x_parity_samp ^ x_parity_calc;
        rx_parity_rcv    <=  x_parity_samp;
	rx_parity_cal    <=  x_parity_calc;
	rx_frame_error   <=  x_frame_err;
        end
     else 
        begin
        rx_full          <=  rx_full;
        rx_read          <=  1'b0;
        rx_parity_error  <=  rx_parity_error;
	rx_frame_error   <=  rx_frame_error;
        rx_parity_rcv    <=  rx_parity_rcv;	   
        rx_parity_cal    <=  rx_parity_cal;	   
	rx_data          <=  rx_data;  
        end


   
   

   
`ifndef SYNTHESIS
  always@(posedge clk)
  if(rx_read)
  $display ("%t %m host    rec    %h parity_rcv %b parity_cal %b parity_error   %b",$realtime,rx_data,rx_parity_rcv,rx_parity_cal,rx_parity_error);


   
  always@(posedge clk)
  if(!tx_write && load_tx_data && !enable_usec_delay )
  $display ("%t %m host   send    %h ",$realtime,tx_data);




   
`endif
   

endmodule 



