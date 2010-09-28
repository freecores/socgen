
`include "defines.v"

module `VARIANT`CPU
#( parameter VEC_TABLE = 8'hff,
   parameter BOOT_VEC  = 8'hfc
)


(
    input  wire            clk,         
    input  wire            reset,        
    input  wire            enable,                   
    input  wire    [15:0]  mem_rdata,       // data that comes from the bus controller

    input  wire            nmi,
    input  wire    [7:0]   vec_int,

    input  wire    [15:0]  prog_data, 
    input  wire    [7:0]   pg0_data, 


 
    output wire    [7:0]   alu_status,
    output wire   [15:0]   prog_counter,   // program counter

 
    output wire    [7:0]   pg0_add,        
    output wire            pg0_rd,        
    output wire            pg0_wr,         


    output wire   [15:0]   mem_add,        // system bus address
    output wire            mem_rd,         // read  = 1
    output wire            mem_wr,         // write = 1
    output wire    [7:0]   mem_wdata,       // data that will be written somewhere else

    output wire            stk_push,
    output wire [15:0]     stk_push_data ,
    output wire            stk_pull,
    input  wire [15:0]     stk_pull_data




 
);

   



    wire    [7:0]   ir;                       // instruction register
    wire    [1:0]   length;                   // instruction length

    wire    [`STATE_SIZE:0]   state;          // current and next state registers

    wire    [2:0]   dest;
    wire    [2:0]   ctrl;

    wire   [7:0]   vector;     

    wire    [7:0]   operand  ;    
    wire    [7:0]   imm_data;     // 
    reg     [7:0]   index;         // will be assigned with either X or Y
    wire    [15:0]  offset;         
   
   wire 	    now_fetch_op;
   
    // wiring that simplifies the FSM logic by simplifying the addressing modes
    wire absolute;
    wire immediate;
    wire implied;
    wire indirectx;
    wire indirecty;
    wire relative;
    wire zero_page;
    wire stack;
 
    wire fetch_op;
  
   
    wire [1:0] ins_type; 
   
    wire jump;
    wire jump_indirect;

    // regs for the special instructions
    wire brk;
    wire rti;
    wire rts;
    wire jsr;

    wire invalid;
    wire core_reset;
   

    wire branch_inst;     // a simple reg that is asserted everytime a branch will be executed.            
    wire [7:0] brn_value;
    wire [7:0] brn_enable;
    wire [4:0] alu_status_update;

    wire [2:0]      alu_op_a_sel;
    wire [1:0]      alu_op_b_sel;
   
    wire 	    alu_op_b_inv;
    wire [1:0] 	    alu_op_c_sel;
    wire [2:0]      alu_mode;    
   
    wire [1:0] 	    idx_sel;

   
    wire    [7:0]   alu_result;    // result from alu operation


    wire    [7:0]   alu_a;         // alu accumulator
    wire    [7:0]   alu_x;         // alu x index register
    wire    [7:0]   alu_y;         // alu y index register

     reg    [7:0]   alu_op_b;

    wire            alu_enable;     // a flag that when high tells the alu when to perform the operations
    wire            alu_enable_s;     
					wire        Error;
   
    wire    [1:0]   cmd;
   
assign alu_enable =  ((alu_enable_s || implied || stack  ) && !((state == `INT_1)||  (state == `INT_2) )              );
   


`VARIANT`CONTROL
#( .BOOT_VEC (BOOT_VEC))
control(
   .clk               ( clk               ),
   .reset             ( reset             ), 
   .enable            ( enable            ),
   .state             ( state             ),
   .ir                ( ir                ),
   .nmi               ( nmi               ),
   .vec_int           ( vec_int           ),
   .invalid           ( invalid           ),
   .run_status        ( alu_status[5]     ), 
   .irq_status        ( alu_status[2]     ),
   .brk_status        ( alu_status[4]     ),
   .cmd               ( cmd               ),
   .ctrl              ( ctrl              ),
   .address           ( mem_add           ),
   .branch_inst       ( branch_inst       ),
   .vector            ( vector            ),
   .core_reset        ( core_reset        )
);


