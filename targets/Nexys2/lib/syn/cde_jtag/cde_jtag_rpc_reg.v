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
/*  jtag reduced pin count register with update clock                 */
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
cde_jtag_rpc_reg 
#(parameter BITS = 16,           // number of bits in the register (2 or more)
  parameter RESET_VALUE = 'h0      // reset value of register
)
(
   
input  wire             clk,                   // clock input
input  wire             reset,                 // async reset
input  wire             tdi,                   // scan-in of jtag_register
input  wire             select,                // '1' when jtag accessing this register 
output wire             tdo,                   // scan-out of jtag register
input  wire             update_dr,             // clock input
input  wire             capture_dr,
input  wire             shift_dr,

output  reg  [BITS-1:0] update_value,          // the update register 
input  wire  [BITS-1:0] capture_value          // value to latch on a capture_dr

 );
   
// shift  buffer and shadow
reg [BITS-1:0]  buffer;

always @(posedge clk or posedge reset)
  if (reset)                            buffer <= RESET_VALUE;
  else 
  if (select && capture_dr)             buffer <= capture_value;
  else 
  if (select && shift_dr)               buffer <= { tdi, buffer[BITS-1:1] };
  else                                  buffer <= buffer;




  always @(posedge update_dr  or posedge reset)
   if (reset)                          update_value <= RESET_VALUE;
   else 
   if (select)                         update_value <= buffer;
   else                                update_value <= update_value;

  


assign tdo = buffer[0];



endmodule
