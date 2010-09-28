
/**********************************************************************/
/*                                                                    */
/*             -------                                                */
/*            /   SOC  \                                              */
/*           /    GEN   \                                             */
/*          /     SIM    \                                            */
/*          ==============                                            */
/*          |            |                                            */
/*          |____________|                                            */
/*                                                                    */
/*  ps2 host model  for simulations                                   */
/*                                                                    */
/*                                                                    */
/*  Author(s):                                                        */
/*      - John Eaton, jt_eaton@opencores.org                          */
/*                                                                    */
/**********************************************************************/
/*                                                                    */
/*    Copyright (C) <2010>  <Ouabache Design Works>                   */
/*                                                                    */
/*  This source file may be used and distributed without              */
/*  restriction provided that this copyright statement is not         */
/*  removed from the file and that any derivative work contains       */
/*  the original copyright notice and the associated disclaimer.      */
/*                                                                    */
/*  This source file is free software; you can redistribute it        */
/*  and/or modify it under the terms of the GNU Lesser General        */
/*  Public License as published by the Free Software Foundation;      */
/*  either version 2.1 of the License, or (at your option) any        */
/*  later version.                                                    */
/*                                                                    */
/*  This source is distributed in the hope that it will be            */
/*  useful, but WITHOUT ANY WARRANTY; without even the implied        */
/*  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR           */
/*  PURPOSE.  See the GNU Lesser General Public License for more      */
/*  details.                                                          */
/*                                                                    */
/*  You should have received a copy of the GNU Lesser General         */
/*  Public License along with this source; if not, download it        */
/*  from http://www.opencores.org/lgpl.shtml                          */
/*                                                                    */
/**********************************************************************/



module ps2_host 

(
input  wire         clk,
input  wire         reset, 
input  wire         busy,

inout  wire [7:0]   rx_data,               
input  wire         rx_read,               
input  wire         rx_full,               
input  wire         rx_parity_error,       
input  wire         rx_parity_rcv,         
input  wire         rx_parity_cal,         
input  wire         rx_frame_error,        
inout  wire         tx_ack_error,          

output  reg         rx_clr,           
output reg [7:0]    tx_data,               
output reg          tx_write 
);


reg                 exp_tx_ack_err;
reg                 mask_tx_ack_err;

reg   [7:0]         exp_rcv_byte;
reg   [7:0]         mask_rcv_byte;
   
   
task automatic next;
  input [31:0] num;
  repeat (num)       @ (posedge clk);       
endtask


   
always@(posedge clk)
  if(reset)
    begin
    tx_data              <= 8'h00;
    tx_write             <= 1'b0;
    rx_clr               <= 1'b0;
    exp_tx_ack_err       <= 1'b0;
    mask_tx_ack_err      <= 1'b0;
    exp_rcv_byte         <= 8'h00;
    mask_rcv_byte        <= 8'h00;


       
 end


task clear_rx_host;
 begin
 rx_clr               <= 1'b1;
 next(1);
 rx_clr               <= 1'b0;
 end
endtask
   


 
task send_byte;
  input [7:0] byte_out;
   begin
   $display("%t %m %2h",$realtime ,byte_out  );
   tx_data  <= byte_out;
   next(1);
   tx_write   <= 1'b1;
   next(1);
   tx_write   <= 1'b0;
   next(1);
   while(busy)   next(1);
   mask_tx_ack_err <= 1'b1;
   next(1);
   mask_tx_ack_err <= 1'b0;
   end
endtask // send_byte



   
io_probe 
#(  .MESG("ps2_host tx_ack error")
 )
tx_ack_err_tpb
(
          .clk             ( clk             ),
          .drive_value     ( 1'bz            ), 
          .expected_value  ( exp_tx_ack_err  ),
          .mask            ( mask_tx_ack_err ),
          .signal          ( tx_ack_error    )
);      




   
task rcv_byte;
  input [7:0] byte_in;
   begin
   exp_rcv_byte  <= byte_in;
   
   while(!rx_read)  next(1);
   $display("%t           checking    %h",$realtime,byte_in);
   mask_rcv_byte <= 8'hff;      
   next(1);
   mask_rcv_byte <= 8'h00;         
end
endtask
   

   
   
io_probe 
#(  .MESG("ps2_host receive error"),
    .WIDTH        (8)
 )
rcv_byte_tpb
(
          .clk             ( clk           ),
          .drive_value     ( {8{1'bz}}     ), 
          .expected_value  ( exp_rcv_byte  ),
          .mask            ( mask_rcv_byte ),
          .signal          ( rx_data       )
);      


   
    
endmodule
      
