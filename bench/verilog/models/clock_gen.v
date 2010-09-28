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
/*  Clock and Reset generator for simulations                          */
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



module clock_gen 
#(parameter PERIOD=10,
  parameter TIMEOUT=0
 )
 (output reg  clk,
  output reg  reset
 );
   
reg 	      failed;
reg [31:0]   fail_count;
   

task automatic next;
  input [31:0] num;
  repeat (num)       @ (posedge clk);       
endtask // next



task reset_on;
  reset = 1;       
endtask // reset_on


task automatic fail;
  input [799:0] message;
  begin
  failed = 1;
  fail_count = fail_count+1;  
  $display("%t  Simulation FAILURE:  %s ",$realtime,message  ); 
  end
endtask   

   
task reset_off;
  begin
  reset = 0;
  end       
endtask // reset_off


task exit;
   begin
   if(failed)
     begin
     $display("%t  Sim over: ERROR    %d failures",$realtime ,fail_count );
     end
   else
     begin
     $display("%t  Sim over: PASSED",$realtime  );
     end // else: !if(failed)
     $dumpflush;
     $finish;		
   end
endtask   


initial
begin
clk=0;
reset=1;
failed=0;
fail_count =32'h00000000;
end

always 
#(PERIOD/2)  clk =     !clk;



initial
 begin
 if(TIMEOUT)
   begin
   next(TIMEOUT);
   $display("%t  Sim over :ERROR TIMEOUT",$realtime  );
   $finish;
   end
 
 end
   
   
endmodule



