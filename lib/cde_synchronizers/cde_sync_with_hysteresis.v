/**********************************************************************/
/*                                                                    */
/*             -------                                                */
/*            /   SOC  \                                              */
/*           /    GEN   \                                             */
/*          /     LIB    \                                            */
/*          ==============                                            */
/*          | cde_sync   |                                            */
/*          |____________|                                            */
/*                                                                    */
/*  Generic model for a debounce filter with hysteresis               */
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



module cde_sync_with_hysteresis 
#( parameter  WIDTH      = 1,
   parameter  DEBOUNCE   = 4,
   parameter  DEBOUNCE_DELAY =  4'b1111
 )

(

input wire                clk,
input wire                reset,

input  wire [WIDTH - 1:0] data_in,
output reg  [WIDTH - 1:0] data_out,

output reg  [WIDTH - 1:0] data_rise, 
output reg  [WIDTH - 1:0] data_fall

  

);


reg [WIDTH - 1:0]         hysteresis_data; 
reg [WIDTH - 1:0]         clean_data; 
reg [DEBOUNCE-1:0]        debounce_counter;

always@(posedge clk ) 
  if(reset)  
     begin
     data_out  <= data_in;
     data_rise <= {WIDTH{1'b0}};
     data_fall <= {WIDTH{1'b0}};
     end
  else
     begin
     data_out  <= clean_data;
     data_rise <= clean_data &( data_out  ^ clean_data);
     data_fall <= data_out   &( data_out  ^ clean_data);
     end



   




always@(posedge clk ) 
       if(reset)
	 begin
	    clean_data             <= data_in;
            hysteresis_data        <= data_in;
            debounce_counter       <= {DEBOUNCE{1'b0}};
         end
       else
         begin
         // if the current input data differs from hysteresis 
         // then reset counter and update hysteresie
         
         if(data_in != hysteresis_data )
	      begin 
	      clean_data           <= clean_data;
              hysteresis_data      <= data_in;
              debounce_counter     <= {DEBOUNCE{1'b0}};
	      end
        // if counter reaches DEBOUNCE_DELAY then the signal is clean
         else 
         if(debounce_counter == DEBOUNCE_DELAY)
	      begin
              clean_data           <= hysteresis_data;
	      hysteresis_data      <= hysteresis_data; 
              debounce_counter     <= debounce_counter;
              end		 
           // data_in did not change but counter did not reach limit. Increment counter
         else
	      begin
              clean_data           <= clean_data;
	      hysteresis_data      <= hysteresis_data; 
              debounce_counter     <= debounce_counter+1;		 
              end 
         end 
   





   

endmodule

