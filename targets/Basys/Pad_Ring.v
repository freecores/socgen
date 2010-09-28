`include "../def_file"

module `MODULE_NAME
(
   
inout  wire          A_CLK,
inout  wire          B_CLK,
inout  wire          PS2D,
inout  wire          PS2C,
inout  wire          RTS,
inout  wire          CTS,
inout  wire          RXD,
inout  wire          TXD,
output wire    [2:0] VGARED,
output wire    [2:0] VGAGREEN,
output wire    [1:0] VGABLUE,
output wire          HSYNC,
output wire          VSYNC,
inout  wire    [3:0] BTN,
inout  wire    [7:0] SW,
inout  wire          DP,
inout  wire    [7:0] LED,
inout  wire    [6:0] SEG,
inout  wire    [3:0] AN,

inout  wire          JA_1,
inout  wire          JA_2,
inout  wire          JA_3,
inout  wire          JA_4,
inout  wire          JB_1,
inout  wire          JB_2,
inout  wire          JB_3,
inout  wire          JB_4,
inout  wire          JC_1,
inout  wire          JC_2,
inout  wire          JC_3,
inout  wire          JC_4

);


   
   
// Pad Mux signals


wire        a_clk_pad_in;
wire        b_clk_pad_in;   
   
wire        ps2_data_pad_in;
wire        ps2_data_pad_oe;

wire        ps2_clk_pad_in;
wire        ps2_clk_pad_oe;


wire  [2:0] vgared_pad_out;
wire  [2:0] vgagreen_pad_out;
wire  [1:0] vgablue_pad_out;
wire        hsync_pad_out;
wire        vsync_pad_out;

   

wire  [3:0] btn_pad_in;
wire  [7:0] sw_pad_in;
wire        dp_pad_out;
wire  [7:0] led_pad_out;
wire  [6:0] seg_pad_out;
wire  [3:0] an_pad_out;


wire        ja_1_pad_out;
wire        ja_2_pad_out;
wire        ja_3_pad_out;
wire        ja_4_pad_out;


wire        jb_1_pad_out;
wire        jb_2_pad_out;
wire        jb_3_pad_out;
wire        jb_4_pad_out;

wire        jc_1_pad_out;
wire        jc_2_pad_out;
wire        jc_3_pad_out;
wire        jc_4_pad_out;


wire       rts_pad_out;
wire       cts_pad_in;
wire       rxd_pad_in;
wire       txd_pad_out;
   
   
   
// Pad Ring
   
cde_pad_se_dig a_clk_pad(
     .PAD     (A_CLK),
     .pad_in  (a_clk_pad_in),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);

cde_pad_se_dig b_clk_pad(
     .PAD     (B_CLK),
     .pad_in  (b_clk_pad_in),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);
   
cde_pad_se_dig btn_0_pad(
     .PAD     (BTN[0]),
     .pad_in  (btn_pad_in[0]),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);

cde_pad_se_dig btn_1_pad(
     .PAD     (BTN[1]),
     .pad_in  (btn_pad_in[1]),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);

cde_pad_se_dig btn_2_pad(
     .PAD     (BTN[2]),
     .pad_in  (btn_pad_in[2]),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);

cde_pad_se_dig btn_3_pad(
     .PAD     (BTN[3]),
     .pad_in  (btn_pad_in[3]),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);

cde_pad_se_dig sw_0_pad(
     .PAD     (SW[0]),
     .pad_in  (sw_pad_in[0]),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);   

cde_pad_se_dig sw_1_pad(
     .PAD     (SW[1]),
     .pad_in  (sw_pad_in[1]),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);   

cde_pad_se_dig sw_2_pad(
     .PAD     (SW[2]),
     .pad_in  (sw_pad_in[2]),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);   

cde_pad_se_dig sw_3_pad(
     .PAD     (SW[3]),
     .pad_in  (sw_pad_in[3]),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);   

cde_pad_se_dig sw_4_pad(
     .PAD     (SW[4]),
     .pad_in  (sw_pad_in[4]),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);   

cde_pad_se_dig sw_5_pad(
     .PAD     (SW[5]),
     .pad_in  (sw_pad_in[5]),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);   

cde_pad_se_dig sw_6_pad(
     .PAD     (SW[6]),
     .pad_in  (sw_pad_in[6]),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);   

cde_pad_se_dig sw_7_pad(
     .PAD     (SW[7]),
     .pad_in  (sw_pad_in[7]),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);   

