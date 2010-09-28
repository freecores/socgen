/**********************************************************************/
/*                                                                    */
/*             -------                                                */
/*            /   SOC  \                                              */
/*           /    GEN   \                                             */
/*          /     LIB    \                                            */
/*          ==============                                            */
/*          | cde_sync   |                                            */
/*          |____________|                                            */
/*                                                                    */
/*  Generic model for a metastable filter with async reset            */
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



module cde_sync_with_reset 
#( parameter  WIDTH   = 1,
   parameter  DEPTH   = 2,
   parameter  RST_VAL = 1'b0
 )

(

input wire                clk,
input wire                reset_n,

input  wire [WIDTH - 1:0] data_in,
output wire [WIDTH - 1:0] data_out
  

);


reg [WIDTH - 1:0] sync_data [DEPTH:0]; 


always @(*)
  begin
    sync_data[0] = data_in;
  end
  


integer i;
always @(posedge clk or negedge reset_n) 
  if (~reset_n)
     for (i = 1 ; i <= DEPTH ; i = i + 1)        sync_data[i] <= RST_VAL;   
  else
     for (i = 1 ; i <= DEPTH ; i = i + 1)        sync_data[i] <= sync_data[i-1];    


   
assign data_out = sync_data[DEPTH];

endmodule