`VARIANT`STATE_FSM
state_fsm (
   .clk               ( clk               ),         
   .reset             ( core_reset        ),        
   .enable            ( enable            ),                   
   .cmd               ( cmd               ),
   .now_fetch_op      ( now_fetch_op      ),
   .run               ( alu_status[5]     ),
   .length            ( length            ),
   .immediate         ( immediate         ),
   .absolute          ( absolute          ),
   .stack             ( stack             ),
   .relative          ( relative          ), 
   .implied           ( implied           ),    	   
   .indirectx         ( indirectx         ),
   .indirecty         ( indirecty         ),
   .brk               ( brk               ),
   .rts               ( rts               ),
   .jump_indirect     ( jump_indirect     ),
   .jump              ( jump              ),
   .jsr               ( jsr               ),
   .rti               ( rti               ),
   .branch_inst       ( branch_inst       ),
   .ins_type          ( ins_type          ),
   .invalid           ( invalid           ),
   .state             ( state             )

);
   
`VARIANT`INST_DECODE
inst_decode (
   .clk               ( clk               ),         
   .reset             ( reset             ),        
   .enable            ( enable            ),
   .disable_ir        ((state == `INT_1) || (state == `INT_2) ),	     
   .now_fetch_op      ( now_fetch_op      ),                   
   .fetch_op          ( fetch_op          ),
   .state             ( state             ),
   .prog_data         ( prog_counter[0]? prog_data[15:8]:prog_data[7:0]),
	     
   .length            ( length            ),
   .ir                ( ir                ),          
   .absolute          ( absolute          ),
   .immediate         ( immediate         ),
   .implied           ( implied           ),
   .indirectx         ( indirectx         ),
   .indirecty         ( indirecty         ),
   .relative          ( relative          ),
   .zero_page         ( zero_page         ),
   .stack             ( stack             ),
   .jump              ( jump              ),
   .jump_indirect     ( jump_indirect     ),
   .brk               ( brk               ),
   .rti               ( rti               ),
   .rts               ( rts               ),
   .jsr               ( jsr               ),
   .ins_type          ( ins_type          ),
   .alu_mode          ( alu_mode          ),
   .alu_op_a_sel      ( alu_op_a_sel      ),
   .alu_op_b_sel      ( alu_op_b_sel      ),
   .alu_op_b_inv      ( alu_op_b_inv      ),
   .alu_op_c_sel      ( alu_op_c_sel      ),
   .idx_sel           ( idx_sel           ),
   .alu_status_update ( alu_status_update ),
   .brn_value         ( brn_value         ),
   .brn_enable        ( brn_enable        ),
   .dest              ( dest              ),
   .ctrl              ( ctrl              ),
   .invalid           ( invalid           )
 );
   

   reg 		    last_prg_cnt_0;

   always@(posedge clk )
      		    last_prg_cnt_0 <= prog_counter[0];