cde_pad_se_dig dp_pad(
     .PAD     (DP),
     .pad_in  (),
     .pad_out (dp_pad_out),
     .pad_oe  (1'b1)
);   
      
cde_pad_se_dig led_0_pad(
     .PAD     (LED[0]),
     .pad_in  (),
     .pad_out (led_pad_out[0]),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig led_1_pad(
     .PAD     (LED[1]),
     .pad_in  (),
     .pad_out (led_pad_out[1]),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig led_2_pad(
     .PAD     (LED[2]),
     .pad_in  (),
     .pad_out (led_pad_out[2]),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig led_3_pad(
     .PAD     (LED[3]),
     .pad_in  (),
     .pad_out (led_pad_out[3]),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig led_4_pad(
     .PAD     (LED[4]),
     .pad_in  (),
     .pad_out (led_pad_out[4]),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig led_5_pad(
     .PAD     (LED[5]),
     .pad_in  (),
     .pad_out (led_pad_out[5]),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig led_6_pad(
     .PAD     (LED[6]),
     .pad_in  (),
     .pad_out (led_pad_out[6]),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig led_7_pad(
     .PAD     (LED[7]),
     .pad_in  (),
     .pad_out (led_pad_out[7]),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig seg_0_pad(
     .PAD     (SEG[0]),
     .pad_in  (),
     .pad_out (seg_pad_out[0]),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig seg_1_pad(
     .PAD     (SEG[1]),
     .pad_in  (),
     .pad_out (seg_pad_out[1]),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig seg_2_pad(
     .PAD     (SEG[2]),
     .pad_in  (),
     .pad_out (seg_pad_out[2]),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig seg_3_pad(
     .PAD     (SEG[3]),
     .pad_in  (),
     .pad_out (seg_pad_out[3]),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig seg_4_pad(
     .PAD     (SEG[4]),
     .pad_in  (),
     .pad_out (seg_pad_out[4]),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig seg_5_pad(
     .PAD     (SEG[5]),
     .pad_in  (),
     .pad_out (seg_pad_out[5]),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig seg_6_pad(
     .PAD     (SEG[6]),
     .pad_in  (),
     .pad_out (seg_pad_out[6]),
     .pad_oe  (1'b1)
);
      
cde_pad_se_dig an_0_pad(
     .PAD     (AN[0]),
     .pad_in  (),
     .pad_out (an_pad_out[0]),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig an_1_pad(
     .PAD     (AN[1]),
     .pad_in  (),
     .pad_out (an_pad_out[1]),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig an_2_pad(
     .PAD     (AN[2]),
     .pad_in  (),
     .pad_out (an_pad_out[2]),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig an_3_pad(
     .PAD     (AN[3]),
     .pad_in  (),
     .pad_out (an_pad_out[3]),
     .pad_oe  (1'b1)
);   
   
cde_pad_se_dig ps2_data_pad(
     .PAD     (PS2D),
     .pad_in  (ps2_data_pad_in),
     .pad_out (1'b0),
     .pad_oe  (ps2_data_pad_oe)
);

cde_pad_se_dig ps2_clk_pad(
     .PAD     (PS2C),
     .pad_in  (ps2_clk_pad_in),
     .pad_out (1'b0),
     .pad_oe  (ps2_clk_pad_oe)
);

cde_pad_se_dig ja_1_pad(
     .PAD     (JA_1),
     .pad_in  (),
     .pad_out (ja_1_pad_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig ja_2_pad(
     .PAD     (JA_2),
     .pad_in  (),
     .pad_out (ja_2_pad_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig ja_3_pad(
     .PAD     (JA_3),
     .pad_in  (),
     .pad_out (ja_3_pad_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig ja_4_pad(
     .PAD     (JA_4),
     .pad_in  (),
     .pad_out (ja_4_pad_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig jb_1_pad(
     .PAD     (JB_1),
     .pad_in  (),
     .pad_out (jb_1_pad_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig jb_2_pad(
     .PAD     (JB_2),
     .pad_in  (),
     .pad_out (jb_2_pad_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig jb_3_pad(
     .PAD     (JB_3),
     .pad_in  (),
     .pad_out (jb_3_pad_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig jb_4_pad(
     .PAD     (JB_4),
     .pad_in  (),
     .pad_out (jb_4_pad_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig jc_1_pad(
     .PAD     (JC_1),
     .pad_in  (),
     .pad_out (jc_1_pad_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig jc_2_pad(
     .PAD     (JC_2),
     .pad_in  (),
     .pad_out (jc_2_pad_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig jc_3_pad(
     .PAD     (JC_3),
     .pad_in  (),
     .pad_out (jc_3_pad_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig jc_4_pad(
     .PAD     (JC_4),
     .pad_in  (),
     .pad_out (jc_4_pad_out),
     .pad_oe  (1'b1)
);   

   
cde_pad_se_dig rts_pad(
     .PAD     (RTS),
     .pad_in  (),
     .pad_out (rts_pad_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig cts_pad(
     .PAD     (CTS),
     .pad_in  (cts_pad_in),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);   

cde_pad_se_dig rxd_pad(
     .PAD     (RXD),
     .pad_in  (rxd_pad_in),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);   

cde_pad_se_dig txd_pad(
     .PAD     (TXD),
     .pad_in  (),
     .pad_out (txd_pad_out),
     .pad_oe  (1'b1)
);   
   


cde_pad_se_dig vgared_0_pad(
     .PAD     (VGARED[0]),
     .pad_in  (),
     .pad_out (vgared_pad_out[0]),
     .pad_oe  (1'b1)
);

cde_pad_se_dig vgared_1_pad(
     .PAD     (VGARED[1]),
     .pad_in  (),
     .pad_out (vgared_pad_out[1]),
     .pad_oe  (1'b1)
);

cde_pad_se_dig vgared_2_pad(
     .PAD     (VGARED[2]),
     .pad_in  (),
     .pad_out (vgared_pad_out[2]),
     .pad_oe  (1'b1)
);

cde_pad_se_dig vgagreen_0_pad(
     .PAD     (VGAGREEN[0]),
     .pad_in  (),
     .pad_out (vgagreen_pad_out[0]),
     .pad_oe  (1'b1)
);

cde_pad_se_dig vgagreen_1_pad(
     .PAD     (VGAGREEN[1]),
     .pad_in  (),
     .pad_out (vgagreen_pad_out[1]),
     .pad_oe  (1'b1)
);

cde_pad_se_dig vgagreen_2_pad(
     .PAD     (VGAGREEN[2]),
     .pad_in  (),
     .pad_out (vgagreen_pad_out[2]),
     .pad_oe  (1'b1)
);
   
cde_pad_se_dig vgablue_0_pad(
     .PAD     (VGABLUE[0]),
     .pad_in  (),
     .pad_out (vgablue_pad_out[0]),
     .pad_oe  (1'b1)
);

cde_pad_se_dig vgablue_1_pad(
     .PAD     (VGABLUE[1]),
     .pad_in  (),
     .pad_out (vgablue_pad_out[1]),
     .pad_oe  (1'b1)
);



cde_pad_se_dig hsync_pad(
     .PAD     (HSYNC),
     .pad_in  (),
     .pad_out (hsync_pad_out),
     .pad_oe  (1'b1)
);

cde_pad_se_dig vsync_pad(
     .PAD     (VSYNC),
     .pad_in  (),
     .pad_out (vsync_pad_out),
     .pad_oe  (1'b1)
);



// Clock System



wire        ck25MHz;
wire        ck100MHz;
wire        one_usec;
wire        reset;

wire [15:0]  PosD;
wire [ 7:0]  PosL;
wire [ 3:0]  PosB;
wire [ 7:0]  PosS;


cde_clock_sys  clock_sys  (
            .a_clk_pad_in    (a_clk_pad_in),
            .b_clk_pad_in    (b_clk_pad_in),
            .pwron_pad_in    (!cts_pad_in), 
            .ckDivOut        (ck25MHz),
            .ckOut           (ck100MHz),
	    .one_usec        (one_usec),
	    .reset           (reset)

        );







cde_jtag 
jtag_tap(
		 
        .tdi_1                (td1),
        .tdi_2                (td2),
        .tck_1                (tck1),
        .tck_2                (tck2),
        .tdo_o                (tdo),
        .test_logic_reset_o   (test_logic_reset),
        .shift_dr_o           (shift_dr),
        .capture_dr_o         (capture_dr),
        .update_dr_o          (update_dr),
        .select_1             (select1),
        .select_2             (select2)
 
);





wire [`JTAG_USER1_WIDTH-1:0] jtag_user1_cap;
wire [`JTAG_USER2_WIDTH-1:0] jtag_user2_cap;

wire [`JTAG_USER1_WIDTH-1:0] jtag_user1_upd;
wire [`JTAG_USER2_WIDTH-1:0] jtag_user2_upd;


   
   
cde_jtag_rpc_reg #(`JTAG_USER1_WIDTH ,`JTAG_USER1_RESET  )
user1_reg
(
    .clk              (tck1), 
    .reset            (test_logic_reset), 
    .tdi              (tdo), 
    .select           (select1), 
    .tdo              (td1), 
    .update_dr        (update_dr), 
    .capture_dr       (capture_dr), 
    .shift_dr         (shift_dr), 
    .capture_value    (jtag_user1_cap),	
    .update_value     (jtag_user1_upd)	
);


cde_jtag_rpc_reg #(`JTAG_USER2_WIDTH,`JTAG_USER2_RESET )
user2_reg
(
    .clk              (tck2), 
    .reset            (test_logic_reset), 
    .tdi              (tdo), 
    .select           (select2), 
    .tdo              (td2), 
    .update_dr        (update_dr), 
    .capture_dr       (capture_dr), 
    .shift_dr         (shift_dr), 
    .capture_value    (jtag_user2_cap), 
    .update_value     (jtag_user2_upd)
);

   





   








   


`include "../core.v"

   


   

endmodule