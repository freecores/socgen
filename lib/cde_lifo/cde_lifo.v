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
/*  Generic model for a lifo                                          */
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
cde_lifo
#(parameter WIDTH = 8,
  parameter SIZE  = 2,   // DEPTH = 2 ^ SIZE
  parameter WORDS = 4
)
  
(
input  wire	        	clk,
input  wire	        	reset,
input  wire       		push,
input  wire	[WIDTH-1:0]	din,
input  wire	        	pop,
output wire	[WIDTH-1:0]	dout

);



reg [SIZE-1:0] 	 push_pointer;
reg [SIZE-1:0] 	 pop_pointer;



   
always@(posedge clk)
  if(reset)
                          push_pointer <= {SIZE{1'b0}}; 
  else
    if( push && ~pop)     push_pointer <= push_pointer +  1;
  else
    if(~push &&  pop)     push_pointer <= push_pointer -  1;
  else
                          push_pointer <= push_pointer;




always@(posedge clk)
  if(reset)
                          pop_pointer <= {SIZE{1'b1}}; 
  else
    if( push && ~pop)     pop_pointer <= pop_pointer + 1;
  else
    if(~push &&  pop)     pop_pointer <= pop_pointer - 1;
  else
                          pop_pointer <= pop_pointer;

   



   



cde_sram
  #(.ADDR (SIZE),
    .WIDTH (WIDTH),
    .WORDS (WORDS)
   )
fifo
   (
   .clk       ( clk          ),
   .cs        ( 1'b1         ),      
   .waddr     ( push_pointer ),
   .raddr     ( pop_pointer  ),
   .wr        ( push         ),
   .rd        ( 1'b1         ),
   .wdata     ( din          ),
   .rdata     ( dout         )
    );
   

   

endmodule
