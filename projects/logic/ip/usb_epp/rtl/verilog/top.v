/**********************************************************************/
/*                                                                    */
/*             -------                                                */
/*            /   SOC  \                                              */
/*           /    GEN   \                                             */
/*          /  COMPONENT \                                            */
/*          ==============                                            */
/*          |            |                                            */
/*          |____________|                                            */
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


// usb  controller for digilent Basys fpga board


`include "defines.v"

module  
`VARIANT 
(
input wire               clk,
input wire               reset,

input    wire        eppastb_in,   
input    wire        eppdstb_in,
input    wire        usbflag_in,
input    wire        eppwait_out,      
input    wire        eppwait_in,      
input    wire        eppwait_oe,
input    wire        usbwr_out,
input    wire        usbwr_oe,
input    wire        usbwr_in,
input    wire        usbmode_out,
input    wire        usbmode_oe,
input    wire        usbmode_in,
input    wire        usboe_out,
input    wire        usboe_oe,
input    wire        usboe_in,
input    wire  [1:0] usbadr_out,
input    wire        usbadr_oe,
input    wire  [1:0] usbadr_in,
input    wire        usbpktend_out,
input    wire        usbpktend_oe,
input    wire        usbpktend_in,
input    wire        usbdir_out,
input    wire        usbdir_oe,
input    wire        usbdir_in,
input    wire [7:0]  eppdb_in,
input    wire [7:0]  eppdb_out,
input    wire        eppdb_oe,
input    wire        eppwr_in,
input    wire        usbclk_out,
input    wire        usbclk_oe,
input    wire        usbclk_in,
input    wire        usbrdy_in


 
		  );

   
 
 	 
endmodule