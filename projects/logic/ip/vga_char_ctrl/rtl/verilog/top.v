`include "defines.v"

//----------------------------------------------------------------------------
// user_logic.v - module
//----------------------------------------------------------------------------
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//----------------------------------------------------------------------------

module `VARIANT
#(parameter STARTUP="NONE",
  parameter FONT="NONE",
  parameter CHARACTER_DECODE_DELAY=4
 )
(

input  wire                 clk, // 25MHz  CLOCK
input  wire                 reset,                    

input  wire                 ascii_load,
input  wire                 add_l_load,
input  wire                 add_h_load,

input  wire  [7:0]          wdata,
output  reg [13:0]          address,

input  wire  [7:0]          char_color,
input  wire  [7:0]          back_color,
input  wire  [7:0]          cursor_color,
 
output wire  [2:0]          vga_red_pad_out,
output wire  [2:0]          vga_green_pad_out,
output wire  [1:0]          vga_blue_pad_out,

output wire                 hsync_n_pad_out,
output wire                 vsync_n_pad_out
 
 );
   


// internal video timing signals
wire                     h_synch;            // horizontal synch for VGA connector
wire                     v_synch;            // vertical synch for VGA connector
wire                     blank;                        // composite blanking
wire [10:0]              pixel_count;         // bit mapped pixel position within the lin
wire [9:0]               line_count;  // bit mapped line number in a frame lines within the frame
wire [2:0]               subchar_pixel;// pixel position within the character
wire [2:0]               subchar_line;  // identifies the line number within a character block
wire [6:0]               char_column;    // character number on the current line
wire [6:0]               char_line;       // line number on the screen

wire                     pixel_on;
wire                     cursor_on;
   



   
always@(posedge clk)
  if(reset)       address <= 14'b00000000000000;
  else
  if(add_l_load)  address[7:0] <= wdata;
  else
  if(add_h_load)  address[13:8] <= wdata[5:0];   
  else
  if(ascii_load)  address  <= address+ 14'b0000000000001;   
  else            address  <= address;   


   
// instantiate the character generator
`VARIANT`CHAR_DISPLAY 
#(.STARTUP(STARTUP),
  .FONT(FONT))
 CHAR_DISPLAY
  (
  .clk               ( clk           ),
  .reset             ( reset         ),
  .char_column       ( char_column   ),
  .char_line         ( char_line     ),
  .subchar_line      ( subchar_line  ),
  .subchar_pixel     ( subchar_pixel ),
  .pixel_on          ( pixel_on      ),
  .cursor_on         ( cursor_on     ),
  .char_write_addr   ( address       ),
  .char_write_data   ( wdata         ),
  .char_write_enable ( ascii_load    )
);

// instantiate the video timing generator
`VARIANT`SVGA_TIMING_GENERATION 
 #(.CHARACTER_DECODE_DELAY(CHARACTER_DECODE_DELAY))
 SVGA_TIMING_GENERATION
(
  .clk            ( clk          ),
  .reset          ( reset        ),
  .h_synch        ( h_synch      ),
  .v_synch        ( v_synch      ),
  .blank          ( blank        ),
  .pixel_count    ( pixel_count  ),
  .line_count     ( line_count   ),
  .subchar_pixel  ( subchar_pixel),
  .subchar_line   ( subchar_line ),
  .char_column    ( char_column  ),
  .char_line      ( char_line    )
);

// instantiate the video output mux
`VARIANT`VIDEO_OUT 
 VIDEO_OUT
(
  .clk                ( clk             ),
  .reset              ( reset           ),
  .h_synch            ( h_synch         ),
  .v_synch            ( v_synch         ),
  .blank              ( blank           ),
  .char_color         ( char_color      ),
  .back_color         ( back_color      ),
  .cursor_color       ( cursor_color    ),
  .pixel_on           ( pixel_on        ),
  .cursor_on          ( cursor_on       ),
  .hsync_n_pad_out    ( hsync_n_pad_out ),
  .vsync_n_pad_out    ( vsync_n_pad_out ),
  .vga_red_pad_out    ( vga_red_pad_out ),
  .vga_green_pad_out  ( vga_green_pad_out   ),
  .vga_blue_pad_out   ( vga_blue_pad_out    )
);


   

   
endmodule // MAIN
