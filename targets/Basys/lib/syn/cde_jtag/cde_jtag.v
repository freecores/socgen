






/**********************************************************************/
/*                                                                    */
/*             -------                                                */
/*            /   SOC  \                                              */
/*           /    GEN   \                                             */
/*          /    TARGET  \                                            */
/*          ==============                                            */
/*          |            |                                            */
/*          |____________|                                            */
/*                                                                    */
/*  Jtag tap controller for xilinx spartan 3e fpga                    */
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

//////////////////////////////////////////////////////////////////////
//                                                                  //
// This file is a wrapper for the various Xilinx internal BSCAN     //
// TAP devices.  It is designed to take the place of a separate TAP //
// controller in Xilinx systems, to allow a user to access a CPU    //
// debug module (such as that of the OR1200) through the FPGA's     //
// dedicated JTAG / configuration port.                             //
//                                                                  //
//////////////////////////////////////////////////////////////////////
//

// Note that the SPARTAN BSCAN controllers have more than one channel.
// This implementation always uses channel 1, this is not configurable.
// If you want to use another channel, then it is probably because you
// want to attach multiple devices to the BSCAN device, which means
// you'll be making changes to this file anyway.


module cde_jtag  (
		 
input   wire  tdi_1,
input   wire  tdi_2,
output  wire  tck_1,
output  wire  tck_2,
output  wire  tdo_o,
output  wire  test_logic_reset_o,
output  wire  shift_dr_o,
output  wire  capture_dr_o,
output  wire  update_dr_o,
output  wire  select_1,
output  wire  select_2
	 
);

wire       update_dr_i;
   
   
BSCAN_SPARTAN3 
BSCAN_SPARTAN3_inst (
   .CAPTURE (capture_dr_o),       // CAPTURE output from TAP controller
   .DRCK1   (tck_1_i),            // Data register output for USER1 functions
   .DRCK2   (tck_2_i),            // Data register output for USER2 functions
   .RESET   (test_logic_reset_o), // Reset output from TAP controller
   .SEL1    (select_1),           // USER1 active output
   .SEL2    (select_2),           // USER2 active output
   .SHIFT   (shift_dr_o),         // SHIFT output from TAP controller
   .TDI     (tdo_o),              // TDI output from TAP controller
   .UPDATE  (update_dr_i),        // UPDATE output from TAP controller
   .TDO1    (tdi_1),              // Data input for USER1 function
   .TDO2    (tdi_2)               // Data input for USER2 function
);


BUFG 
update_buf (
   .O       (update_dr_o),        // Clock buffer output
   .I       (update_dr_i)         // Clock buffer input
            );


BUFG 
tck_1_buf (
   .O       (tck_1),              // Clock buffer output
   .I       (tck_1_i)             // Clock buffer input
            );


BUFG 
tck_2_buf (
   .O       (tck_2),              // Clock buffer output
   .I       (tck_2_i)             // Clock buffer input
            );







   

endmodule