`include "../def_file"


module `MODULE_NAME



  
(

inout  wire          A_CLK,
inout  wire          B_CLK,



inout  wire    [6:0] SEG,
inout  wire          DP,
inout  wire    [3:0] AN,
inout  wire    [7:0] SW,   
inout  wire    [3:0] BTN,
inout  wire    [7:0] LED,





output wire    [2:0] VGARED,
output wire    [2:0] VGAGREEN,
output wire    [1:0] VGABLUE,
output wire          HSYNC,
output wire          VSYNC,




inout wire           PS2C,
inout wire           PS2D,




inout  wire          JA_1, 
inout  wire          JA_2,
inout  wire          JA_3,
inout  wire          JA_4,
inout  wire          JA_7,
inout  wire          JA_8,
inout  wire          JA_9,
inout  wire          JA_10,
 

 
inout  wire          JB_1,		     
inout  wire          JB_2,
inout  wire          JB_3,
inout  wire          JB_4,
inout  wire          JB_7,
inout  wire          JB_8,
inout  wire          JB_9,
inout  wire          JB_10,


 
inout  wire          JC_1,		     
inout  wire          JC_2,
inout  wire          JC_3,
inout  wire          JC_4,
inout  wire          JC_7,
inout  wire          JC_8,
inout  wire          JC_9,
inout  wire          JC_10,

inout  wire          RTS,
inout  wire          CTS,
inout  wire          RXD,
inout  wire          TXD,
 
inout  wire          RS_RX,
inout  wire          RS_TX,


 
output wire [23:1]   MEMADR    ,
inout  wire [15:0]   MEMDB     ,
output wire          MEMOE     ,
output wire          MEMWR     , 

		     
output wire          RAMADV    ,
output wire          RAMCLK    ,
output wire          RAMUB     ,
output wire          RAMLB     , 
output wire          RAMCS     ,
output wire          RAMCRE    ,
inout  wire          RAMWAIT   ,

inout  wire          FLASHSTSTS,
output wire          FLASHRP   ,
output wire          FLASHCS   ,





inout  wire          EPPASTB   ,
inout  wire          EPPDSTB   ,
inout wire           USBFLAG,
inout  wire          EPPWAIT   , 
inout wire           USBWR,
inout wire           USBMODE,
inout wire           USBOE,
inout wire [1:0]     USBADR,
inout wire           USBPKTEND,
inout wire           USBDIR,
inout  wire [7:0]    EPPDB     ,
inout wire           USBCLK,
inout  wire          USBRDY     ,



  
		     
inout  wire [39:0]   PIO        	   

 
		   
);


   
// Pad Mux signals


wire        a_clk_pad_in;
wire        b_clk_pad_in;

   
wire  [6:0] seg_pad_out;
wire        dp_pad_out;
wire  [3:0] an_pad_out;   
wire  [7:0] sw_pad_in;
wire  [3:0] btn_pad_in;
wire  [7:0] led_pad_out;

wire        ps2_data_pad_in;
wire        ps2_data_pad_oe;
wire        ps2_clk_pad_in;
wire        ps2_clk_pad_oe;



wire        rs_rx_pad_in;
wire        rs_tx_pad_out;   


   

wire [2:0]  vgared_pad_out;
wire [2:0]  vgagreen_pad_out;
wire [1:0]  vgablue_pad_out;

wire        hsync_pad_out;
wire        vsync_pad_out;
   

wire       ja_1_pad_out;
wire       ja_2_pad_out;
wire       ja_3_pad_out;
wire       ja_4_pad_out;
wire       ja_7_pad_out;
wire       ja_8_pad_out;
wire       ja_9_pad_out;
wire       ja_10_pad_out;

wire       jb_1_pad_out;
wire       jb_2_pad_out;
wire       jb_3_pad_out;
wire       jb_4_pad_out;
wire       jb_7_pad_out;
wire       jb_8_pad_out;
wire       jb_9_pad_out;
wire       jb_10_pad_out;

   
wire       jc_1_pad_out;
wire       jc_2_pad_out;
wire       jc_3_pad_out;
wire       jc_4_pad_out;
wire       jc_7_pad_out;
wire       jc_8_pad_out;
wire       jc_9_pad_out;
wire       jc_10_pad_out;

wire        rts_pad_out;
wire        cts_pad_in;
wire        rxd_pad_in;
wire        txd_pad_out;
   

wire        ramclk_out;
wire        ramcre_out;
wire        memoe_n_out;
wire        ramcs_n_out;
wire        ramlb_n_out;
wire        flashcs_n_out;
wire        flashrp_n_out;
wire        flashststs_in;
wire [23:1] memadr_out;
wire [15:0] memdb_out;   
wire [15:0] memdb_in;
wire        memdb_oe;
wire        ramub_n_out;
wire        memwr_n_out;

