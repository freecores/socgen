`include "defines.v"

module `VARIANT`CHAR_GEN
#(parameter STARTUP="NONE",
parameter FONT="NONE")
(

input wire           clk, 
input wire           reset,
input wire [13:0]    char_write_addr,
input wire [7:0]     char_write_data,
input wire           char_write_enable,
input wire [13:0]    char_read_addr,               // character address "0" is upper left character
input wire [2:0]     subchar_line,               // line number within 8 line block

input wire [2:0]     subchar_pixel,               // pixel position within 8 pixel block   

output reg           pixel_on, 
output reg           cursor_on 
			 );
   

			 
reg                   latch_data;
reg                   latch_low_data;
reg                   shift_high;
reg                   shift_low;
reg [3:0]             latched_low_char_data;
reg [7:0]             latched_char_data;


wire [7:0]            ascii_code;
wire [10:0]           chargen_rom_address = {ascii_code[7:0], subchar_line[2:0]};
wire [7:0]            char_gen_rom_data;




always @ (posedge clk )
   if (reset)    cursor_on <=  1'b0;
   else          cursor_on <= (char_read_addr ==  char_write_addr) ;

   
cde_sram  #(
    .ADDR        (13),      
    .WIDTH       (8),       
    .WORDS       (4800),    
    .INIT_FILE   (STARTUP)
  )  
char_ram
(
      .clk       ( clk                  ),
      .cs        (1'b1                  ),      
      .waddr     ( char_write_addr[12:0]),
      .raddr     ( char_read_addr[12:0] ),
      .wr        ( char_write_enable    ),
      .rd        (1'b1                  ),
      .wdata     ( char_write_data      ),      
      .rdata     ( ascii_code[7:0]      )
  );


   


// instantiate the character generator ROM

   
cde_sram  #(
    .ADDR        (11),      
    .WIDTH       (8),       
    .WORDS       (1152),    
    .INIT_FILE   (FONT)
  )  
char_gen_rom
(
      .clk       ( clk      ),
      .cs        (1'b1              ),      
      .waddr     (11'b00000000000 ),
      .raddr     ( chargen_rom_address),
      .wr        (1'b0              ),
      .rd        (1'b1              ),
      .wdata     (8'h00             ),      
      .rdata     ( char_gen_rom_data[7:0]  )
  );




   
// LATCH THE CHARTACTER DATA FROM THE CHAR GEN ROM AND CREATE A SERIAL CHAR DATA STREAM
always @ (posedge clk )begin
               if (reset) begin
                    latch_data <= 1'b0;
                    end
               else if (subchar_pixel == 3'b110) begin
                    latch_data <= 1'b1;
                    end
               else if (subchar_pixel == 3'b111) begin
                    latch_data <= 1'b0;
                    end
               end

always @ (posedge clk )begin
               if (reset) begin
                    latch_low_data <= 1'b0;
                    end
               else if (subchar_pixel == 3'b010) begin
                    latch_low_data <= 1'b1;
                    end
               else if (subchar_pixel == 3'b011) begin
                    latch_low_data <= 1'b0;
                    end
               end

always @ (posedge clk )begin
               if (reset) begin
                    shift_high <= 1'b1;
                    end
               else if (subchar_pixel == 3'b011) begin
                    shift_high <= 1'b0;
                    end
               else if (subchar_pixel == 3'b111) begin
                    shift_high <= 1'b1;
                    end
               end

always @ (posedge clk )begin
               if (reset) begin
                    shift_low <= 1'b0;
                    end
               else if (subchar_pixel == 3'b011) begin
                    shift_low <= 1'b1;
                    end
               else if (subchar_pixel == 3'b111) begin
                    shift_low <= 1'b0;
                    end
               end

// serialize the CHARACTER MODE data
always @ (posedge clk ) begin
     if (reset)
           begin
               pixel_on              <= 1'b0;
               latched_low_char_data <= 4'h0;
               latched_char_data     <= 8'h00;
          end

     else if (shift_high)
          begin
               pixel_on              <= latched_char_data [7];
               latched_char_data [7] <= latched_char_data [6];
               latched_char_data [6] <= latched_char_data [5];
               latched_char_data [5] <= latched_char_data [4];
               latched_char_data [4] <= latched_char_data [7];
                    if(latch_low_data) begin
                         latched_low_char_data [3:0] <= latched_char_data [3:0];
                         end
                    else begin
                         latched_low_char_data [3:0] <= latched_low_char_data [3:0];
                         end
               end

     else if (shift_low)
          begin
               pixel_on                  <= latched_low_char_data [3];
               latched_low_char_data [3] <= latched_low_char_data [2];
               latched_low_char_data [2] <= latched_low_char_data [1];
               latched_low_char_data [1] <= latched_low_char_data [0];
               latched_low_char_data [0] <= latched_low_char_data [3];
               if  (latch_data)   latched_char_data [7:0] <= char_gen_rom_data[7:0];
               else               latched_char_data [7:0] <= latched_char_data [7:0];
          end
      else 
          begin
          latched_low_char_data [3:0]  <= latched_low_char_data [3:0];
          latched_char_data [7:0]      <= latched_char_data [7:0];
          pixel_on                     <= pixel_on;
          end
     end

endmodule //CHAR_GEN