`VARIANT`SEQUENCER
#( .VEC_TABLE (VEC_TABLE))  
sequencer (
   .clk               ( clk               ),         
   .reset             ( reset             ),        
   .enable            ( enable            ),
   .now_fetch_op      ( now_fetch_op      ),
   .cmd               ( cmd               ),
   .state             ( state             ),
   .length            ( length            ),         
   .vector            ( vector            ),
   .alu_result        ( alu_result        ),    
   .alu_a             ( alu_a             ),    
   .alu_status        ( alu_status        ),    
   .alu_enable        ( alu_enable_s      ),
   .alu_op_a_sel      ( alu_op_a_sel      ),
   .pg0_data          ( pg0_data          ),
   .data_in           ( mem_add[0]? mem_rdata[15:8]: mem_rdata[7:0]),
   .prog_data16       ( prog_data         ),
   .index             ( index             ),	   
   .prog_data         ( last_prg_cnt_0? prog_data[15:8]:prog_data[7:0]),
   .implied           ( implied           ),
   .fetch_op          ( fetch_op          ),
   .immediate         ( immediate         ),  
   .relative          ( relative          ),
   .absolute          ( absolute          ),
   .zero_page         ( zero_page         ),
   .stack             ( stack             ),
   .indirectx         ( indirectx         ),
   .indirecty         ( indirecty         ),
   .jump_indirect     ( jump_indirect     ),
   .jump              ( jump              ),	   
   .jsr               ( jsr               ),
   .brk               ( brk               ),
   .rti               ( rti               ),
   .rts               ( rts               ),
   .branch_inst       ( branch_inst       ), 
   .ins_type          ( ins_type          ),
   .prog_counter      ( prog_counter      ),            
   .address           ( mem_add           ),       
   .operand           ( operand           ),     
   .imm_data          ( imm_data          ),     

   .pg0_add           ( pg0_add           ), 
   .pg0_rd            ( pg0_rd            ),        
   .pg0_wr            ( pg0_wr            ),         



   .mem_rd            ( mem_rd            ),
   .mem_wr            ( mem_wr            ),
   .data_out          ( mem_wdata         ),      
   .offset            ( offset            ),
   .stk_push          ( stk_push          ),
   .stk_push_data     ( stk_push_data     ),
   .stk_pull          ( stk_pull          ),
   .stk_pull_data     ( stk_pull_data     )


);
   

always@(*)

  case (idx_sel)
    `idx_sel_00:          index  = 8'h00;
    `idx_sel_x:           index  = alu_x;
    `idx_sel_y:           index  = alu_y;
     default:             index  = 8'bxxxxxxxx;
  endcase


reg [7:0] 	    mem_dat;
   
always@(*) mem_dat  = mem_add[0] ? mem_rdata[15:8] : mem_rdata[7:0];
   
   
always@(*)

  case (alu_op_b_sel)
    `alu_op_b_00:         alu_op_b  = 8'h00;
    `alu_op_b_imm:        alu_op_b  = imm_data;
    `alu_op_b_stk:        alu_op_b  = stk_pull_data[7:0];
    `alu_op_b_opnd:       alu_op_b  = mem_dat;
  endcase


`VARIANT`ALU  
alu (
    .clk                ( clk                 ),
    .reset              ( reset               ),
    .enable             ( enable              ),
    .alu_enable         ( alu_enable          ),
    .alu_result         ( alu_result          ),
    .alu_status         ( alu_status          ),
    .alu_op_b           ( alu_op_b            ),
    .psp_res            ( stk_pull_data[15:8] ),
    .alu_mode           ( alu_mode            ),
    .alu_op_a_sel       ( alu_op_a_sel        ),
    .alu_op_b_inv       ( alu_op_b_inv        ),
    .alu_op_c_sel       ( alu_op_c_sel        ),
    .alu_status_update  ( alu_status_update   ),
    .branch_inst        ( branch_inst         ),
    .relative           ( relative            ), 
    .dest               ( dest                ),         
    .brn_enable         ( brn_enable          ),
    .brn_value          ( brn_value           ),
    .alu_x              ( alu_x               ),
    .alu_y              ( alu_y               ),
    .alu_a              ( alu_a               )         
    );



`ifndef  SYNTHESIS
   
