
`include "defines.v"

module 
`VARIANT

(


 
input wire [7:0] alu_op_a,
input wire [7:0] alu_op_b,
input wire       alu_op_c,

input wire       alu_op_b_inv,
 
 
output reg [7:0]   result,
output reg       r_result,
output reg       c_result,
output reg       v_result,

output reg [7:0]   and_out,
output reg [7:0]   orr_out,
output reg [7:0]   eor_out,
 

output reg [8:0]   a_sh_left,
output reg [8:0]   a_sh_right,
output reg [8:0]   b_sh_left,
output reg [8:0]   b_sh_right


 
);


reg [8:0] alu_op_b_mod;

always@(*)
  begin
  alu_op_b_mod  =    alu_op_b_inv  ? ~alu_op_b  : alu_op_b;
  end 
   

always@(*)
  begin

  c_result      =    alu_op_b_inv  ? !r_result  : r_result;  
  v_result      =  ((alu_op_a[7] == alu_op_b[7]) && (alu_op_a[7] != result[7]));
  end 
   

   
always @ (*) 
        begin
          {r_result,result[7:0]} =  alu_op_a + alu_op_b_mod + alu_op_c;
       end


always @ (*) 
           begin
           a_sh_left   = {alu_op_a, alu_op_c};
           a_sh_right  = {alu_op_a[0],alu_op_c, alu_op_a[7:1]};	      
           b_sh_left   = {alu_op_b, alu_op_c};
           b_sh_right  = {alu_op_b[0],alu_op_c, alu_op_b[7:1]};
           and_out     =  alu_op_a & alu_op_b;
           orr_out     =  alu_op_a | alu_op_b;
           eor_out     =  alu_op_a ^ alu_op_b;
           end


endmodule
