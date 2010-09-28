/////////////////////////////////////////////////////////////////////
////                                                             ////
////  Mini-RISC-1                                                ////
////  ALU                                                        ////
////                                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
////                                                             ////
////  D/L from: http://www.opencores.org/cores/minirisc/         ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000-2002 Rudolf Usselmann                    ////
////                         www.asics.ws                        ////
////                         rudi@asics.ws                       ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////


`include "defines.v"

module 
`VARIANT`ALU
 (
input  wire  [7:0]	s1,
input  wire  [7:0]	s2,
input  wire  [7:0]	mask,

input  wire  [3:0]	op,
input  wire     	c_in,

output  reg  [7:0]	out,
output wire 		c, 
output wire             dc,
output wire             z
  );

   



   
parameter	ALU_ADD		= 4'h0,
		ALU_SUB 	= 4'h1,
		ALU_INC 	= 4'h2,
		ALU_DEC 	= 4'h3,
		ALU_AND 	= 4'h4,
		ALU_CLR 	= 4'h5,
		ALU_NOT 	= 4'h6,
		ALU_IOR 	= 4'h7,
		ALU_MOV 	= 4'h8,
		ALU_MOVW	= 4'h9,
		ALU_RLF 	= 4'ha,
		ALU_RRF 	= 4'hb,
		ALU_SWP 	= 4'hc,
		ALU_XOR 	= 4'hd,
		ALU_BCF 	= 4'he,
		ALU_BSF 	= 4'hf;


wire		co, bo;
wire [5:0]	tmp_add;
wire		borrow_dc;
wire [7:0]	add_sub_out;
wire 		add_sub_sel;
wire [7:0]	s2_a;




always @(*)
   begin
	  case(op)	// synopsys full_case parallel_case
	   ALU_ADD:	out  = s1 + s2;
	   ALU_AND:	out  = s1 & s2;
	   ALU_CLR:	out  = 8'h00;
	   ALU_NOT:	out  = ~s1;
	   ALU_DEC:	out  = s1 - 1;
	   ALU_INC:	out  = s1 + 1;
	   ALU_IOR:	out  = s1 | s2;
	   ALU_MOV:	out  = s1;
	   ALU_MOVW:	out  = s2;
	   ALU_RLF:	out  = {s1[7:0], c_in};
	   ALU_RRF:	out  = {s1[0], c_in, s1[7:1]};
	   ALU_SUB:	out  = s1 - s2;
	   ALU_SWP:	out  = {s1[3:0], s1[7:4]};
	   ALU_XOR:	out  = s1 ^ s2;
	   ALU_BCF:	out  = s1 & ~mask;
	   ALU_BSF:	out  = s1 | mask;
	  endcase
   end

assign	add_sub_sel = (op[3:2]==2'b0);
assign  s2_a = op[1] ? 8'h01 : s2;
assign	{co, add_sub_out} = op[0] ? (s1 - s2_a) : (s1 + s2_a);

   
// C bit generation
assign c = add_sub_sel ? co : op[0] ? s1[0] : s1[7];

// Z Bit generation
assign z = (out==8'h0);

// DC Bit geberation
// This section is really bad, but not in the critical path,
// so I leave it alone for now ....
assign borrow_dc = s1[3:0] >= s2[3:0];
assign tmp_add = s1[3:0] + s2[3:0];
assign dc = (op==ALU_SUB) ? borrow_dc : tmp_add[4];

endmodule
