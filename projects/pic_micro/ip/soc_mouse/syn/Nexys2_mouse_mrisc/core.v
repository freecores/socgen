
assign           micro_addr =  16'h0000;
assign           micro_wdata =  16'h0000;
assign           micro_rdata =  16'h0000;
assign           micro_rd =  1'b0;   
assign           micro_wr =  1'b0;   
assign           micro_ub =  1'b0;   
assign           micro_lb =  1'b0;   



   

   // Declare I/O Port connections

wire [7:0]	portaout;
wire [7:0]	portbout;
wire [7:0]	portcout;

wire [7:0]	trisa;
wire [7:0]	trisb;
wire [7:0]	trisc;

wire            ms_left;
wire            ms_right;

wire            clk = ck25MHz;


wire            read;

wire [9:0]      x_pos;
wire [9:0]      y_pos;



assign rs_tx_pad_out  = rs_rx_pad_in;




assign   jtag_user1_cap =  jtag_user1_upd;
assign   jtag_user2_cap =  PosS;


   
   
assign   ja_1_pad_out  = 1'b0;
assign   ja_2_pad_out  = reset;
assign   ja_3_pad_out  = one_usec;
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





// Instantiate one CPU to be tested.
soc_mouse_mrisc
#(
    .ROM_FILE   (`ROM_FILE),  
    .ROM_WORDS  (`ROM_WORDS),  
    .ROM_ADDR   (`ROM_ADDR),  
    .ROM_WIDTH  (`ROM_WIDTH)   
  )


soc(
   .clk		  ( clk              ),
   .reset	  ( reset            ),
   .ps2_data_pad_oe   ( ps2_data_pad_oe  ),
   .ps2_data_pad_in   ( ps2_data_pad_in  ),
   .ps2_clk_pad_oe    ( ps2_clk_pad_oe   ),
   .ps2_clk_pad_in    ( ps2_clk_pad_in   ),
   .portaout      ( portaout         ),
   .portbout      ( portbout         ),
   .portcout      ( portcout         ),
   .x_pos         ( x_pos            ),
   .y_pos         ( y_pos            ),
   .ms_right      ( ms_right         ),
   .ms_left       ( ms_left          ),
   .txd_pad_out   ( txd_pad_out      ),
   .rxd_pad_in    ( rxd_pad_in       ),
   .cts_pad_in    ( cts_pad_in       ),
   .rts_pad_out   ( rts_pad_out      )
    
  );




assign  vgared_pad_out[2:0]   = 3'b000;
assign  vgagreen_pad_out[2:0] = 3'b000;
assign  vgablue_pad_out[1:0]  = 2'b00;
assign  hsync_pad_out         = 1'b0;
assign  vsync_pad_out         = 1'b0;




assign PosD  = {y_pos[7:0],x_pos[7:0]};
assign PosL  = {6'b000000,ms_left,ms_right};

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
