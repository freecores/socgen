/**********************************************************************/
/*                                                                    */
/*             -------                                                */
/*            /   SOC  \                                              */
/*           /    GEN   \                                             */
/*          /  COMPONENT \                                            */
/*          ==============                                            */
/*          |            |                                            */
/*          |____________|                                            */
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


// flash-psram controller for digilent Nexys/2 fpga board
// provides a synchronous 16 interface to the brd

`include "defines.v"

module
`VARIANT
#(parameter ADDR_BITS=24
 
)
   
   

(
 input wire                                clk,
 input wire                                reset,


 
 input wire  [ADDR_BITS-1:1]               addr,
 input wire  [15:0]                        wdata,
 input wire  [1:0]                         cs,
 input wire                                rd,
 input wire                                wr,
 input wire                                stb,
 input wire                                ub,
 input wire                                lb,
 output reg                                ack,
 output wire  [15:0]                       rdata,

 // connections to digilant board
 
 output reg  [ADDR_BITS-1:1]               memadr_out,   
 output reg  [15:0]                        memdb_out,
 output reg                                memdb_oe, 
 input wire  [15:0]                        memdb_in,

 output reg                                memoe_n_out,   
 output reg                                memwr_n_out,


 output reg                                ramadv_out_n,
 output reg                                ramclk_out,   
 output reg                                ramub_n_out,  
 output reg                                ramlb_n_out,  
 output reg                                ramcs_n_out,   
 output reg                                ramcre_out,   
 input  wire                               ramwait_in,
 
 output reg                                flashcs_n_out,
 output reg                                flashrp_n_out,

 input  wire                               flashststs_in
 );
   


   


   reg 					   del_rd;
   
   reg 	[1:0]				   del_wr;


   
   always@(posedge clk)
   if(!(stb))         del_wr  <= 2'b00;
   else		      del_wr  <= {del_wr[0],wr};
   

   always@(posedge clk)
   if(!(stb))         del_rd  <= 2'b00;
   else		      del_rd  <= rd;   

   
always@(*)     memadr_out       =  addr;
always@(*)     memdb_out        = wdata;
always@(*)     memdb_oe         = wr && (|cs);   

   
always@(posedge clk)
if(reset)
  begin
     ack             <= 1'b0; 
     ramadv_out_n    <= 1'b0; 
     ramcre_out      <= 1'b0;   
     flashcs_n_out   <= 1'b1;
     flashrp_n_out   <= 1'b1;
     ramclk_out      <= 1'b0;
  end

else

  begin
     ack             <= (del_wr[1] || del_rd) &&(|cs)  ;
     ramadv_out_n    <= 1'b0;
     ramcre_out      <= 1'b0;     
     ramclk_out      <= 1'b0;
     flashcs_n_out   <= !  cs[1];
     flashrp_n_out   <= flashrp_n_out;    
  end // else: !if(reset)




always@(posedge clk)
if(reset)
  begin
     memoe_n_out     <= 1'b1;   
     memwr_n_out     <= 1'b1;
     ramcs_n_out     <= 1'b1;  
     ramlb_n_out     <= 1'b1;  
     ramub_n_out     <= 1'b1;  
  end

else

  begin
     memoe_n_out     <= !(rd && (|cs));
     memwr_n_out     <= !(wr &&   ( del_wr== 'b00)  && (|cs) ) ;
     ramcs_n_out     <= ! cs[0];
     ramlb_n_out     <= !(lb && (|cs));
     ramub_n_out     <= !(ub && (|cs));
  end
   


assign   rdata =   memdb_in;
   



   
   
  

  endmodule