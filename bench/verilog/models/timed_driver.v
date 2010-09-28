

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
/*  source driver for timed input signals                             */
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


module timed_driver 
#(parameter WIDTH        = 1,
  parameter PROBE_TYPE   = 2'b00,
  parameter RESET        = 1'b0)
(
input  wire                       clk,
input  wire  [WIDTH-1:0]   drive_value, 
input  wire                       tgen,
output wire  [WIDTH-1:0]   signal
);      


reg   [WIDTH-1:0]          drive_latch;
reg   [WIDTH-1:0]          test;
   
initial
begin
  drive_latch =  RESET;
  test        =  RESET;
end

reg [1:0] probe_type;
   always@(posedge clk) probe_type <= PROBE_TYPE;
   
   
   
always@(drive_value or tgen)
  if(tgen)      drive_latch = drive_value;
  else          drive_latch = drive_latch;

always@( probe_type or drive_value or tgen)
if(tgen)        test = drive_value;
else   
case(probe_type)
 2'b00:        test =  drive_latch;
 2'b01:        test = ~drive_latch;
 2'b10:        test = {WIDTH{1'b0}};
 2'b11:        test = {WIDTH{1'b1}};
endcase // case(probe_type)
   
 assign       signal = test;
   


   
 
endmodule
      
