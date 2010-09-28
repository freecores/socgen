


module ic_test_probe (signal,assert_value,drive_value,clk,tgen_out,probe_type );

parameter SIGNAL_NAME   = "undefined";
parameter SIGNAL_WIDTH  = 1;


output  [SIGNAL_WIDTH-1:0] signal;      
input   [SIGNAL_WIDTH-1:0] drive_value; 
input   [SIGNAL_WIDTH-1:0] assert_value;
input                      clk;
input                      tgen_out;
input    [1:0] 	           probe_type;   


wire  [SIGNAL_WIDTH-1:0]   signal;      

reg   [SIGNAL_WIDTH-1:0]   drive_latch;
reg   [SIGNAL_WIDTH-1:0]   test;
   
initial
begin
  drive_latch =  {SIGNAL_WIDTH{1'bz}};
  test        =  {SIGNAL_WIDTH{1'bz}};
end


   
always@(drive_value or tgen_out)
  if(tgen_out)  drive_latch = drive_value;
  else          drive_latch = drive_latch;

always@( probe_type or drive_value or tgen_out)
if(tgen_out)      test = drive_value;
else   
case(probe_type)
 2'b00:        test =  drive_latch;
 2'b01:        test = ~drive_latch;
 2'b10:        test = {SIGNAL_WIDTH{1'b0}};
 2'b11:        test = {SIGNAL_WIDTH{1'b1}};
endcase // case(probe_type)
   
 

assign       signal = test;
   


   
 
endmodule
      