reg [7*8-1:0]  A_instr;
reg [10*8-1:0] A_state;
reg [3*8-1:0]  A_alu_mode;
reg [3*8-1:0]  A_alu_op_a_sel;
reg [3*8-1:0]  A_alu_op_b_inv;
reg [3*8-1:0]  A_alu_op_b_sel;
reg [3*8-1:0]  A_alu_op_c_sel;
reg [4*8-1:0]  A_alu_status_update;
reg [3*8-1:0]  A_dest;
reg [7*8-1:0]  A_ctrl;
reg [8*8-1:0]  A_cmd;
reg [5*8-1:0]  A_ins_type;
reg [3*8-1:0]  A_idx_sel;      
   
   
always @(*) begin
   case  (state)

      `FETCH_OP:     A_state = "FETCH_OP  ";
       `EXECUTE:     A_state = "EXECUTE   ";
         `EXE_1:     A_state = "EXE_1     ";
         `AXE_1:     A_state = "AXE_1     ";
         `AXE_2:     A_state = "AXE_2     ";     
         `IDX_1:     A_state = "IDX_1     ";
         `IDX_2:     A_state = "IDX_2     ";
         `IDX_3:     A_state = "IDX_3     ";
         `IDY_1:     A_state = "IDY_1     ";
         `IDY_2:     A_state = "IDY_2     ";
         `IDY_3:     A_state = "IDY_3     ";
         `RESET:     A_state = "RESET     ";
          `HALT:     A_state = "HALT      ";
         `INT_2:     A_state = "INT_2     ";
         `INT_1:     A_state = "INT_1     ";
        default:     A_state = "-XXXXXXXX-";                
   endcase    
end
   



   
always @(*) begin
   case  (ir)
     `ADC_IMM:
      begin
      A_instr = "ADC_IMM";
      end
 
     `ADC_ZPG:
      begin
      A_instr = "ADC_ZPG";
      end 

     `ADC_ZPX:
      begin
      A_instr = "ADC_ZPX";
      end 

     `ADC_ABS:
      begin
      A_instr = "ADC_ABS";
      end 

     `ADC_ABX:
      begin
      A_instr = "ADC_ABX";
      end 

     `ADC_ABY:
      begin
      A_instr = "ADC_ABY";
      end 
 
     `ADC_IDX:
      begin
      A_instr = "ADC_IDX";
      end 

     `ADC_IDY:
      begin
      A_instr = "ADC_IDY";
      end 

     `AND_IMM:
      begin
      A_instr = "AND_IMM";
      end 

     `AND_ZPG:
      begin
      A_instr = "AND_ZPG";
      end 

     `AND_ZPX:
      begin
      A_instr = "AND_ZPX";
      end 

     `AND_ABS:
      begin
      A_instr = "AND_ABS";
      end 

     `AND_ABX:
      begin
      A_instr = "AND_ABX";
      end 

     `AND_ABY:
      begin
      A_instr = "AND_ABY";
      end 

     `AND_IDX:
      begin
      A_instr = "AND_IDX";
      end 

     `AND_IDY:
      begin
      A_instr = "AND_IDY";
      end 

     `ASL_ACC:
      begin
      A_instr = "ASL_ACC";
      end 

     `ASL_ZPG:
      begin
      A_instr = "ASL_ZPG";
      end 

     `ASL_ZPX:
      begin
      A_instr = "ASL_ZPX";
      end 

     `ASL_ABS:
      begin
      A_instr = "ASL_ABS";
      end 

     `ASL_ABX:
      begin
      A_instr = "ASL_ABX";
      end 

     `BCC_REL:
      begin
      A_instr = "BCC_REL";
      end 

     `BCS_REL:
      begin
      A_instr = "BCS_REL";
      end 

     `BEQ_REL:
      begin
      A_instr = "BEQ_REL";
      end 

     `BIT_ZPG:
      begin
      A_instr = "BIT_ZPG";
      end 

     `BIT_ABS:
      begin
      A_instr = "BIT_ABS";
      end 

     `BMI_REL:
      begin
      A_instr = "BMI_REL";
      end 

     `BNE_REL:
      begin
      A_instr = "BNE_REL";
      end 

     `BPL_REL:
      begin
      A_instr = "BPL_REL";
      end 

     `BRK_IMP:
      begin
      A_instr = "BRK_IMP";
      end 

     `BVC_REL:
      begin
      A_instr = "BVC_REL";
      end 

     `BVS_REL:
      begin
      A_instr = "BVS_REL";
      end 

     `CLC_IMP:
      begin
      A_instr = "CLC_IMP";
      end 

     `CLD_IMP:
      begin
      A_instr = "CLD_IMP";
      end 

     `CLI_IMP:
      begin
      A_instr = "CLI_IMP";
      end 

     `CLV_IMP:
      begin
      A_instr = "CLV_IMP";
      end 

     `CMP_IMM:
      begin
      A_instr = "CMP_IMM";
      end 

     `CMP_ZPG:
      begin
      A_instr = "CMP_ZPG";
      end 

     `CMP_ZPX:
      begin
      A_instr = "CMP_ZPX";
      end 

     `CMP_ABS:
      begin
      A_instr = "CMP_ABS";
      end 

     `CMP_ABX:
      begin
      A_instr = "CMP_ABX";
      end 

     `CMP_ABY:
      begin
      A_instr = "CMP_ABY";
      end 

     `CMP_IDX:
      begin
      A_instr = "CMP_IDX";
      end 

     `CMP_IDY:
      begin
      A_instr = "CMP_IDY";
      end 

     `CPX_IMM:
      begin
      A_instr = "CPX_IMM";
      end 

     `CPX_ZPG:
      begin
      A_instr = "CPX_ZPG";
      end 

     `CPX_ABS:
      begin
      A_instr = "CPX_ABS";
      end 

     `CPY_IMM:
      begin
      A_instr = "CPY_IMM";
      end 

     `CPY_ZPG:
      begin
      A_instr = "CPY_ZPG";
      end 

     `CPY_ABS:
      begin
      A_instr = "CPY_ABS";
      end 

     `DEC_ZPG:
      begin
      A_instr = "DEC_ZPG";
      end


     `DEC_ZPX:
      begin
      A_instr = "DEC_ZPX";
      end 

     `DEC_ABS:
      begin
      A_instr = "DEC_ABS";
      end 

     `DEC_ABX:
      begin
      A_instr = "DEC_ABX";
      end 

     `DEX_IMP:
      begin
      A_instr = "DEX_IMP";
      end 

     `DEY_IMP:
      begin
      A_instr = "DEY_IMP";
      end 

     `EOR_IMM:
      begin
      A_instr = "EOR_IMM";
      end 

     `EOR_ZPG:
      begin
      A_instr = "EOR_ZPG";
      end 

     `EOR_ZPX:
      begin
      A_instr = "EOR_ZPX";
      end 

     `EOR_ABS:
      begin
      A_instr = "EOR_ABS";
      end 

     `EOR_ABX:
      begin
      A_instr = "EOR_ABX";
      end 

     `EOR_ABY:
      begin
      A_instr = "EOR_ABY";
      end 

     `EOR_IDX:
      begin
      A_instr = "EOR_IDX";
      end 

     `EOR_IDY:
      begin
      A_instr = "EOR_IDY";
      end 

     `INC_ZPG:
      begin
      A_instr = "INC_ZPG";
      end 

     `INC_ZPX:
      begin
      A_instr = "INC_ZPX";
      end 

     `INC_ABS:
      begin
      A_instr = "INC_ABS";
      end 

     `INC_ABX:
      begin
      A_instr = "INC_ABX";
      end 

     `INX_IMP:
      begin
      A_instr = "INX_IMP";
      end 

     `INY_IMP:
      begin
      A_instr = "INY_IMP";
      end 

     `JMP_ABS:
      begin
      A_instr = "JMP_ABS";
      end 

     `JMP_IND:
      begin
      A_instr = "JMP_IND";
      end 

     `JSR_ABS:
      begin
      A_instr = "JSR_ABS";
      end 

     `LDA_IMM:
      begin
      A_instr = "LDA_IMM";
      end 

     `LDA_ZPG:
      begin
      A_instr = "LDA_ZPG";
      end 

     `LDA_ZPX:
      begin
      A_instr = "LDA_ZPX";
      end 

     `LDA_ABS:
      begin
      A_instr = "LDA_ABS";
      end 

     `LDA_ABX:
      begin
      A_instr = "LDA_ABX";
      end 

     `LDA_ABY:
      begin
      A_instr = "LDA_ABY";
      end 

     `LDA_IDX:
      begin
      A_instr = "LDA_IDX";
      end 

     `LDA_IDY:
      begin
      A_instr = "LDA_IDY";
      end 

     `LDX_IMM:
      begin
      A_instr = "LDX_IMM";
      end 

     `LDX_ZPG:
      begin
      A_instr = "LDX_ZPG";
      end 

     `LDX_ZPY:
      begin
      A_instr = "LDX_ZPY";
      end 

     `LDX_ABS:
      begin
      A_instr = "LDX_ABS";
      end 

     `LDX_ABY:
      begin
      A_instr = "LDX_ABY";
      end 

     `LDY_IMM:
      begin
      A_instr = "LDY_IMM";
      end 

     `LDY_ZPG:
      begin
      A_instr = "LDY_ZPG";
      end 

     `LDY_ZPX:
      begin
      A_instr = "LDY_ZPX";
      end 

     `LDY_ABS:
      begin
      A_instr = "LDY_ABS";
      end 

     `LDY_ABX:
      begin
      A_instr = "LDY_ABX";
      end 

     `LSR_ACC:
      begin
      A_instr = "LSR_ACC";
      end 

     `LSR_ZPG:
      begin
      A_instr = "LSR_ZPG";
      end 

     `LSR_ZPX:
      begin
      A_instr = "LSR_ZPX";
      end 

     `LSR_ABS:
      begin
      A_instr = "LSR_ABS";
      end 

     `LSR_ABX:
      begin
      A_instr = "LSR_ABX";
      end 

     `NOP_IMP:
      begin
      A_instr = "NOP_IMP";
      end 

     `ORA_IMM:
      begin
      A_instr = "ORA_IMM";
      end 

     `ORA_ZPG:
      begin
      A_instr = "ORA_ZPG";
      end 

     `ORA_ZPX:
      begin
      A_instr = "ORA_ZPX";
      end 

     `ORA_ABS:
      begin
      A_instr = "ORA_ABS";
      end 

     `ORA_ABX:
      begin
      A_instr = "ORA_ABX";
      end 

     `ORA_ABY:
      begin
      A_instr = "ORA_ABY";
      end 

     `ORA_IDX:
      begin
      A_instr = "ORA_IDX";
      end 

     `ORA_IDY:
      begin
      A_instr = "ORA_IDY";
      end 

     `PHA_IMP:
      begin
      A_instr = "PHA_IMP";
      end 

     `PHP_IMP:
      begin
      A_instr = "PHP_IMP";
      end 

     `PLA_IMP:
      begin
      A_instr = "PLA_IMP";
      end 

     `PLP_IMP:
      begin
      A_instr = "PLP_IMP";
      end 

     `ROL_ACC:
      begin
      A_instr = "ROL_ACC";
      end 

     `ROL_ZPG:
      begin
      A_instr = "ROL_ZPG";
      end 

     `ROL_ZPX:
      begin
      A_instr = "ROL_ZPX";
      end 

     `ROL_ABS:
      begin
      A_instr = "ROL_ABS";
      end 

     `ROL_ABX:
      begin
      A_instr = "ROL_ABX";
      end 

     `ROR_ACC:
      begin
      A_instr = "ROR_ACC";
      end 

     `ROR_ZPG:
      begin
      A_instr = "ROR_ZPG";
      end 

     `ROR_ZPX:
      begin
      A_instr = "ROR_ZPX";
      end 

     `ROR_ABS:
      begin
      A_instr = "ROR_ABS";
      end 

     `ROR_ABX:
      begin
      A_instr = "ROR_ABX";
      end 

     `RTI_IMP:
      begin
      A_instr = "RTI_IMP";
      end 

     `RTS_IMP:
      begin
      A_instr = "RTS_IMP";
      end 

     `SBC_IMM:
      begin
      A_instr = "SBC_IMM";
      end 

     `SBC_ZPG:
      begin
      A_instr = "SBC_ZPG";
      end 

     `SBC_ZPX:
      begin
      A_instr = "SBC_ZPX";
      end 

     `SBC_ABS:
      begin
      A_instr = "SBC_ABS";
      end 

     `SBC_ABX:
      begin
      A_instr = "SBC_ABX";
      end 

     `SBC_ABY:
      begin
      A_instr = "SBC_ABY";
      end 

     `SBC_IDX:
      begin
      A_instr = "SBC_IDX";
      end 

     `SBC_IDY:
      begin
      A_instr = "SBC_IDY";
      end 

     `SEC_IMP:
      begin
      A_instr = "SEC_IMP";
      end 

     `SED_IMP:
      begin
      A_instr = "SED_IMP";
      end 

     `SEI_IMP:
      begin
      A_instr = "SEI_IMP";
      end 

     `STA_ZPG:
      begin
      A_instr = "STA_ZPG";
      end 

     `STA_ZPX:
      begin
      A_instr = "STA_ZPX";
      end 

     `STA_ABS:
      begin
      A_instr = "STA_ABS";
      end 

     `STA_ABX:
      begin
      A_instr = "STA_ABX";
      end 

     `STA_ABY:
      begin
      A_instr = "STA_ABY";
      end 

     `STA_IDX:
      begin
      A_instr = "STA_IDX";
      end 

     `STA_IDY:
      begin
      A_instr = "STA_IDY";
      end 

     `STX_ZPG:
      begin
      A_instr = "STX_ZPG";
      end 

     `STX_ZPY:
      begin
      A_instr = "STX_ZPY";
      end 

     `STX_ABS:
      begin
      A_instr = "STX_ABS";
      end 

     `STY_ZPG:
      begin
      A_instr = "STY_ZPG";
      end 

     `STY_ZPX:
      begin
      A_instr = "STY_ZPX";
      end 

     `STY_ABS:
      begin
      A_instr = "STY_ABS";
      end 

     `TAX_IMP:
      begin
      A_instr = "TAX_IMP";
      end 

     `TAY_IMP:
      begin
      A_instr = "TAY_IMP";
      end 

     `TXA_IMP:
      begin
      A_instr = "TXA_IMP";
      end 

     `TYA_IMP:
      begin
      A_instr = "TYA_IMP";
      end

      default:    A_instr = "XXX_XXX";
   endcase

