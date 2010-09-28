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
/*  io_probe for handling timing delays in dut                         */
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


module io_probe 
#(parameter MESG         = " ",
  parameter WIDTH        = 1,
  parameter RESET        = {WIDTH{1'bz}},
  parameter IN_DELAY     = 5,
  parameter OUT_DELAY    = 15,
  parameter OUT_WIDTH    = 10
  )
(
input  wire                       clk,

input  wire  [WIDTH-1:0]          drive_value, 
input  wire  [WIDTH-1:0]          expected_value,
input  wire  [WIDTH-1:0]          mask,



inout  wire  [WIDTH-1:0]          signal

 
);      


reg   [WIDTH-1:0]          filtered_value;
reg   [WIDTH:1]            fail;

reg 			dvr_tgen;
reg 			rcv_tgen;


initial
  begin
  dvr_tgen = 1'b0;
  rcv_tgen = 1'b0;
  end


always@(posedge clk  )      dvr_tgen  = #IN_DELAY  1'b1;
always@(posedge dvr_tgen )  dvr_tgen  = #10     1'b0;


always@(posedge clk  )      rcv_tgen  = #OUT_DELAY  1'b1;
always@(posedge rcv_tgen )  rcv_tgen  = #OUT_WIDTH  1'b0;   






   
reg   [WIDTH-1:0]          drive_latch;
   
initial
begin
  drive_latch =  RESET;
end

   
   
   
always@(*)
  if(dvr_tgen)      drive_latch = drive_value;
  else              drive_latch = drive_latch;



   
 assign         signal = drive_latch;
   


   
 
   
always@(*)
  if(rcv_tgen)      filtered_value = signal;
  else              filtered_value = filtered_value;



wire [WIDTH:1] tst_fail; 

assign tst_fail = {WIDTH{rcv_tgen}} &  mask & (signal^ expected_value);



generate
   
genvar i;

  for (i = 1 ; i <= WIDTH ; i = i + 1) 
  begin : dummy   
   
  always @(posedge clk or posedge tst_fail[i]) 
  if ( tst_fail[i]  )   fail[i] <= 1'b1;   
  else                  fail[i] <= 1'b0;      

  end
   

endgenerate

   





   initial
  begin
    cg.next(3);
    while(1)
      begin
      if(fail !== {WIDTH{1'b0}})        
           begin
           $display("%t %m              value %x   failure on bit(s)  %b",$realtime,filtered_value,fail );
           cg.fail(MESG);
           end
      cg.next(1);
      end // while (1)
  end // initial begin

   
 
endmodule
      


