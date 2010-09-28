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
/*  receive tester for timed output signals                           */
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


module timed_tester 
#(parameter WIDTH        = 1)
(
input  wire                       clk,
input  wire  [WIDTH-1:0]          expected_value,
input  wire  [WIDTH-1:0]          mask,
input  wire                       tgen,
input  wire  [WIDTH-1:0]          signal,

output reg   [WIDTH-1:0]          filtered_value,
output reg   [WIDTH:1]            fail
 
);      


 
   
always@(*)
  if(tgen)      filtered_value = signal;
  else          filtered_value = filtered_value;



wire [WIDTH:1] tst_fail; 

assign tst_fail = {WIDTH{tgen}} &  mask & (signal^ expected_value);



generate
   
genvar i;

  for (i = 1 ; i <= WIDTH ; i = i + 1) 
  begin : dummy   
   
  always @(posedge clk or posedge tst_fail[i]) 
  if ( tst_fail[i]  )   fail[i] <= 1'b1;   
  else                  fail[i] <= 1'b0;      

  end
   

endgenerate

   


   
 
endmodule
      
