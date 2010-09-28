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
/*  Generic model for a syncronous read/write memory with seperate    */
/*  read and write ports.                                             */
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




module cde_sram #(
    parameter ADDR        = 10,                // Bits in addr
    parameter WIDTH       = 8,                 // Bits in data
    parameter WORDS       = 1024,              // Number of words
    parameter WRITETHRU   = 0,                 // 0 reads old data on same read/write, 1 reads new data
    parameter DEFAULT     = {WIDTH{1'b1}},     // Output when not reading
    parameter INIT_FILE   = "NONE"             // 

  )  (
  input  wire               clk,
  input  wire               cs,      
  input  wire   [ADDR-1:0]  waddr,
  input  wire   [ADDR-1:0]  raddr,
  input  wire               wr,
  input  wire               rd,
  input  wire   [WIDTH-1:0] wdata,      
  output  reg   [WIDTH-1:0] rdata
  );
			
reg [WIDTH-1:0] mem[0:WORDS-1];

// If used as Rom then load a memory image at startup
initial 
  begin
   if( INIT_FILE == "NONE")
     begin
     end
   else 	$readmemh(INIT_FILE, mem);
  end

`ifndef SYNTHESIS
 
// Function to access GPRs (for use by Verilator). No need to hide this one
// from the simulator, since it has an input (as required by IEEE 1364-2001).
function [31:0] get_gpr;
// verilator public
      input [ADDR-1:0] 		gpr_no;
      get_gpr = mem[gpr_no];
      
endfunction // get_gpr
   
`endif

// Write function   
always@(posedge clk)
        if( wr && cs ) mem[waddr[ADDR-1:0]] <= wdata[WIDTH-1:0];


generate

if( WRITETHRU) 

  begin
  // Read function gets new data if also a write cycle
  // latch the read addr for next cycle   
  reg   [ADDR-1:0]          l_raddr;  
  always@(posedge clk)      l_raddr    <= raddr;   

  // Read into a wire and then pass to rdata because some synth tools can't handle a memory in a always block

  wire  [WIDTH-1:0] tmp_rdata;
      
  assign                    tmp_rdata  =      (rd && cs )?mem[{l_raddr[ADDR-1:0]}]:DEFAULT;

  always@(*)                rdata  =      tmp_rdata;   

  end
else
  begin 
  // Read function gets old data if also a write cycle
  always@(posedge clk)
        if( rd && cs ) rdata             <= mem[{raddr[ADDR-1:0]}];
        else           rdata             <= DEFAULT;
  end		   

endgenerate

   
endmodule













