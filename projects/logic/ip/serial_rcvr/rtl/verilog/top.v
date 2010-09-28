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
//    Copyright (C) <2010>  <Ouabache DesignWorks>                //
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
//   for further infomation email:    jt_eaton@opencores.org      //
//                                                                //
////////////////////////////////////////////////////////////////////

`include "defines.v"

module 
`VARIANT
#(parameter     WIDTH=8,            // Number of data bits
  parameter     SIZE=4,             // binary size of shift_cnt, must be able to hold  WIDTH + 4 states       
  parameter     SAMPLE=4'b0111,     // point at which the sample is taken in the data stream
  parameter     RX_FIFO=0,
  parameter     RX_FIFO_SIZE=4,
  parameter     RX_FIFO_WORDS=16  
)(
input  wire              clk,
input  wire              reset,
input  wire              edge_enable,                 // one pulse per bit time for 16 x data rate timing
input  wire              parity_enable,               // 0 = no parity bit sent, 1= parity bit sent
input  wire              parity_type,                 // 1= odd,0=even
input  wire              parity_force,                // 1=force to parity_type
input  wire              start_value,                 // value out at start bit time
input  wire              stop_value,                  // value out for stop bit also used for break
input  wire              pad_in,                      // from pad_ring
input  wire              rcv_stb,                     // byte taken


output  wire [WIDTH-1:0]  data_out,
output  wire              parity_error,
output  wire              stop_error,
output  wire              data_avail
                         );
   


wire                     baud_enable;   
wire                     stop_cnt;
wire                     last_cnt;
wire [WIDTH-1:0]         next_shift_buffer;   
wire                     next_parity_calc;  
wire                     next_parity_samp;   
wire                     next_frame_error;
   
reg                      parity_calc;
reg                      parity_samp;
reg                      frame_rdy;
reg                      start_detect;   
reg                      rxd_pad_sig;
reg   [1:0]              rdy_del;   

reg [WIDTH-1:0]  shift_buffer;   
reg              frame_parity_error;   
reg              frame_error;   
reg              frame_avail;   
   
always@(posedge clk)
if(reset)                                              rxd_pad_sig <= 1'b1;
else                                                   rxd_pad_sig <= pad_in;
   

always@(posedge clk)
if(reset)                                              start_detect <= 1'b0;
else
if(start_detect)  
  begin
    if(stop_cnt  && edge_enable )                      start_detect <= !rxd_pad_sig;
    else
    if(last_cnt)                                       start_detect <= 1'b0;
    else                                               start_detect <= 1'b1;
  end
else
if(!rxd_pad_sig )                                      start_detect <= 1'b1;
else                                                   start_detect <= start_detect;


always@(posedge clk)
  if(reset)
    begin
    frame_rdy <= 1'b0;
    rdy_del   <= 2'b00;
    end
  else
    begin
    frame_rdy <=  rdy_del[1] ;
    rdy_del   <=  {rdy_del[0],last_cnt};
    end
   

cde_serial_rcvr
#(.WIDTH(WIDTH),  .SIZE(SIZE) )  
serial_rcvr
 (
     .clk              ( clk                ), 
     .reset            ( reset              ),
     .edge_enable      ( baud_enable        ),                 
     .parity_enable    ( parity_enable      ),               
     .parity_type      ( parity_type        ),                 
     .parity_force     ( parity_force       ),                 
     .stop_cnt         ( stop_cnt           ),                  
     .last_cnt         ( last_cnt           ),                  
     .stop_value       ( stop_value         ),                  
     .ser_in           ( pad_in             ),                      
     .shift_buffer     ( next_shift_buffer  ),
     .parity_calc      ( next_parity_calc   ),
     .parity_samp      ( next_parity_samp   ),
     .frame_err        ( next_frame_error   )
);  
   
cde_divider

#(.SIZE(4),
  .SAMPLE(8),
  .RESET(0)
)  
divider  
 (
     .clk             ( clk                      ),
     .reset           ( reset || (!start_detect) ),
     .enable          ( edge_enable              ),
     .divider_in      ( 4'b1111                  ),
     .divider_out     ( baud_enable              )
 );



 always@(posedge clk)
   if (reset)                                       frame_avail <= 1'b0;
   else
   if(frame_rdy)                                    frame_avail <= 1'b1;
   else  
   if(rcv_stb)                                      frame_avail <= 1'b0;
   else                                             frame_avail <= frame_avail;

   

always@(posedge clk)
  if(reset)
     begin
          shift_buffer   <=  8'h00;  
          parity_calc    <=  1'b0;
          parity_samp    <=  1'b0;
          frame_parity_error   <=  1'b0;
          frame_error    <=  1'b0;
     end
  else
  if(last_cnt )
      begin
          shift_buffer   <=  next_shift_buffer;  
          parity_calc    <=  next_parity_calc;
          parity_samp    <=  next_parity_samp;
	  frame_parity_error   <=  (next_parity_samp ^ next_parity_calc) && parity_enable;
          frame_error    <=  next_frame_error;
      end
  else
     begin
          shift_buffer   <=  shift_buffer;  
          parity_calc    <=  parity_calc;
          parity_samp    <=  parity_samp;
          frame_parity_error   <=  frame_parity_error;
          frame_error    <=  frame_error;
      end


   
generate

if(RX_FIFO == 0)
  begin



     
assign data_out  =  shift_buffer;
assign parity_error  =  frame_parity_error;
assign stop_error   =  frame_error;
assign data_avail    =  frame_avail ;

   

 

    
  end
else
  begin


 

wire       fifo_full;
wire       fifo_empty;
wire       fifo_over_run;
wire       fifo_under_run;
   
cde_fifo
#(.WIDTH(WIDTH+2),
  .SIZE(RX_FIFO_SIZE),
  .WORDS(RX_FIFO_WORDS)
)
 fifo 
(
     .clk       ( clk               ),
     .reset     ( reset             ),
     .push      ( last_cnt          ),
     .din       ( {next_frame_error, (next_parity_samp ^ next_parity_calc) && parity_enable ,next_shift_buffer} ),
     .pop       ( rcv_stb           ),
     .dout      ( { stop_error,  parity_error ,   data_out }        ),
     .full      ( fifo_full         ),
     .empty     ( fifo_empty        ), 
     .over_run  ( fifo_over_run     ),
     .under_run ( fifo_under_run    )
);

assign data_avail    = !fifo_empty ;



     
  end // else: !if(RX_FIFO == 0)

   endgenerate
   







   
endmodule



