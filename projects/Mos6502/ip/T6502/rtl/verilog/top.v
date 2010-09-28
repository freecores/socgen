
`include "./defines.v"


module `VARIANT #(
    parameter RAM_WORDS         = 2048,        // Number of words	 
    parameter RAM_ADD           = 11,          // Number of address bits 
 
    parameter ROM_WORDS         = 4096,        // Number of words	 
    parameter ROM_ADD           = 12,          // Number of address bits
    parameter ROM_FILE          = "NONE",      // Rom Data file

    parameter PROG_ROM_WORDS    = ROM_WORDS,   // Number of words	 
    parameter PROG_ROM_ADD      = ROM_ADD ,    // Number of address bits	
    parameter PROG_ROM_FILE     = ROM_FILE,    // Rom Data file

    parameter VEC_TABLE         =  8'hff,      // vector table @ ff00->ffff
		  
    parameter TX_FIFO           = 0,
    parameter TX_FIFO_SIZE      = 3,
    parameter TX_FIFO_WORDS     = 8,
    parameter RX_FIFO           = 0,
    parameter RX_FIFO_SIZE      = 3,
    parameter RX_FIFO_WORDS     = 8,  
    parameter STARTUP           = "NONE",
    parameter FONT              = "NONE"



   )  (

input  wire           clk,
input  wire           reset,

output wire   [23:1]  ext_add,
output wire   [15:0]  ext_wdata,
input  wire   [15:0]  ext_rdata,
output wire           ext_ub,
output wire           ext_lb,
output wire           ext_rd,
output wire           ext_wr,
output wire    [1:0]  ext_cs,

       
       
output wire   [7:0]  alu_status,
       
output wire          txd_pad_out,
input  wire          rxd_pad_in,
input  wire          cts_pad_in,
output wire          rts_pad_out,


output wire          ps2_clk_oe,
input  wire          ps2_clk_in,
output wire          ps2_data_oe,
input  wire          ps2_data_in,
      


output wire  [7:0]   gpio_0_out,
output wire  [7:0]   gpio_0_oe,
output wire  [7:0]   gpio_0_lat,
input  wire  [7:0]   gpio_0_in,
output wire  [7:0]   gpio_1_out,
output wire  [7:0]   gpio_1_oe,
output wire  [7:0]   gpio_1_lat,
input  wire  [7:0]   gpio_1_in,
 
input wire   [3:0]   ext_irq_in,     


output wire [2:0]    vgared_pad_out,
output wire [2:0]    vgagreen_pad_out,
output wire [1:0]    vgablue_pad_out,

output wire          hsync_n_pad_out,
output wire          vsync_n_pad_out


      );
   
wire  [7:0]   write_data;
wire [15:0]   addr_pin;
wire [7:0]    pg0_add; 
wire [15:0]   prog_counter;
wire [15:0]   io_rdata;
wire [15:0]   boot_data;
wire [15:0]   prog_data;
wire [15:0]   sram_data;
wire [15:0]   pg0_data;
wire [15:0]   shadow_data;
   
reg [15:0]    din;
wire          dout_oe;
wire          rd_pin;
wire [1:0]    timer_irq;
   
wire          we_pin;

wire          halt;


wire [15:0]   stk_push_data;
wire [15:0]   stk_pull_data;

wire          stk_push;
wire          stk_pull;


   




   

 
   


 reg CS0;
 reg CSD;
 reg CSE;
 reg CSI;   
 reg CSB;
 reg CSP;


   


