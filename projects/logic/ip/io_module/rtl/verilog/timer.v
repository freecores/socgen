`include "defines.v"

`ifdef TIMER


module `VARIANT`TIMER
#(parameter BASE_ADDR     = 4'h0,
  parameter BASE_WIDTH    = 4,
  parameter ADDR_WIDTH    = 8,
  parameter TIMERS        = 2
 )(
		       
input   wire                        clk,
input   wire                        reset,
input   wire                        enable,
input   wire                        cs,
input   wire                        wr,		       
input   wire                        rd,
input   wire   [ADDR_WIDTH-1:0]     waddr,
input   wire   [ADDR_WIDTH-1:0]     raddr,
   
input   wire   [7:0]                wdata,
output  reg    [7:0]                rdata,
output  reg    [TIMERS-1:0]         irq

);



   

   

parameter TIMER_0_START  = 4'h0;
parameter TIMER_0_COUNT  = 4'h2;
parameter TIMER_0_END    = 4'h4;

parameter TIMER_1_START  = 4'h8;
parameter TIMER_1_COUNT  = 4'hA;
parameter TIMER_1_END    = 4'hC;
   

   

   
parameter IDLE         = 3'b001;
parameter RUNNING      = 3'b010;
parameter TRIGGERED    = 3'b100;


   
reg 		        was;
reg 		        ras;


always@(*)     was = (waddr[ADDR_WIDTH-1:ADDR_WIDTH-BASE_WIDTH] == BASE_ADDR);
always@(*)     ras = (raddr[ADDR_WIDTH-1:ADDR_WIDTH-BASE_WIDTH] == BASE_ADDR);

   

reg [7:0] count_0;
reg [2:0] state_0;

reg [7:0] count_1;
reg [2:0] state_1;   


always@(*)
  if(rd && cs && ras)
    begin
    case(raddr[3:0])
    TIMER_0_START:     rdata  = {4'h0,irq[0],state_0[2:0]};
    TIMER_0_COUNT:     rdata  =  count_0[7:0];
    TIMER_1_START:     rdata  = {4'h0,irq[1],state_1[2:0]};
    TIMER_1_COUNT:     rdata  =  count_1[7:0];
    default:           rdata  = 8'h00;
    endcase
    end
  else
    begin
                       rdata  = 8'hFF;
    end   
   
   


`VARIANT`TIMER_MICRO_REG
#(.BASE_ADDR     (BASE_ADDR),
  .BASE_WIDTH    (BASE_WIDTH),
  .ADDR_WIDTH    (ADDR_WIDTH)
 )
io_module_timer_micro_reg
(
	  .clk      ( clk   ),
          .reset    ( reset ),
          .cs       ( cs    ),
          .wr       ( wr    ),		       
          .rd       ( rd    ),
          .waddr    ( waddr ),
          .raddr    ( raddr ),
          .wdata    ( wdata ),
          .rdata    (       ),
          .start_0  ({4'h0,irq[0],state_0[2:0]} ),
          .count_0  ( count_0  ),
          .start_1  ({4'h0,irq[1],state_1[2:0]} ),
          .count_1  ( count_1  )   
);





   

always@(posedge clk)
if(reset)
  begin
  irq <= 2'b00; 
  end
else
  begin
  irq <= {state_1[2],state_0[2]}; 
  end
  



always@(posedge clk)
if (reset) 
  begin
  state_0 <= IDLE;
  count_0 <= 8'h00;
  end
else 
case (state_0)  
     (IDLE):        
        
     if(wr && was && cs && waddr[3:0] == TIMER_0_START) 
         begin
         state_0 <= RUNNING;
         count_0 <= wdata;	    
	 end
     else 
         begin
         state_0 <= IDLE;
         count_0 <= 8'h00;
	 end
  
     (RUNNING):     
      if( count_0 == 8'h00)      
         begin
         state_0 <= TRIGGERED;
	 count_0 <= 8'h00;   
	 end
      else     
         begin
         state_0 <= RUNNING;
         count_0 <=  count_0 -8'h01;	    
	 end

     (TRIGGERED):   
     if(wr && was && cs && waddr[3:0] == TIMER_0_END) 
         begin
         state_0 <= IDLE;
         count_0 <= 8'h00;	    
	 end
     else   
         begin
         state_0 <= TRIGGERED;
         count_0 <= 8'h00;	    
	 end

     default: 
          begin
          state_0 <= IDLE;
          count_0 <= 8'h00;	     
          end
endcase // case (state_0)





always@(posedge clk)
if (reset) 
  begin
  state_1 <= IDLE;
  count_1 <= 8'h00;
  end
else 
case (state_1)  
     (IDLE):        
        
     if(wr && was && cs && waddr[3:0] == TIMER_1_START) 
         begin
         state_1 <= RUNNING;
         count_1 <= wdata;	    
	 end
     else 
         begin
         state_1 <= IDLE;
         count_1 <= 8'h00;
	 end
  
     (RUNNING):     
      if( count_1 == 8'h00)      
         begin
         state_1 <= TRIGGERED;
	 count_1 <= 8'h00;   
	 end
      else     
         begin
         state_1 <= RUNNING;
         count_1 <=  count_1 -8'h01;	    
	 end

     (TRIGGERED):   
     if(wr && was && cs && waddr[3:0] == TIMER_1_END) 
         begin
         state_1 <= IDLE;
         count_1 <= 8'h00;	    
	 end
     else   
         begin
         state_1 <= TRIGGERED;
         count_1 <= 8'h00;	    
	 end

     default: 
          begin
          state_1 <= IDLE;
          count_1 <= 8'h00;	     
          end
endcase
   






endmodule

`endif //  `ifdef TIMER
