/**********************************************************************/
/*                                                                    */
/*             -------                                                */
/*            /   SOC  \                                              */
/*           /    GEN   \                                             */
/*          /   TARGET   \                                            */
/*          ==============                                            */
/*          |            |                                            */
/*          |____________|                                            */
/*                                                                    */
/*  Clock_sys model for xilinx spartan 3e fpga                        */
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


module cde_clock_sys
#(parameter  FREQ = 48 ,  
  parameter  MULT =  4 ) 
(
input  wire  a_clk_pad_in,
input  wire  b_clk_pad_in,

input  wire  pwron_pad_in,
 
output wire  ckOut,
output wire  ckDivOut,
output  reg  one_usec,

output  reg  reset

);

reg 	[3:0]    reset_cnt;
reg     [6:0]    counter;


always@(posedge ckOut or negedge pwron_pad_in)
  if(!pwron_pad_in)     reset_cnt <= 4'b1111;
  else
  if(|reset_cnt)        reset_cnt <= reset_cnt - 4'b0001;
  else                  reset_cnt <= 4'b0000;
   



always@(posedge ckDivOut or negedge pwron_pad_in)
  if(!pwron_pad_in)     reset <= 1'b1;
  else                  reset <= (|reset_cnt);
   

   
DCM_SP #(
     .CLKDV_DIVIDE         (2.0),                          
     .CLKFX_DIVIDE         (1),            
     .CLKFX_MULTIPLY       (4),          
     .CLKIN_DIVIDE_BY_2    ("FALSE"), 
     .CLKIN_PERIOD         (20.5),         
     .CLKOUT_PHASE_SHIFT   ("NONE"), 
     .CLK_FEEDBACK         ("1X"),         
     .DESKEW_ADJUST        ("SYSTEM_SYNCHRONOUS"),              
     .DFS_FREQUENCY_MODE   ("LOW"),     
     .DLL_FREQUENCY_MODE   ("LOW"),     
     .DUTY_CYCLE_CORRECTION("TRUE"), 
     .PHASE_SHIFT          (0),              
     .STARTUP_WAIT         ("FALSE")        
) DCM_SP_inst    (
      .CLKFX     (),     
      .CLKFX180  (),     
      .PSDONE    (),     
      .STATUS    (),     
      .PSCLK     (1'b0), 
      .PSEN      (1'b0), 
      .PSINCDEC  (1'b0), 
      .CLK0      (),
      .CLK180    (),
      .CLK270    (),
      .CLK2X     (ckOut_pre), 
      .CLK2X180  (), 
      .CLK90     (),      
      .CLKDV     (ckDivOut),
      .LOCKED    (),        
      .CLKFB     (ckOut),   
      .CLKIN     (a_clk_pad_in), 
      .RST       (1'b0)  
   );


  BUFG 
  BUFG_inst (
            .O(ckOut),         // Clock buffer output
            .I(ckOut_pre)      // Clock buffer input
            );





   always@(posedge ckOut)
     if (counter == 7'b0000000) counter <= 7'b1011110;
     else                       counter <= counter -7'b0000001;

   always@(posedge ckOut)
     one_usec  <= (counter == 7'b0000000);
   
   
   


   
   
endmodule