always@(*)
 begin
 if(addr_pin[15:8] == 8'h00)
   begin
   CS0         = 1'b1;
   end  
 else
   begin
   CS0         = 1'b0;
   end     
 end 

always@(*)
 begin
 if(addr_pin[15:12] == 4'b0000)
   begin
   CSD         = 1'b1;
   end  
 else
   begin
   CSD         = 1'b0;
   end     
 end


always@(*)
 begin
 if(addr_pin[15:14] == 2'b01)
   begin
   CSE         = 1'b1;
   end  
 else
   begin
   CSE         = 1'b0;
   end     
 end



always@(*)
 begin
 if(addr_pin[15:12] == 4'b1000)
   begin
   CSI         = 1'b1;
   end  
 else
   begin
   CSI         = 1'b0;
   end     
 end 


always@(*)
 begin
 if(addr_pin[15:12] == 4'b1111)
   begin
   CSP         = 1'b1;
   end  
 else
   begin
   CSP         = 1'b0;
   end     
 end 





   

   
   
always@(*)
 begin
 if(addr_pin[15:12] == 4'b1100)
   begin
   CSB          = 1'b1;
   end  
 else
   begin
   CSB          = 1'b0;
   end     
 end


 reg CS0_r;
 reg CSD_r;
 reg CSE_r;
 reg CSI_r;   
 reg CSB_r;
 reg CSP_r;

   
always@(*)
if ( CS0_r ) din = pg0_data;
else
if ( CSD_r ) din = sram_data;
else
if ( CSB_r ) din = boot_data;
else
if ( CSI_r ) din = io_rdata;
else
if ( CSP_r ) din = shadow_data;
else       din = ext_rdata;
   



always@(posedge clk)

begin
	  
     CS0_r  <=     CS0;
     CSD_r  <=     CSD;
     CSE_r  <=     CSE;
     CSI_r  <=     CSI;   
     CSB_r  <=     CSB;
     CSP_r  <=     CSP;
   
end 



reg [2:0] enableY;   
reg  enable;




always@(posedge clk)
if(reset || enable) 
   begin
   enable  <= 1'b0;
   enableY <= 3'b000;
   end   
else
if (CSE &&(rd_pin || we_pin))  
   begin
     if(enableY == 3'b100) enable  <= 1'b1;
     else                  enableY <= enableY +3'b001;     
   end
else
   enable <= 1'b1;  

   wire [7:0] vector;
   
   

 `VARIANT`CPU
#(.VEC_TABLE(VEC_TABLE))
cpu  (
     .clk              ( clk           ),
     .reset            ( reset         ),
     .enable           ( enable        ),
     .alu_status       ( alu_status    ),

     .prog_counter     ( prog_counter  ),
     .prog_data        ( prog_data     ),
       
     .pg0_add          ( pg0_add       ),
     .pg0_rd           ( pg0_rd        ),
     .pg0_wr           ( pg0_wr        ),
     .pg0_data         ( pg0_add[0]? pg0_data[15:8]:pg0_data[7:0]) ,
       
     .mem_add          ( addr_pin      ),
     .mem_rdata        ( din           ),
     .mem_wdata        ( write_data    ),
     .mem_rd           ( rd_pin        ),
     .mem_wr           ( we_pin        ),

     .stk_push         ( stk_push      ),
     .stk_push_data    ( stk_push_data ),
     .stk_pull         ( stk_pull      ),
     .stk_pull_data    ( stk_pull_data ),
     .vec_int          ( vector        ),
     .nmi              ( nmi_in        )
    );


   





`CDE`LIFO
#(.WIDTH (16),
  .SIZE  (8),   
  .WORDS (256)
)
stack_ram  
(
    .clk            ( clk           ),
    .reset          ( reset         ),
    .push           ( stk_push      ),
    .din            ( stk_push_data ),
    .pop            ( stk_pull      ),
    .dout           ( stk_pull_data )
);




   

`CDE`SRAM
    #(.WIDTH        (16),
      .ADDR         (ROM_ADD),
      .WORDS        (ROM_WORDS),
      .DEFAULT      (16'hffff),
      .INIT_FILE    (ROM_FILE)
      )   boot_rom  (
      .clk          (clk),          
      .raddr        (addr_pin[ROM_ADD:1]),
      .waddr        (addr_pin[ROM_ADD:1]),		     
      .cs           (CSB),          
      .wr           (1'b0),
      .wdata        (16'h0000),
      .rd           (rd_pin),
      .rdata        (boot_data));


`CDE`SRAM
    #(.WIDTH        (16),
      .ADDR         (PROG_ROM_ADD),
      .WORDS        (PROG_ROM_WORDS),
      .DEFAULT      (16'hffff),
      .INIT_FILE    (PROG_ROM_FILE)
      )   prog_rom  (
      .clk          (clk),          
      .raddr        (prog_counter[PROG_ROM_ADD:1]),
      .waddr        (addr_pin[PROG_ROM_ADD:1]),		     
      .cs           (1'b1),          
      .wr           (we_pin && CSP),
      .wdata        ({write_data,write_data}),
      .rd           (1'b1),
      .rdata        (prog_data));


`CDE`SRAM
    #(.WIDTH        (16),
      .ADDR         (PROG_ROM_ADD),
      .WORDS        (PROG_ROM_WORDS),
      .DEFAULT      (16'hffff),
      .INIT_FILE    (PROG_ROM_FILE)
      )   sh_prog_rom  (
      .clk          (clk),          
      .raddr        (addr_pin[PROG_ROM_ADD:1]),		     
      .waddr        (addr_pin[PROG_ROM_ADD:1]),		     
      .cs           (CSP),          
      .wr           (we_pin),
      .wdata        ({write_data,write_data}),
      .rd           (rd_pin),
      .rdata        (shadow_data));
   



   

   

`CDE`SRAM
    #(.WIDTH        (8),
      .ADDR         (RAM_ADD),
      .WORDS        (RAM_WORDS),
      .DEFAULT      (8'hff)
      )   core_ram_l  (
        .clk        (clk),          	     
        .raddr      (addr_pin[RAM_ADD:1]),
        .waddr      (addr_pin[RAM_ADD:1]),
        .rdata      (sram_data[7:0]),
        .wdata      (write_data),
        .rd         (rd_pin),
        .cs         (CSD && (!addr_pin[0])),
        .wr         (we_pin)
        );


`CDE`SRAM
    #(.WIDTH        (8),
      .ADDR         (RAM_ADD),
      .WORDS        (RAM_WORDS),
      .DEFAULT      (8'hff)
      )   core_ram_h  (
        .clk        (clk),          	     
        .raddr      (addr_pin[RAM_ADD:1]),
        .waddr      (addr_pin[RAM_ADD:1]),
        .rdata      (sram_data[15:8]),
        .wdata      (write_data),
        .rd         (rd_pin),
        .cs         (CSD && ( addr_pin[0])),
        .wr         (we_pin)
        );
   





`CDE`SRAM
    #(.WIDTH        (8),
      .ADDR         (7),
      .WORDS        (128),
      .DEFAULT      (8'hff)
      )   pg00_ram_l  (
        .clk        (clk),          	     
        .raddr      (pg0_add[7:1]),
        .waddr      (pg0_add[7:1]),
        .rdata      (pg0_data[7:0]),
        .wdata      (write_data),
        .rd         (pg0_rd  || (CS0 && rd_pin)   ),
        .cs         (1'b1),
        .wr         ((pg0_wr  || (CS0 && we_pin)) && (!pg0_add[0]) )
        );



`CDE`SRAM
    #(.WIDTH        (8),
      .ADDR         (7),
      .WORDS        (128),
      .DEFAULT      (8'hff)
      )   pg00_ram_h  (
        .clk        (clk),          	     
        .raddr      (pg0_add[7:1]),
        .waddr      (pg0_add[7:1]),
        .rdata      (pg0_data[15:8]),
        .wdata      (write_data),
        .rd         (pg0_rd  || (CS0 && rd_pin)),
        .cs         (1'b1),
        .wr         ((pg0_wr  || (CS0 && we_pin)) && ( pg0_add[0]) )
        );


   
   

   


`IO_MODULE
#(
   .BASE_WIDTH     (0),
   .ADDR_WIDTH     (8),
   .TX_FIFO        (TX_FIFO       ),     
   .TX_FIFO_SIZE   (TX_FIFO_SIZE  ),  
   .TX_FIFO_WORDS  (TX_FIFO_WORDS ),  
   .RX_FIFO        (RX_FIFO       ),  
   .RX_FIFO_SIZE   (RX_FIFO_SIZE  ),  
   .STARTUP        (STARTUP       ),
   .FONT           (FONT          )
)
   
io_module( 
        .clk                ( clk             ),
        .reset              ( reset           ),
        .enable             ( enable          ),
	.cs_i               ( CSI             ),
	.cs_m               ( CSE             ),
        .addr               ( addr_pin[7:0]   ),
	.waddr              ( addr_pin[7:0]   ),   
        .rdata              ( io_rdata        ),
        .wdata              ( write_data      ),
        .rd                 ( rd_pin          ),
        .wr                 ( we_pin          ),
        .pic_irq            (                 ),
        .pic_nmi            (                 ),
	   
        .gpio_0_out         ( gpio_0_out      ),
        .gpio_0_oe          ( gpio_0_oe       ),
        .gpio_0_lat         ( gpio_0_lat      ),
        .gpio_0_in          ( gpio_0_in       ),
        .gpio_1_out         ( gpio_1_out      ),
        .gpio_1_oe          ( gpio_1_oe       ),
        .gpio_1_lat         ( gpio_1_lat      ),
        .gpio_1_in          ( gpio_1_in       ),
        .timer_irq          ( timer_irq       ),
	   
        .txd_pad_out        ( txd_pad_out     ),
        .rxd_pad_in         ( rxd_pad_in      ),
        .cts_pad_in         ( cts_pad_in      ),
        .rts_pad_out        ( rts_pad_out     ),
        .rx_irq             ( rx_irq          ),
	.tx_irq             ( tx_irq          ),
	   
        .ps2_clk_pad_oe     ( ps2_clk_oe      ),
        .ps2_clk_pad_in     ( ps2_clk_in      ),
        .ps2_data_pad_oe    ( ps2_data_oe     ),
        .ps2_data_pad_in    ( ps2_data_in     ),
        .ps2_data_avail     ( ps2_data_avail  ), 
	.ext_irq_in         ({ext_irq_in[2:0],
                              ps2_data_avail,
                              tx_irq,
                              rx_irq,
                              timer_irq}      ),

        .mem_add            ( addr_pin        ),
        .cs_mem             ( CSE             ),
        .ext_add            ( ext_add         ),
        .ext_wdata          ( ext_wdata       ),
        .ext_rdata          ( ext_rdata       ),
        .ext_ub             ( ext_ub          ),
        .ext_lb             ( ext_lb          ),
        .ext_rd             ( ext_rd          ),
        .ext_wr             ( ext_wr          ),
        .ext_cs             ( ext_cs          ),

        .int_out            ( nmi_in          ),
        .vector             ( vector          ),
	   
        .vgared_pad_out     ( vgared_pad_out  ),
        .vgagreen_pad_out   ( vgagreen_pad_out),
        .vgablue_pad_out    ( vgablue_pad_out ),

        .hsync_n_pad_out    ( hsync_n_pad_out ),
        .vsync_n_pad_out    ( vsync_n_pad_out )


      );

 
endmodule






