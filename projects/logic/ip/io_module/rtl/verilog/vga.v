`include "defines.v"

`ifdef VGA

module `VARIANT`VGA
#(parameter BASE_ADDR     = 4'h0,
  parameter BASE_WIDTH    = 4,
  parameter ADDR_WIDTH    = 8,
  parameter STARTUP="NONE",
  parameter FONT="NONE"
 )

( 
input   wire            clk,
input   wire            reset,
input   wire            enable,
input   wire            cs,		      
input   wire            wr,
input   wire            rd,
input   wire   [7:0]    waddr,
input   wire   [7:0]    raddr,
input   wire   [7:0]    wdata,
output  wire   [7:0]    rdata,

output wire [2:0]       vgared_pad_out,
output wire [2:0]       vgagreen_pad_out,
output wire [1:0]       vgablue_pad_out,

output wire             hsync_n_pad_out,
output wire             vsync_n_pad_out
);


wire  [7:0]           lat_wdata;
wire  [7:0]           cntrl;
wire  [7:0]           char_color;
wire  [7:0]           back_color;
wire  [7:0]           cursor_color;

wire  [15:0]          vga_address;
wire                  ascii_load;
wire                  add_l_load;
wire                  add_h_load;   


   
 `VARIANT`VGA_MICRO_REG

#(.BASE_ADDR(BASE_ADDR   ),
  .BASE_WIDTH(BASE_WIDTH ),
  .ADDR_WIDTH(ADDR_WIDTH )    
)
   vga_micro_reg
( 
   .clk                ( clk                ),
   .reset              ( reset              ),
   .enable             ( enable             ),
   .cs                 ( cs                 ),		      
   .wr                 ( wr                 ),
   .rd                 ( rd                 ),
   .waddr              ( waddr              ),
   .raddr              ( raddr              ),
   .wdata              ( wdata              ),
   .rdata              ( rdata              ),
  .lat_wdata           ( lat_wdata          ),
   .cntrl              ( cntrl              ),
   .char_color         ( char_color         ),
   .back_color         ( back_color         ),
   .cursor_color       ( cursor_color       ),
   .vga_address        ( vga_address        ),


   .ascii_load         ( ascii_load         ),
   .add_l_load         ( add_l_load         ),
   .add_h_load         ( add_h_load         )

  );
   



vga_char_ctrl
#(.STARTUP(STARTUP),
  .FONT(FONT)
 )
vga_char_ctrl   
(
     .clk               ( clk                ), 
     .reset             ( reset              ),
  
     .ascii_load        ( ascii_load         ),
     .add_l_load        ( add_l_load         ),
     .add_h_load        ( add_h_load         ),

     .wdata             ( lat_wdata          ),
     .address           ( vga_address[13:0]  ), 
     .char_color        ( char_color         ),
     .back_color        ( back_color         ),
     .cursor_color      ( cursor_color       ),

     .vga_red_pad_out   ( vgared_pad_out    ),
     .vga_green_pad_out ( vgagreen_pad_out  ),
     .vga_blue_pad_out  ( vgablue_pad_out   ),

     .hsync_n_pad_out   ( hsync_n_pad_out   ),
     .vsync_n_pad_out   ( vsync_n_pad_out   )
 
 );



   


   
   
endmodule

`endif //  `ifdef VGA