wire        ramwait_in;
wire        ramadv_out_n;
   

wire        eppastb_in;   
wire        eppdstb_in;
wire        usbflag_in;
wire        eppwait_out;      
wire        eppwait_in;      
wire        eppwait_oe;
wire        usbwr_out;
wire        usbwr_oe;
wire        usbwr_in;
wire        usbmode_out;
wire        usbmode_oe;
wire        usbmode_in;
wire        usboe_out;
wire        usboe_oe;
wire        usboe_in;
wire  [1:0] usbadr_out;
wire        usbadr_oe;
wire  [1:0] usbadr_in;
wire        usbpktend_out;
wire        usbpktend_oe;
wire        usbpktend_in;
wire        usbdir_out;
wire        usbdir_oe;
wire        usbdir_in;
wire [7:0]  eppdb_in;
wire [7:0]  eppdb_out;
wire        eppdb_oe;
wire        eppwr_in;
wire        usbclk_out;
wire        usbclk_oe;
wire        usbclk_in;
wire        usbrdy_in;


wire [39:0]  pio_out;
wire [39:0]  pio_in;
wire [39:0]  pio_oe;

   
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
   
cde_pad_se_dig dp_pad(
     .PAD     (DP),
     .pad_in  (),
     .pad_out (dp_pad_out),
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

cde_pad_se_dig rs_rx_pad(
     .PAD     (RS_RX),
     .pad_in  (rs_rx_pad_in),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);   

cde_pad_se_dig rs_tx_pad(
     .PAD     (RS_TX),
     .pad_in  (),
     .pad_out (rs_tx_pad_out),
     .pad_oe  (1'b1)
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

cde_pad_se_dig ja_7_pad(
     .PAD     (JA_7),
     .pad_in  (),
     .pad_out (ja_7_pad_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig ja_8_pad(
     .PAD     (JA_8),
     .pad_in  (),
     .pad_out (ja_8_pad_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig ja_9_pad(
     .PAD     (JA_9),
     .pad_in  (),
     .pad_out (ja_9_pad_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig ja_10_pad(
     .PAD     (JA_10),
     .pad_in  (),
     .pad_out (ja_10_pad_out),
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

cde_pad_se_dig jb_7_pad(
     .PAD     (JB_7),
     .pad_in  (),
     .pad_out (jb_7_pad_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig jb_8_pad(
     .PAD     (JB_8),
     .pad_in  (),
     .pad_out (jb_8_pad_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig jb_9_pad(
     .PAD     (JB_9),
     .pad_in  (),
     .pad_out (jb_9_pad_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig jb_10_pad(
     .PAD     (JB_10),
     .pad_in  (),
     .pad_out (jb_10_pad_out),
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

cde_pad_se_dig jc_7_pad(
     .PAD     (JC_7),
     .pad_in  (),
     .pad_out (jc_7_pad_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig jc_8_pad(
     .PAD     (JC_8),
     .pad_in  (),
     .pad_out (jc_8_pad_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig jc_9_pad(
     .PAD     (JC_9),
     .pad_in  (),
     .pad_out (jc_9_pad_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig jc_10_pad(
     .PAD     (JC_10),
     .pad_in  (),
     .pad_out (jc_10_pad_out),
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
   
cde_pad_se_dig  ramadv_pad(
     .PAD     (RAMADV),
     .pad_in  (),
     .pad_out (ramadv_out_n),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig  ramclk_pad(
     .PAD     (RAMCLK),
     .pad_in  (),
     .pad_out (ramclk_out),
     .pad_oe  (1'b1)
);   


cde_pad_se_dig  ramcre_pad(
     .PAD     (RAMCRE),
     .pad_in  (),
     .pad_out (ramcre_out),
     .pad_oe  (1'b1)
);   

   
cde_pad_se_dig  memoe_pad(
     .PAD     (MEMOE),
     .pad_in  (),
     .pad_out (memoe_n_out),
     .pad_oe  (1'b1)
);
   
cde_pad_se_dig  ramcs_pad(
     .PAD     (RAMCS),
     .pad_in  (),
     .pad_out (ramcs_n_out),
     .pad_oe  (1'b1)
);   

cde_pad_se_dig  ramlb_pad(
     .PAD     (RAMLB),
     .pad_in  (),
     .pad_out (ramlb_n_out),
     .pad_oe  (1'b1)
);   

   
cde_pad_se_dig  ramub_pad(
     .PAD     (RAMUB),
     .pad_in  (),
     .pad_out (ramub_n_out),
     .pad_oe  (1'b1)
);   

   
cde_pad_se_dig  memwr_pad(
     .PAD     (MEMWR),
     .pad_in  (),
     .pad_out (memwr_n_out),
     .pad_oe  (1'b1)
);   


cde_pad_se_dig  flashcs_pad(
     .PAD     (FLASHCS),
     .pad_in  (),
     .pad_out (flashcs_n_out),
     .pad_oe  (1'b1)
);   


cde_pad_se_dig  flashrp_pad(
     .PAD     (FLASHRP),
     .pad_in  (),
     .pad_out (flashrp_n_out),
     .pad_oe  (1'b1)
);

   
cde_pad_se_dig  flashststs_pad(
     .PAD     (FLASHSTSTS),
     .pad_in  (flashststs_in),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);   


cde_pad_se_dig  ramwait_pad(
     .PAD     (RAMWAIT),
     .pad_in  (ramwait_in),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);   


   
cde_pad_se_dig  memadr_1_pad(
     .PAD     (MEMADR[1]),
     .pad_in  (),
     .pad_out (memadr_out[1]),
     .pad_oe  (1'b1)
);


cde_pad_se_dig  memadr_2_pad(
     .PAD     (MEMADR[2]),
     .pad_in  (),
     .pad_out (memadr_out[2]),
     .pad_oe  (1'b1)
);


cde_pad_se_dig  memadr_3_pad(
     .PAD     (MEMADR[3]),
     .pad_in  (),
     .pad_out (memadr_out[3]),
     .pad_oe  (1'b1)
);


cde_pad_se_dig  memadr_4_pad(
     .PAD     (MEMADR[4]),
     .pad_in  (),
     .pad_out (memadr_out[4]),
     .pad_oe  (1'b1)
);

cde_pad_se_dig  memadr_5_pad(
     .PAD     (MEMADR[5]),
     .pad_in  (),
     .pad_out (memadr_out[5]),
     .pad_oe  (1'b1)
);

cde_pad_se_dig  memadr_6_pad(
     .PAD     (MEMADR[6]),
     .pad_in  (),
     .pad_out (memadr_out[6]),
     .pad_oe  (1'b1)
);

cde_pad_se_dig  memadr_7_pad(
     .PAD     (MEMADR[7]),
     .pad_in  (),
     .pad_out (memadr_out[7]),
     .pad_oe  (1'b1)
);

cde_pad_se_dig  memadr_8_pad(
     .PAD     (MEMADR[8]),
     .pad_in  (),
     .pad_out (memadr_out[8]),
     .pad_oe  (1'b1)
);

cde_pad_se_dig  memadr_9_pad(
     .PAD     (MEMADR[9]),
     .pad_in  (),
     .pad_out (memadr_out[9]),
     .pad_oe  (1'b1)
);

cde_pad_se_dig  memadr_10_pad(
     .PAD     (MEMADR[10]),
     .pad_in  (),
     .pad_out (memadr_out[10]),
     .pad_oe  (1'b1)
);   


cde_pad_se_dig  memadr_11_pad(
     .PAD     (MEMADR[11]),
     .pad_in  (),
     .pad_out (memadr_out[11]),
     .pad_oe  (1'b1)
);


cde_pad_se_dig  memadr_12_pad(
     .PAD     (MEMADR[12]),
     .pad_in  (),
     .pad_out (memadr_out[12]),
     .pad_oe  (1'b1)
);


cde_pad_se_dig  memadr_13_pad(
     .PAD     (MEMADR[13]),
     .pad_in  (),
     .pad_out (memadr_out[13]),
     .pad_oe  (1'b1)
);


cde_pad_se_dig  memadr_14_pad(
     .PAD     (MEMADR[14]),
     .pad_in  (),
     .pad_out (memadr_out[14]),
     .pad_oe  (1'b1)
);

cde_pad_se_dig  memadr_15_pad(
     .PAD     (MEMADR[15]),
     .pad_in  (),
     .pad_out (memadr_out[15]),
     .pad_oe  (1'b1)
);

cde_pad_se_dig  memadr_16_pad(
     .PAD     (MEMADR[16]),
     .pad_in  (),
     .pad_out (memadr_out[16]),
     .pad_oe  (1'b1)
);

cde_pad_se_dig  memadr_17_pad(
     .PAD     (MEMADR[17]),
     .pad_in  (),
     .pad_out (memadr_out[17]),
     .pad_oe  (1'b1)
);

cde_pad_se_dig  memadr_18_pad(
     .PAD     (MEMADR[18]),
     .pad_in  (),
     .pad_out (memadr_out[18]),
     .pad_oe  (1'b1)
);

cde_pad_se_dig  memadr_19_pad(
     .PAD     (MEMADR[19]),
     .pad_in  (),
     .pad_out (memadr_out[19]),
     .pad_oe  (1'b1)
);

cde_pad_se_dig  memadr_20_pad(
     .PAD     (MEMADR[20]),
     .pad_in  (),
     .pad_out (memadr_out[20]),
     .pad_oe  (1'b1)
);   


cde_pad_se_dig  memadr_21_pad(
     .PAD     (MEMADR[21]),
     .pad_in  (),
     .pad_out (memadr_out[21]),
     .pad_oe  (1'b1)
);


cde_pad_se_dig  memadr_22_pad(
     .PAD     (MEMADR[22]),
     .pad_in  (),
     .pad_out (memadr_out[22]),
     .pad_oe  (1'b1)
);



cde_pad_se_dig  memadr_23_pad(
     .PAD     (MEMADR[23]),
     .pad_in  (),
     .pad_out (memadr_out[23]),
     .pad_oe  (1'b1)
);



cde_pad_se_dig  memdb_00_pad(
     .PAD     (MEMDB[0]),
     .pad_in  (memdb_in[0]),
     .pad_out (memdb_out[0]),
     .pad_oe  (memdb_oe)
);


cde_pad_se_dig  memdb_01_pad(
     .PAD     (MEMDB[1]),
     .pad_in  (memdb_in[1]),
     .pad_out (memdb_out[1]),
     .pad_oe  (memdb_oe)
);



cde_pad_se_dig  memdb_02_pad(
     .PAD     (MEMDB[2]),
     .pad_in  (memdb_in[2]),
     .pad_out (memdb_out[2]),
     .pad_oe  (memdb_oe)
);


cde_pad_se_dig  memdb_03_pad(
     .PAD     (MEMDB[3]),
     .pad_in  (memdb_in[3]),
     .pad_out (memdb_out[3]),
     .pad_oe  (memdb_oe)
);

cde_pad_se_dig  memdb_04_pad(
     .PAD     (MEMDB[4]),
     .pad_in  (memdb_in[4]),
     .pad_out (memdb_out[4]),
     .pad_oe  (memdb_oe)
);


cde_pad_se_dig  memdb_05_pad(
     .PAD     (MEMDB[5]),
     .pad_in  (memdb_in[5]),
     .pad_out (memdb_out[5]),
     .pad_oe  (memdb_oe)
);

cde_pad_se_dig  memdb_06_pad(
     .PAD     (MEMDB[6]),
     .pad_in  (memdb_in[6]),
     .pad_out (memdb_out[6]),
     .pad_oe  (memdb_oe)
);

cde_pad_se_dig  memdb_07_pad(
     .PAD     (MEMDB[7]),
     .pad_in  (memdb_in[7]),
     .pad_out (memdb_out[7]),
     .pad_oe  (memdb_oe)
);

cde_pad_se_dig  memdb_08_pad(
     .PAD     (MEMDB[8]),
     .pad_in  (memdb_in[8]),
     .pad_out (memdb_out[8]),
     .pad_oe  (memdb_oe)
);

cde_pad_se_dig  memdb_09_pad(
     .PAD     (MEMDB[9]),
     .pad_in  (memdb_in[9]),
     .pad_out (memdb_out[9]),
     .pad_oe  (memdb_oe)
);

cde_pad_se_dig  memdb_10_pad(
     .PAD     (MEMDB[10]),
     .pad_in  (memdb_in[10]),
     .pad_out (memdb_out[10]),
     .pad_oe  (memdb_oe)
);

cde_pad_se_dig  memdb_11_pad(
     .PAD     (MEMDB[11]),
     .pad_in  (memdb_in[11]),
     .pad_out (memdb_out[11]),
     .pad_oe  (memdb_oe)
);


cde_pad_se_dig  memdb_12_pad(
     .PAD     (MEMDB[12]),
     .pad_in  (memdb_in[12]),
     .pad_out (memdb_out[12]),
     .pad_oe  (memdb_oe)
);

cde_pad_se_dig  memdb_13_pad(
     .PAD     (MEMDB[13]),
     .pad_in  (memdb_in[13]),
     .pad_out (memdb_out[13]),
     .pad_oe  (memdb_oe)
);
cde_pad_se_dig  memdb_14_pad(
     .PAD     (MEMDB[14]),
     .pad_in  (memdb_in[14]),
     .pad_out (memdb_out[14]),
     .pad_oe  (memdb_oe)
);

cde_pad_se_dig  memdb_15_pad(
     .PAD     (MEMDB[15]),
     .pad_in  (memdb_in[15]),
     .pad_out (memdb_out[15]),
     .pad_oe  (memdb_oe)
);


//
   



   
   

  
cde_pad_se_dig  eppastb_pad(
     .PAD     (EPPASTB),
     .pad_in  (eppastb_in),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);

cde_pad_se_dig  eppdstb_pad(
     .PAD     (EPPDSTB),
     .pad_in  (eppdstb_in),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);


cde_pad_se_dig  usbflag_pad(
     .PAD      (USBFLAG ),
     .pad_in   (usbflag_in),
     .pad_out  (1'b0),
     .pad_oe   (1'b0)
);



   
cde_pad_se_dig  eppwait_pad(
     .PAD     (EPPWAIT),
     .pad_in  (eppwait_in),
     .pad_out (eppwait_out),
     .pad_oe  (eppwait_oe)
);   



cde_pad_se_dig  usbwr_pad(
     .PAD      (USBWR),
     .pad_in   (usbwr_in),
     .pad_out  (usbwr_out),
     .pad_oe   (usbwr_oe)
);


cde_pad_se_dig  usbmode_pad(
     .PAD      (USBMODE ),
     .pad_in   (usbmode_in),
     .pad_out  (usbmode_out),
     .pad_oe   (usbmode_oe)
);   



cde_pad_se_dig  usboe_pad(
     .PAD      (USBOE ),
     .pad_in   (usboe_in),
     .pad_out  (usboe_out),
     .pad_oe   (usboe_oe)
);
   
   




cde_pad_se_dig  usbadr_0_pad(
     .PAD      (USBADR[0] ),
     .pad_in   (usbadr_in[0]),
     .pad_out  (usbadr_out[0]),
     .pad_oe   (usbadr_oe)
);

cde_pad_se_dig  usbadr_1_pad(
     .PAD      (USBADR[1] ),
     .pad_in   (usbadr_in[1]),
     .pad_out  (usbadr_out[1]),
     .pad_oe   (usbadr_oe)
);


   


   
cde_pad_se_dig  usbpktend_pad(
     .PAD      (USBPKTEND ),
     .pad_in   (usbpktend_in),
     .pad_out  (usbpktend_out),
     .pad_oe   (usbpktend_oe)
);


cde_pad_se_dig  usbdir_pad(
     .PAD      (USBDIR ),
     .pad_in   (usbdir_in),
     .pad_out  (usbdir_out),
     .pad_oe   (usbdir_oe)
);



   


   
cde_pad_se_dig  eppdb_0_pad(
     .PAD     (EPPDB[0]),
     .pad_in  (eppdb_in[0]),
     .pad_out (eppdb_out[0]),
     .pad_oe  (eppdb_oe)
);   



cde_pad_se_dig  eppdb_1_pad(
     .PAD     (EPPDB[1]),
     .pad_in  (eppdb_in[1]),
     .pad_out (eppdb_out[1]),
     .pad_oe  (eppdb_oe)
);   


cde_pad_se_dig  eppdb_2_pad(
     .PAD     (EPPDB[2]),
     .pad_in  (eppdb_in[2]),
     .pad_out (eppdb_out[2]),
     .pad_oe  (eppdb_oe)
);   


cde_pad_se_dig  eppdb_3_pad(
     .PAD     (EPPDB[3]),
     .pad_in  (eppdb_in[3]),
     .pad_out (eppdb_out[3]),
     .pad_oe  (eppdb_oe)
);   


cde_pad_se_dig  eppdb_4_pad(
     .PAD     (EPPDB[4]),
     .pad_in  (eppdb_in[4]),
     .pad_out (eppdb_out[4]),
     .pad_oe  (eppdb_oe)
);   


cde_pad_se_dig  eppdb_5_pad(
     .PAD     (EPPDB[5]),
     .pad_in  (eppdb_in[5]),
     .pad_out (eppdb_out[5]),
     .pad_oe  (eppdb_oe)
);   


cde_pad_se_dig  eppdb_6_pad(
     .PAD     (EPPDB[6]),
     .pad_in  (eppdb_in[6]),
     .pad_out (eppdb_out[6]),
     .pad_oe  (eppdb_oe)
);   


cde_pad_se_dig  eppdb_7_pad(
     .PAD     (EPPDB[7]),
     .pad_in  (eppdb_in[7]),
     .pad_out (eppdb_out[7]),
     .pad_oe  (eppdb_oe)
);   


   
   


cde_pad_se_dig  usbclk_pad(
     .PAD      (USBCLK ),
     .pad_in   (usbclk_in),
     .pad_out  (usbclk_out),
     .pad_oe   (usbclk_oe)
);



cde_pad_se_dig  usbrdy_pad(
     .PAD     (USBRDY),
     .pad_in  (usbrdy_in),
     .pad_out (1'b0),
     .pad_oe  (1'b0)
);

   

   

   
   
   
   



   
cde_pad_se_dig  pio_00_pad(
     .PAD      (PIO[00]),
     .pad_in   (pio_in[00]),
     .pad_out  (pio_out[00]),
     .pad_oe   (pio_oe[00])
);

cde_pad_se_dig  pio_01_pad(
     .PAD      (PIO[01]),
     .pad_in   (pio_in[01]),
     .pad_out  (pio_out[01]),
     .pad_oe   (pio_oe[01])
);

cde_pad_se_dig  pio_02_pad(
     .PAD      (PIO[02]),
     .pad_in   (pio_in[02]),
     .pad_out  (pio_out[02]),
     .pad_oe   (pio_oe[02])
);

cde_pad_se_dig  pio_03_pad(
     .PAD      (PIO[03]),
     .pad_in   (pio_in[03]),
     .pad_out  (pio_out[03]),
     .pad_oe   (pio_oe[03])
);

cde_pad_se_dig  pio_04_pad(
     .PAD      (PIO[04]),
     .pad_in   (pio_in[04]),
     .pad_out  (pio_out[04]),
     .pad_oe   (pio_oe[04])
);

cde_pad_se_dig  pio_05_pad(
     .PAD      (PIO[05]),
     .pad_in   (pio_in[05]),
     .pad_out  (pio_out[05]),
     .pad_oe   (pio_oe[05])
);

cde_pad_se_dig  pio_06_pad(
     .PAD      (PIO[06]),
     .pad_in   (pio_in[06]),
     .pad_out  (pio_out[06]),
     .pad_oe   (pio_oe[06])
);


cde_pad_se_dig  pio_07_pad(
     .PAD      (PIO[07]),
     .pad_in   (pio_in[07]),
     .pad_out  (pio_out[07]),
     .pad_oe   (pio_oe[07])
);


cde_pad_se_dig  pio_08_pad(
     .PAD      (PIO[08]),
     .pad_in   (pio_in[08]),
     .pad_out  (pio_out[08]),
     .pad_oe   (pio_oe[08])
);

cde_pad_se_dig  pio_09_pad(
     .PAD      (PIO[09]),
     .pad_in   (pio_in[09]),
     .pad_out  (pio_out[09]),
     .pad_oe   (pio_oe[09])
);
   
cde_pad_se_dig  pio_10_pad(
     .PAD      (PIO[10]),
     .pad_in   (pio_in[10]),
     .pad_out  (pio_out[10]),
     .pad_oe   (pio_oe[10])
);

cde_pad_se_dig  pio_11_pad(
     .PAD      (PIO[11]),
     .pad_in   (pio_in[11]),
     .pad_out  (pio_out[11]),
     .pad_oe   (pio_oe[11])
);

cde_pad_se_dig  pio_12_pad(
     .PAD      (PIO[12]),
     .pad_in   (pio_in[12]),
     .pad_out  (pio_out[12]),
     .pad_oe   (pio_oe[12])
);

cde_pad_se_dig  pio_13_pad(
     .PAD      (PIO[13]),
     .pad_in   (pio_in[13]),
     .pad_out  (pio_out[13]),
     .pad_oe   (pio_oe[13])
);

cde_pad_se_dig  pio_14_pad(
     .PAD      (PIO[14]),
     .pad_in   (pio_in[14]),
     .pad_out  (pio_out[14]),
     .pad_oe   (pio_oe[14])
);

cde_pad_se_dig  pio_15_pad(
     .PAD      (PIO[15]),
     .pad_in   (pio_in[15]),
     .pad_out  (pio_out[15]),
     .pad_oe   (pio_oe[15])
);

cde_pad_se_dig  pio_16_pad(
     .PAD      (PIO[16]),
     .pad_in   (pio_in[16]),
     .pad_out  (pio_out[16]),
     .pad_oe   (pio_oe[16])
);


cde_pad_se_dig  pio_17_pad(
     .PAD      (PIO[17]),
     .pad_in   (pio_in[17]),
     .pad_out  (pio_out[17]),
     .pad_oe   (pio_oe[17])
);


cde_pad_se_dig  pio_18_pad(
     .PAD      (PIO[18]),
     .pad_in   (pio_in[18]),
     .pad_out  (pio_out[18]),
     .pad_oe   (pio_oe[18])
);


cde_pad_se_dig  pio_19_pad(
     .PAD      (PIO[19]),
     .pad_in   (pio_in[19]),
     .pad_out  (pio_out[19]),
     .pad_oe   (pio_oe[19])
);
   


   

cde_pad_se_dig  pio_20_pad(
     .PAD      (PIO[20]),
     .pad_in   (pio_in[20]),
     .pad_out  (pio_out[20]),
     .pad_oe   (pio_oe[20])
);

cde_pad_se_dig  pio_21_pad(
     .PAD      (PIO[21]),
     .pad_in   (pio_in[21]),
     .pad_out  (pio_out[21]),
     .pad_oe   (pio_oe[21])
);

cde_pad_se_dig  pio_22_pad(
     .PAD      (PIO[22]),
     .pad_in   (pio_in[22]),
     .pad_out  (pio_out[22]),
     .pad_oe   (pio_oe[22])
);

cde_pad_se_dig  pio_23_pad(
     .PAD      (PIO[23]),
     .pad_in   (pio_in[23]),
     .pad_out  (pio_out[23]),
     .pad_oe   (pio_oe[23])
);

cde_pad_se_dig  pio_24_pad(
     .PAD      (PIO[24]),
     .pad_in   (pio_in[24]),
     .pad_out  (pio_out[24]),
     .pad_oe   (pio_oe[24])
);

cde_pad_se_dig  pio_25_pad(
     .PAD      (PIO[25]),
     .pad_in   (pio_in[25]),
     .pad_out  (pio_out[25]),
     .pad_oe   (pio_oe[25])
);

cde_pad_se_dig  pio_26_pad(
     .PAD      (PIO[26]),
     .pad_in   (pio_in[26]),
     .pad_out  (pio_out[26]),
     .pad_oe   (pio_oe[26])
);


cde_pad_se_dig  pio_27_pad(
     .PAD      (PIO[27]),
     .pad_in   (pio_in[27]),
     .pad_out  (pio_out[27]),
     .pad_oe   (pio_oe[27])
);


cde_pad_se_dig  pio_28_pad(
     .PAD      (PIO[28]),
     .pad_in   (pio_in[28]),
     .pad_out  (pio_out[28]),
     .pad_oe   (pio_oe[28])
);


cde_pad_se_dig  pio_29_pad(
     .PAD      (PIO[29]),
     .pad_in   (pio_in[29]),
     .pad_out  (pio_out[29]),
     .pad_oe   (pio_oe[29])
);
   


   

cde_pad_se_dig  pio_30_pad(
     .PAD      (PIO[30]),
     .pad_in   (pio_in[30]),
     .pad_out  (pio_out[30]),
     .pad_oe   (pio_oe[30])
);

cde_pad_se_dig  pio_31_pad(
     .PAD      (PIO[31]),
     .pad_in   (pio_in[31]),
     .pad_out  (pio_out[31]),
     .pad_oe   (pio_oe[31])
);

cde_pad_se_dig  pio_32_pad(
     .PAD      (PIO[32]),
     .pad_in   (pio_in[32]),
     .pad_out  (pio_out[32]),
     .pad_oe   (pio_oe[32])
);

cde_pad_se_dig  pio_33_pad(
     .PAD      (PIO[33]),
     .pad_in   (pio_in[33]),
     .pad_out  (pio_out[33]),
     .pad_oe   (pio_oe[33])
);

cde_pad_se_dig  pio_34_pad(
     .PAD      (PIO[34]),
     .pad_in   (pio_in[34]),
     .pad_out  (pio_out[34]),
     .pad_oe   (pio_oe[34])
);

cde_pad_se_dig  pio_35_pad(
     .PAD      (PIO[35]),
     .pad_in   (pio_in[35]),
     .pad_out  (pio_out[35]),
     .pad_oe   (pio_oe[35])
);

cde_pad_se_dig  pio_36_pad(
     .PAD      (PIO[36]),
     .pad_in   (pio_in[36]),
     .pad_out  (pio_out[36]),
     .pad_oe   (pio_oe[36])
);


cde_pad_se_dig  pio_37_pad(
     .PAD      (PIO[37]),
     .pad_in   (pio_in[37]),
     .pad_out  (pio_out[37]),
     .pad_oe   (pio_oe[37])
);


cde_pad_se_dig  pio_38_pad(
     .PAD      (PIO[38]),
     .pad_in   (pio_in[38]),
     .pad_out  (pio_out[38]),
     .pad_oe   (pio_oe[38])
);


cde_pad_se_dig  pio_39_pad(
     .PAD      (PIO[39]),
     .pad_in   (pio_in[39]),
     .pad_out  (pio_out[39]),
     .pad_oe   (pio_oe[39])
);


   

   

   
// Clock System   


wire           ck25MHz;
wire           ck100MHz;
wire           one_usec;
wire           reset;


wire  [15:0]   PosD;
wire  [7:0]    PosL;
wire  [7:0]    PosS;
wire  [3:0]    PosB;



cde_clock_sys  
clock_sys  (
        .a_clk_pad_in   ( a_clk_pad_in ),
        .b_clk_pad_in   ( b_clk_pad_in ),
        .pwron_pad_in   (!cts_pad_in  ),  
        .ckDivOut       ( ck25MHz     ),
        .ckOut          ( ck100MHz    ),
        .one_usec       ( one_usec    ),
        .reset          ( reset       ));
   






  
cde_jtag 
jtag_tap(
		 
        .tdi_1              ( td1              ),
        .tdi_2              ( td2              ),
        .tck_1              ( tck1             ),
        .tck_2              ( tck2             ),
        .tdo_o              ( tdo              ),
        .test_logic_reset_o ( test_logic_reset ),
        .shift_dr_o         ( shift_dr         ),
        .capture_dr_o       ( capture_dr       ),
        .update_dr_o        ( update_dr        ),
        .select_1           ( select1          ),
        .select_2           ( select2          ));



wire [`JTAG_USER1_WIDTH-1:0]  jtag_user1_cap;
wire [`JTAG_USER2_WIDTH-1:0]  jtag_user2_cap;
wire [`JTAG_USER1_WIDTH-1:0]  jtag_user1_upd;
wire [`JTAG_USER2_WIDTH-1:0]  jtag_user2_upd;



cde_jtag_rpc_reg #(`JTAG_USER1_WIDTH,`JTAG_USER1_RESET)
user1_reg
(
    .clk              (tck1             ), 
    .reset            (test_logic_reset ), 
    .tdi              (tdo              ), 
    .select           (select1          ), 
    .tdo              (td1              ), 
    .update_dr        (update_dr        ), 
    .capture_dr       (capture_dr       ), 
    .shift_dr         (shift_dr         ), 
    .capture_value    (jtag_user1_cap   ),
    .update_value     (jtag_user1_upd   )
);


cde_jtag_rpc_reg #(`JTAG_USER2_WIDTH,`JTAG_USER2_RESET)
user2_reg
(
    .clk              (tck2             ), 
    .reset            (test_logic_reset ), 
    .tdi              (tdo              ), 
    .select           (select2          ), 
    .tdo              (td2              ), 
    .update_dr        (update_dr        ), 
    .capture_dr       (capture_dr       ), 
    .shift_dr         (shift_dr         ), 
    .capture_value    (jtag_user2_cap   ), 
    .update_value     (jtag_user2_upd   )
);

wire [23:1]  micro_addr;
wire [15:0]  micro_wdata;
wire [15:0]  micro_rdata;
wire         micro_rd;   
wire  [1:0]  micro_cs;   
wire         micro_wr;   
wire         micro_ub;   
wire         micro_lb;   

flash_memcontrl 
fmc(
    .clk              ( ck25MHz       ),
    .reset            ( reset         ), 
    .addr             ( micro_addr    ), 
    .cs               ( micro_cs      ), 
    .stb              (|micro_cs      ), 
    .rd               ( micro_rd      ), 
    .wr               ( micro_wr      ), 
    .ub               ( micro_ub      ), 
    .lb               ( micro_lb      ),
    .ack              (               ), 
    .rdata            ( micro_rdata   ), 
    .wdata            ( micro_wdata   ), 

    
    .memadr_out       ( memadr_out    ),        
    .memdb_out        ( memdb_out     ),   
    .memdb_oe         ( memdb_oe      ),   
    .memdb_in         ( memdb_in      ),   
    .memoe_n_out      ( memoe_n_out   ),    
    .memwr_n_out      ( memwr_n_out   ),
   
    .ramadv_out_n     ( ramadv_out_n  ),   
    .ramclk_out       ( ramclk_out    ),   
    .ramub_n_out      ( ramub_n_out   ),   
    .ramlb_n_out      ( ramlb_n_out   ),   
    .ramcs_n_out      ( ramcs_n_out   ),
    .ramcre_out       ( ramcre_out    ),   
    .ramwait_in       ( ramwait_in    ),   
    .flashststs_in    ( flashststs_in ),   
    .flashrp_n_out    ( flashrp_n_out ),   
    .flashcs_n_out    ( flashcs_n_out )
   );
   




assign         eppdb_out     =   8'h00;
assign         eppdb_oe      =   1'b0;
assign         eppwait_out   =   1'b0;
assign         eppwait_oe    =   1'b0;
assign         usbwr_out     =   1'b0;
assign         usbwr_oe      =   1'b0;
assign         usbmode_out   =   1'b0;
assign         usbmode_oe    =   1'b0;
assign         usboe_out     =   1'b0;
assign         usboe_oe      =   1'b0;
assign         usbadr_out    =   2'b00;
assign         usbadr_oe     =   1'b0;
assign         usbpktend_out =   1'b0;
assign         usbpktend_oe  =   1'b0;
assign         usbdir_out    =   1'b0;
assign         usbdir_oe     =   1'b0;
assign         usbclk_out    =   1'b0;
assign         usbclk_oe     =   1'b0;
assign         pio_out       =  40'h0000000000;
assign         pio_oe        =  40'h0000000000;

   



`include "../core.v"
   



   
endmodule