end
   






   
always @(*) begin
   case  (alu_mode)
      `alu_mode_add:          begin    
                              A_alu_mode = "ADD";
                              end
      `alu_mode_and:          begin    
                              A_alu_mode = "AND";
                              end
      `alu_mode_orr:          begin    
                              A_alu_mode = "OR ";
                              end
      `alu_mode_eor:          begin    
                              A_alu_mode = "EOR";
                              end
      `alu_mode_sfl:          begin    
                              A_alu_mode = "SFL";
                              end
      `alu_mode_sfr:          begin    
                              A_alu_mode = "SFR";
                              end
     default:                begin
                              A_alu_mode = "XXX";
                              end
   endcase

end









   
   
// alu_op_a_sel


   
always @(*) begin
   case  (alu_op_a_sel)
      `alu_op_a_00:           begin    
                              A_alu_op_a_sel = "00 ";
                              end
      `alu_op_a_acc:          begin    
                              A_alu_op_a_sel = "ACC";
                              end
      `alu_op_a_x  :          begin    
                              A_alu_op_a_sel = " X ";
                              end
      `alu_op_a_y  :          begin    
                              A_alu_op_a_sel = " Y ";
                              end
      `alu_op_a_ff :          begin    
                              A_alu_op_a_sel = " FF ";
                              end
      `alu_op_a_psr:          begin    
                              A_alu_op_a_sel = "PSR";
                              end

      default:                begin
                              A_alu_op_a_sel = "XXX";
                              end
   endcase

