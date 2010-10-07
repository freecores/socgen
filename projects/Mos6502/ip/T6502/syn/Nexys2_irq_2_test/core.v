



   

   // Declare I/O Port connections


wire            clk = ck25MHz;









wire [15:0]  add_mon;
wire [7:0]   gpio_0_out;
wire [7:0]   gpio_1_out;







assign   jtag_user1_cap =  jtag_user1_upd;
assign   jtag_user2_cap =  add_mon;

assign  PosD             = {gpio_0_out,gpio_1_out};
assign  PosL             = 8'h12;

   
   
assign   ja_1_pad_out  = 1'b0;
assign   ja_2_pad_out  = reset;
assign   ja_3_pad_out  = 1'b0;
assign   ja_4_pad_out  = 1'b0    ;

assign   ja_7_pad_out  = 1'b0;
assign   ja_8_pad_out  = 1'b0;
assign   ja_9_pad_out  = 1'b0;
assign   ja_10_pad_out  = 1'b0;



assign   jb_1_pad_out  = 1'b0;
assign   jb_2_pad_out  = 1'b0;
assign   jb_3_pad_out  = 1'b0;
assign   jb_4_pad_out  = 1'b0;


assign   jb_7_pad_out  = 1'b0;
assign   jb_8_pad_out  = 1'b0;
assign   jb_9_pad_out  = 1'b0;
assign   jb_10_pad_out  = 1'b0;


assign   jc_1_pad_out  = 1'b1;
assign   jc_2_pad_out  = 1'b0;
assign   jc_3_pad_out  = 1'b1;
assign   jc_4_pad_out  = 1'b0;

assign   jc_7_pad_out  = 1'b1;
assign   jc_8_pad_out  = 1'b0;
assign   jc_9_pad_out  = 1'b1;
assign   jc_10_pad_out  = 1'b0;






wire [9:0] xpos;


assign add_mon[15:0] = 16'h0000 ;

   

T6502   #(
         .ROM_WORDS    (`ROM_WORDS),    	 
         .ROM_ADD      (`ROM_ADD),    	 
         .ROM_FILE     (`ROM_FILE),
	 .PROG_ROM_WORDS    (`PROG_ROM_WORDS),    	 
         .PROG_ROM_ADD      (`PROG_ROM_ADD),    	 
         .PROG_ROM_FILE     (`PROG_ROM_FILE),	  
         .RAM_WORDS    (2048),           
         .STARTUP      (`STARTUP),
         .FONT         (`FONT)
         )  
 cpu   (
         .clk           ( ck25MHz       ),
         .reset         ( reset         ),




         .alu_status    (                ), 

         .ext_add       ( micro_addr     ),
         .ext_wdata     ( micro_wdata    ), 
         .ext_rdata     ( micro_rdata    ),
         .ext_ub        ( micro_ub       ),
         .ext_lb        ( micro_lb       ),  
         .ext_rd        ( micro_rd       ),
         .ext_wr        ( micro_wr       ),
         .ext_cs        ( micro_cs       ),

	
	

         .ext_irq_in    (  4'h0         ),

         .gpio_0_out    ( gpio_0_out    ),
         .gpio_0_in     (  8'h00        ),
         .gpio_0_oe     (               ),
         .gpio_0_lat    (               ),

         .gpio_1_out    ( gpio_1_out    ),
         .gpio_1_in     ( 8'h00         ),
         .gpio_1_oe     (               ),
         .gpio_1_lat    (               ),

         .ps2_data_oe   ( ps2_data_pad_oe        ),
         .ps2_data_in   ( ps2_data_pad_in        ),
         .ps2_clk_oe    ( ps2_clk_pad_oe         ),
         .ps2_clk_in    ( ps2_clk_pad_in         ), 
		
         .txd_pad_out   ( rs_tx_pad_out          ),
         .rxd_pad_in    ( rs_rx_pad_in           ),
         .cts_pad_in    ( cts_pad_in             ),
         .rts_pad_out   ( rts_pad_out            ),
        
         .vgared_pad_out  (vgared_pad_out[2:0]   ),
         .vgagreen_pad_out(vgagreen_pad_out[2:0] ),
         .vgablue_pad_out ( vgablue_pad_out[1:0] ),

         .hsync_n_pad_out ( hsync_pad_out        ),
         .vsync_n_pad_out ( vsync_pad_out        )

	
);


assign   txd_pad_out  = rxd_pad_in;   



disp_io
disp_io(   
        .clk            ( ck25MHz     ),
        .reset          ( reset       ),
        .PosD           ( PosD        ),
        .PosL           ( PosL        ),
        .PosB           ( PosB        ),  
        .PosS           ( PosS        ), 
        .btn_pad_in     ( btn_pad_in  ),
        .sw_pad_in      ( sw_pad_in   ),
        .led_pad_out    ( led_pad_out ),
        .seg_pad_out    ( seg_pad_out ),
        .dp_pad_out     ( dp_pad_out  ), 
        .an_pad_out     ( an_pad_out  ));
