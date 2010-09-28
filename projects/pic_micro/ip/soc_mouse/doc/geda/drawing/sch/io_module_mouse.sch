v 20100214 1
C 3400 300 1 0 0 in_port_v.sym   
{
T 3400 300 5 10 1 1 0 6 1 1
refdes=wdata[7:0]
}
C 3400 700 1 0 0 in_port_v.sym   
{
T 3400 700 5 10 1 1 0 6 1 1
refdes=waddr[ADDR_WIDTH-BASE_WIDTH-1:0]
}
C 3400 1100 1 0 0 in_port_v.sym   
{
T 3400 1100 5 10 1 1 0 6 1 1
refdes=ext_irq_in[7:0]
}
C 3400 1500 1 0 0 in_port_v.sym   
{
T 3400 1500 5 10 1 1 0 6 1 1
refdes=addr[ADDR_WIDTH-1:0]
}
C 3400 1900 1 0 0 in_port.sym  
{
T 3400 1900 5 10 1 1 0 6 1 1 
refdes=wr
}
C 3400 2300 1 0 0 in_port.sym  
{
T 3400 2300 5 10 1 1 0 6 1 1 
refdes=rxd_pad_in
}
C 3400 2700 1 0 0 in_port.sym  
{
T 3400 2700 5 10 1 1 0 6 1 1 
refdes=reset
}
C 3400 3100 1 0 0 in_port.sym  
{
T 3400 3100 5 10 1 1 0 6 1 1 
refdes=rd
}
C 3400 3500 1 0 0 in_port.sym  
{
T 3400 3500 5 10 1 1 0 6 1 1 
refdes=ps2_data_in
}
C 3400 3900 1 0 0 in_port.sym  
{
T 3400 3900 5 10 1 1 0 6 1 1 
refdes=ps2_clk_in
}
C 3400 4300 1 0 0 in_port.sym  
{
T 3400 4300 5 10 1 1 0 6 1 1 
refdes=enable
}
C 3400 4700 1 0 0 in_port.sym  
{
T 3400 4700 5 10 1 1 0 6 1 1 
refdes=cts_pad_in
}
C 3400 5100 1 0 0 in_port.sym  
{
T 3400 5100 5 10 1 1 0 6 1 1 
refdes=clk
}
C 6100 300  1 0  0 out_port_v.sym
{
T 7100 300 5  10 1 1 0 0 1 1 
refdes=y_pos[9:0]
}
C 6100 700  1 0  0 out_port_v.sym
{
T 7100 700 5  10 1 1 0 0 1 1 
refdes=x_pos[9:0]
}
C 6100 1100  1 0  0 out_port_v.sym
{
T 7100 1100 5  10 1 1 0 0 1 1 
refdes=rdata[7:0]
}
C 6100 1500  1 0 0 out_port.sym
{
T 7100 1500 5  10 1 1 0 0 1 1
refdes=txd_pad_out
}
C 6100 1900  1 0 0 out_port.sym
{
T 7100 1900 5  10 1 1 0 0 1 1
refdes=tx_irq
}
C 6100 2300  1 0 0 out_port.sym
{
T 7100 2300 5  10 1 1 0 0 1 1
refdes=rx_irq
}
C 6100 2700  1 0 0 out_port.sym
{
T 7100 2700 5  10 1 1 0 0 1 1
refdes=rts_pad_out
}
C 6100 3100  1 0 0 out_port.sym
{
T 7100 3100 5  10 1 1 0 0 1 1
refdes=ps2_data_oe
}
C 6100 3500  1 0 0 out_port.sym
{
T 7100 3500 5  10 1 1 0 0 1 1
refdes=ps2_data_avail
}
C 6100 3900  1 0 0 out_port.sym
{
T 7100 3900 5  10 1 1 0 0 1 1
refdes=ps2_clk_oe
}
C 6100 4300  1 0 0 out_port.sym
{
T 7100 4300 5  10 1 1 0 0 1 1
refdes=pic_nmi
}
C 6100 4700  1 0 0 out_port.sym
{
T 7100 4700 5  10 1 1 0 0 1 1
refdes=pic_irq
}
C 6100 5100  1 0 0 out_port.sym
{
T 7100 5100 5  10 1 1 0 0 1 1
refdes=new_packet
}
C 6100 5500  1 0 0 out_port.sym
{
T 7100 5500 5  10 1 1 0 0 1 1
refdes=ms_right
}
C 6100 5900  1 0 0 out_port.sym
{
T 7100 5900 5  10 1 1 0 0 1 1
refdes=ms_mid
}
C 6100 6300  1 0 0 out_port.sym
{
T 7100 6300 5  10 1 1 0 0 1 1
refdes=ms_left
}