end









   
// alu_op_b_sel


always @(*) begin
   case  (alu_op_b_sel)
      `alu_op_b_00:           begin    
                              A_alu_op_b_sel = " 0 ";
                              end
      `alu_op_b_opnd:         begin    
                              A_alu_op_b_sel = "OPR";
                              end
      `alu_op_b_stk:          begin    
                              A_alu_op_b_sel = "STK";
                              end
      `alu_op_b_imm:          begin    
                              A_alu_op_b_sel = "IMM";
                              end
      default:                begin
                              A_alu_op_b_sel = "XXX";
                              end
   endcase

end



   
// alu_op_b_inv


always @(*) begin
   case  (alu_op_b_inv)
      1'b1:                   begin    
                              A_alu_op_b_inv = "INV";
                              end
      1'b0:                   begin    
                              A_alu_op_b_inv = "   ";
                              end

      default:                begin
                              A_alu_op_b_inv = "XXX";
                              end
   endcase

end


   

// alu_op_c_sel


always @(*) begin
   case  (alu_op_c_sel)
      `alu_op_c_00:          A_alu_op_c_sel = " 0 ";
      `alu_op_c_01:          A_alu_op_c_sel = " 1 ";
      `alu_op_c_cin:         A_alu_op_c_sel = "CIN";    
      default:               A_alu_op_c_sel = "XXX";
                             
   endcase

end


   
// alu_status_update



always @(*) begin
   case  (alu_status_update)
      `alu_status_update_none:begin    
                              A_alu_status_update = "    ";
                              end
      `alu_status_update_nz:  begin    
                              A_alu_status_update = "N Z ";
                              end
      `alu_status_update_nzc: begin    
                              A_alu_status_update = "N ZC";
                              end
      `alu_status_update_nzcv:begin    
                              A_alu_status_update = "NVZC";
                              end
      `alu_status_update_wr:  begin    
                              A_alu_status_update = " WR ";
                              end
      `alu_status_update_z67: begin    
                              A_alu_status_update = "76Z ";
                              end
      `alu_status_update_res: begin    
                              A_alu_status_update = "RES ";
                              end
      default:                begin
                              A_alu_status_update = "XXXX";
                              end
   endcase

