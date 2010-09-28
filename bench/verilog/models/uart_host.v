
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
/*  uart host model for simulations                                   */
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



module uart_host (
input  wire           clk,
input  wire           reset, 
output reg            parity_enable,
output  reg           txd_parity,          
output  reg           txd_force_parity,    
output  reg [7:0]     txd_data_in,         
input  wire           txd_buffer_empty,    
output  reg           txd_load,            
output  reg           txd_break,           
output  reg           rxd_parity,          
output  reg           rxd_force_parity,    
output  reg           rxd_data_avail_stb,    
inout  wire [7:0]     rxd_data_out,        
input  wire           rxd_data_avail,     
inout  wire           rxd_stop_error,      
inout  wire           rxd_parity_error    
);

reg exp_rxd_stop_error;
reg exp_rxd_parity_error;
reg [7:0] exp_rxd_data_out;   

reg mask_rxd_stop_error;
reg mask_rxd_parity_error;
reg [7:0] mask_rxd_data_out;   

   

   
   
task automatic next;
  input [31:0] num;
  repeat (num)       @ (posedge clk);       
endtask


   
always@(posedge clk)
if(reset)   
  begin
  parity_enable        <= 1'b0;    
  txd_data_in          <= 8'h00;
  txd_parity           <= 1'b0;
  txd_force_parity     <= 1'b0;
  txd_load             <= 1'b0;
  txd_break            <= 1'b0;
  rxd_parity           <= 1'b0;
  rxd_force_parity     <= 1'b0;
  rxd_data_avail_stb   <= 1'b0;
  exp_rxd_stop_error   <= 1'b0;
  exp_rxd_parity_error <= 1'b0;
  exp_rxd_data_out     <= 8'h00;

  mask_rxd_stop_error   <= 1'b0;
  mask_rxd_parity_error <= 1'b0;
  mask_rxd_data_out     <= 8'h00;     

     
 end


task clear_rx_host;
 begin
 next(1);
 end
endtask
   


 
task send_byte;
  input [7:0] byte_out;

   begin
   while(!txd_buffer_empty)   next(1);
   $display("%t %m         %2h",$realtime ,byte_out);
   txd_data_in  <= byte_out;
   next(1);
   txd_load   <= 1'b1;
   next(1);
   txd_load   <= 1'b0;
   next(1);
   end
endtask // send_byte



task rcv_byte;
  input [7:0] byte_in;
   begin
   exp_rxd_data_out     <= byte_in;
   while(!rxd_data_avail)  next(1);
   $display("%t %m checking %h",$realtime,byte_in); 
   mask_rxd_stop_error   <= 1'b1;
   mask_rxd_parity_error <= 1'b1;
   mask_rxd_data_out     <= 8'hff;     
   next(1);
   mask_rxd_stop_error   <= 1'b0;
   mask_rxd_parity_error <= 1'b0;
   mask_rxd_data_out     <= 8'h00;     
   rxd_data_avail_stb   <= 1'b1;
   next(1);
   rxd_data_avail_stb   <= 1'b0;
   next(1);            
end
endtask
   

io_probe 
#(.MESG("uart_host receive error"),
  .WIDTH(8))
rxd_data_out_prb
(
       .clk            ( clk               ),
       .drive_value    (8'bzzzzzzzz        ), 
       .expected_value ( exp_rxd_data_out  ),
       .mask           ( mask_rxd_data_out ),
       .signal         ( rxd_data_out      )

 
);      

   
   



io_probe 
#(.MESG("uart_host stop error"))
rxd_stop_error_prb
(
       .clk            ( clk                 ),
       .drive_value    (1'bz                 ), 
       .expected_value ( exp_rxd_stop_error  ),
       .mask           ( mask_rxd_stop_error ),
       .signal         ( rxd_stop_error      )

 
);      




io_probe 
#(.MESG("uart_host parity error"))
rxd_parity_error_prb
(
       .clk            ( clk                 ),
       .drive_value    (1'bz                 ), 
       .expected_value ( exp_rxd_parity_error  ),
       .mask           ( mask_rxd_parity_error ),
       .signal         ( rxd_parity_error      )

 
);      

   
   


   
    
endmodule
      
