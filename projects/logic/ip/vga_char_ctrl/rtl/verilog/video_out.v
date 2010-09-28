`include "defines.v"


module `VARIANT`VIDEO_OUT
(


input   wire        clk,
input   wire        reset,
input   wire        h_synch,
input   wire        v_synch,
input   wire        blank,
input   wire        pixel_on,
input   wire        cursor_on,
 
input   wire [7:0]  char_color,
input   wire [7:0]  cursor_color,
input   wire [7:0]  back_color,
 
output   reg        hsync_n_pad_out,
output   reg        vsync_n_pad_out,
output   reg  [2:0] vga_red_pad_out,
output   reg  [2:0] vga_green_pad_out,
output   reg  [1:0] vga_blue_pad_out

 );
   



   
// make the external video connections
always @ (posedge clk ) begin
     if (reset) begin
          // shut down the video output during reset
          hsync_n_pad_out                <= 1'b1;
          vsync_n_pad_out                <= 1'b1;
     end
     
     else begin
          // output color data otherwise
          hsync_n_pad_out                <= !h_synch;
          vsync_n_pad_out                <= !v_synch;
     end
end




   
// make the external video connections
always @ (posedge clk ) 
     begin
     if (reset) 
        begin
        // shut down the video output during reset
        vga_red_pad_out     <=    3'b000;
        vga_green_pad_out   <=    3'b000;
        vga_blue_pad_out    <=    2'b00;	
        end
     
     else 
     if (blank) 
        begin
        // output black during the blank signal
        vga_red_pad_out     <=    3'b000;
        vga_green_pad_out   <=    3'b000;
        vga_blue_pad_out    <=    2'b00;	
        end

     else 
     if (cursor_on) 
        begin
        // output black during the blank signal
        vga_red_pad_out     <=    cursor_color[7:5];
        vga_green_pad_out   <=    cursor_color[4:2];
        vga_blue_pad_out    <=    cursor_color[1:0];
        end

     else 
     if (pixel_on) 
        begin
        // output black during the blank signal
        vga_red_pad_out     <=    char_color[7:5];
        vga_green_pad_out   <=    char_color[4:2];
        vga_blue_pad_out    <=    char_color[1:0];
        end
     else 
        begin
        // output black during the blank signal
        vga_red_pad_out     <=    back_color[7:5];
        vga_green_pad_out   <=    back_color[4:2];
        vga_blue_pad_out    <=    back_color[1:0];
        end     
     end


   
   
endmodule // VIDEO_OUT