end





   

// dest


always @(*) begin
   case  (dest)
      `dest_none:          A_dest = "   ";
      `dest_alu_a:         A_dest = " A ";
      `dest_alu_x:         A_dest = " X ";
      `dest_alu_y:         A_dest = " Y ";
      `dest_mem:           A_dest = "MEM";
       default:            A_dest = "XXX";
                          
   endcase

end




// ctrl


always @(*) begin
   case  (ctrl)
      `ctrl_none:        A_ctrl = "       ";
      `ctrl_jsr:         A_ctrl = "JMP_SUB";
      `ctrl_jmp:         A_ctrl = " JUMP  ";
      `ctrl_jmp_ind:     A_ctrl = "JMP_IND";
      `ctrl_brk:         A_ctrl = " BREAK ";
      `ctrl_rti:         A_ctrl = "RET INT";
      `ctrl_rts:         A_ctrl = "RET SUB";
      `ctrl_branch:      A_ctrl = "BRANCH ";
       default:          A_ctrl = " -XXX- ";    
   endcase

end




// cmd


always @(*) begin
   case  (cmd)
      `cmd_none:        A_cmd = "        ";
      `cmd_run:         A_cmd = "   RUN  ";
      `cmd_load_add:    A_cmd = "LOAD ADD";
      `cmd_load_vec:    A_cmd = "LOAD VEC";
       default:         A_cmd = " -XXX- ";    
   endcase

end

   

   

// ins_type


always @(*) begin
   case  (ins_type)
      `ins_type_none:     A_ins_type = "     ";
      `ins_type_read:     A_ins_type = "READ ";
      `ins_type_write:    A_ins_type = "WRITE";
      `ins_type_rmw:      A_ins_type = " RMW ";
       default:           A_ins_type = "-XXX-";    
   endcase

end


// idx_sel


always @(*) begin
   case  (idx_sel)
      `idx_sel_00:        A_idx_sel = " 0 ";
      `idx_sel_x:         A_idx_sel = " X ";
      `idx_sel_y:         A_idx_sel = " Y ";
       default:           A_idx_sel = "---";    
   endcase

end   





   

`endif //  `ifndef SYNTHESIS
   





   

endmodule
