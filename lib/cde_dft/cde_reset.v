/**********************************************************************/
/*                                                                    */
/*             -------                                                */
/*            /   SOC  \                                              */
/*           /    GEN   \                                             */
/*          /     LIB    \                                            */
/*          ==============                                            */
/*          |            |                                            */
/*          |____________|                                            */
/*                                                                    */
/*  Generic model for a synchronous reset tree                        */
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


module 
cde_reset 
#(parameter  WIDTH = 1,  // width of reset bus
  parameter  DEPTH = 1   // depth of synchronizer
 )(

   input  clk,
   input  async_reset_n,            
   input  atg_asyncdisable,         
   input  [WIDTH - 1:0] sync_reset,               // signals to control resets

   output [WIDTH - 1:0] reset_n_out,              // Async reset
   output [WIDTH - 1:0] reset_out                 // Sync reset

   
);

// ****************************************************************************
// Reg declarations
// ****************************************************************************


wire  [WIDTH - 1:0]   reset_synced;


  cde_sync_with_reset 
  #(.WIDTH  (WIDTH),
    .DEPTH  (DEPTH),
    .RST_VAL({WIDTH{1'b1}})
   ) 
  cde_1(
    .clk                 (clk),
    .reset_n             (async_reset_n),
    .data_in             (sync_reset),
    .data_out            (reset_synced)
       );
   

  cde_asyncdisable 
   #(.WIDTH(WIDTH)) 
  cde_2(
    .reset               (1'b0),
    .reset_n             (async_reset_n),
    .atg_asyncdisable    (atg_asyncdisable),
    .sync_reset          (reset_synced),
    .reset_n_out         (reset_n_out),
    .reset_out           (reset_out)
     );


   
endmodule

