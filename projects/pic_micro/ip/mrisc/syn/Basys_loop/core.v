



   

   // Declare I/O Port connections
wire [7:0]	porta; // I/O Port A
wire [7:0]	portb; // I/O Port B
wire [7:0]	portc; // I/O Port C

wire [7:0]	portain;
wire [7:0]	portbin;
wire [7:0]	portcin;

wire [7:0]	portaout;
wire [7:0]	portbout;
wire [7:0]	portcout;

wire [7:0]	trisa;
wire [7:0]	trisb;
wire [7:0]	trisc;

// Declare ROM and rom signals
wire [10:0]	inst_addr;
wire [11:0]	inst_data;



wire clk = ck25MHz;


assign   jtag_user1_cap =  jtag_user1_upd;
assign   jtag_user2_cap =  PosS;




assign      vgared_pad_out   = 3'b000;
assign      vgagreen_pad_out = 3'b000;
assign      vgablue_pad_out  = 2'b00;
assign      hsync_pad_out    = 1'b0;
assign      vsync_pad_out    = 1'b0;




   


   
assign   ja_1_pad_out  = ck25MHz;
assign   ja_2_pad_out  = reset;
assign   ja_3_pad_out  = one_usec;
assign   ja_4_pad_out  = 1'b0    ;

assign   jb_1_pad_out  = 1'b0;
assign   jb_2_pad_out  = 1'b0;
assign   jb_3_pad_out  = 1'b0;
assign   jb_4_pad_out  = 1'b0;

assign   jc_1_pad_out  = 1'b1;
assign   jc_2_pad_out  = 1'b0;
assign   jc_3_pad_out  = 1'b1;
assign   jc_4_pad_out  = 1'b0;








// Instantiate one CPU to be tested.
mrisc cpu(
   .clk		(clk),
   .rst_in	(reset),
   .inst_addr	(inst_addr),
   .inst_data	(inst_data),

   .portain	(portaout),
   .portbin	(portbout),
   .portcin	(portcout),

   .portaout	(portaout),
   .portbout	(portbout),
   .portcout	(portcout),

   .trisa	(trisa),
   .trisb	(trisb),
   .trisc	(trisc),
   
   .tcki	(1'b0),
   .wdt_en	(1'b0)

   );





// Instantiate the Program ROM.
cde_sram
#(

.WORDS(  `ROM_WORDS), 
.ADDR(  `ROM_ADDR  ),  
.WIDTH (  `ROM_WIDTH ), 
.INIT_FILE(`ROM_FILE)
)


 sram (
   .clk		(clk),
   .raddr	(inst_addr),
   .waddr      (inst_addr),
   .rd          (1'b1),
   .cs          (1'b1),
   .wr		(1'b0),		
   .wdata	(12'b000000000000),	
   .rdata	(inst_data)
);


assign  ps2_data_pad_oe  = 1'b0;
assign  ps2_clk_pad_oe   = 1'b0;


assign PosD  = {portcout,portbout};
assign PosL  = portaout;



disp_io 
disp_io (
        .clk              (ck25MHz),
        .reset            (reset),
        .PosD             (PosD),
        .PosL             (PosL),
        .PosB             (PosB),
        .PosS             (PosS),
        .dp_pad_out       (dp_pad_out),
        .led_pad_out      (led_pad_out[7:0]),
        .seg_pad_out      (seg_pad_out[6:0]),
        .an_pad_out       (an_pad_out[3:0]),
        .sw_pad_in        (sw_pad_in[7:0]),
        .btn_pad_in       (btn_pad_in[3:0])
        );





   