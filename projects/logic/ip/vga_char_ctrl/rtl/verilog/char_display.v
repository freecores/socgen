`include "defines.v"

module `VARIANT`CHAR_DISPLAY
#(parameter STARTUP="NONE",
  parameter FONT="NONE")

(
input wire          clk,
input wire          reset,
input wire [6:0]    char_column,    // character number on the current line
input wire [6:0]    char_line,      // line number on the screen
input wire [2:0]    subchar_line,   // the line number within a character block 0-8
input wire [2:0]    subchar_pixel,  // the pixel number within a character block 0-8


output wire         cursor_on,   
output wire         pixel_on,                    
 
input wire [13:0]   char_write_addr,
input wire [7:0]    char_write_data,
input wire          char_write_enable

 );
   


reg [13:0]       char_read_addr;


always @ (*) 
     begin
     char_read_addr    = (char_line[6:0] * `H_ACTIVE / 8 ) + char_column[6:0];
     end




// the character generator block includes the character RAM
// and the character generator ROM
`VARIANT`CHAR_GEN 
#(.STARTUP(STARTUP),
  .FONT(FONT))

 CHAR_GEN
(
 .clk                ( clk               ),  
 .reset              ( reset             ),  // reset signal
 .char_write_addr    ( char_write_addr   ),  // write address
 .char_write_data    ( char_write_data   ),  // write data
 .char_write_enable  ( char_write_enable ),  // write enable
 .char_read_addr     ( char_read_addr    ),  // read address of current character
 .subchar_line       ( subchar_line      ),  // current line of pixels within current character
 .subchar_pixel      ( subchar_pixel     ),  // current column of pixels withing current character
 .cursor_on          ( cursor_on         ),  // 
 .pixel_on           ( pixel_on          )   // 
);

endmodule //CHAR_DISPLAY


