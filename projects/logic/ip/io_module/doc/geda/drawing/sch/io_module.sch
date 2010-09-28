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
refdes=gpio_1_in[7:0]
}
C 3400 1500 1 0 0 in_port_v.sym   
{
T 3400 1500 5 10 1 1 0 6 1 1
refdes=gpio_0_in[7:0]
}
C 3400 1900 1 0 0 in_port_v.sym   
{
T 3400 1900 5 10 1 1 0 6 1 1
refdes=ext_irq_in[7:0]
}
C 3400 2300 1 0 0 in_port_v.sym   
{
T 3400 2300 5 10 1 1 0 6 1 1
refdes=addr[ADDR_WIDTH-1:0]
}
C 3400 2700 1 0 0 in_port.sym  
{
T 3400 2700 5 10 1 1 0 6 1 1 
refdes=wr
}
C 3400 3100 1 0 0 in_port.sym  
{
T 3400 3100 5 10 1 1 0 6 1 1 
refdes=rxd_pad_in
}
C 3400 3500 1 0 0 in_port.sym  
{
T 3400 3500 5 10 1 1 0 6 1 1 
refdes=reset
}
C 3400 3900 1 0 0 in_port.sym  
{
T 3400 3900 5 10 1 1 0 6 1 1 
refdes=rd
}
C 3400 4300 1 0 0 in_port.sym  
{
T 3400 4300 5 10 1 1 0 6 1 1 
refdes=ps2_data_in
}
C 3400 4700 1 0 0 in_port.sym  
{
T 3400 4700 5 10 1 1 0 6 1 1 
refdes=ps2_clk_in
}
C 3400 5100 1 0 0 in_port.sym  
{
T 3400 5100 5 10 1 1 0 6 1 1 
refdes=enable
}
C 3400 5500 1 0 0 in_port.sym  
{
T 3400 5500 5 10 1 1 0 6 1 1 
refdes=cts_pad_in
}
C 3400 5900 1 0 0 in_port.sym  
{
T 3400 5900 5 10 1 1 0 6 1 1 
refdes=clk
}
C 6200 300  1 0  0 out_port_v.sym
{
T 7200 300 5  10 1 1 0 0 1 1 
refdes=y_pos[9:0]
}
C 6200 700  1 0  0 out_port_v.sym
{
T 7200 700 5  10 1 1 0 0 1 1 
refdes=x_pos[9:0]
}
C 6200 1100  1 0  0 out_port_v.sym
{
T 7200 1100 5  10 1 1 0 0 1 1 
refdes=timer_irq[1:0]
}
C 6200 1500  1 0  0 out_port_v.sym
{
T 7200 1500 5  10 1 1 0 0 1 1 
refdes=rdata[7:0]
}
C 6200 1900  1 0  0 out_port_v.sym
{
T 7200 1900 5  10 1 1 0 0 1 1 
refdes=gpio_1_out[7:0]
}
C 6200 2300  1 0  0 out_port_v.sym
{
T 7200 2300 5  10 1 1 0 0 1 1 
refdes=gpio_1_oe[7:0]
}
C 6200 2700  1 0  0 out_port_v.sym
{
T 7200 2700 5  10 1 1 0 0 1 1 
refdes=gpio_1_lat[7:0]
}
C 6200 3100  1 0  0 out_port_v.sym
{
T 7200 3100 5  10 1 1 0 0 1 1 
refdes=gpio_0_out[7:0]
}
C 6200 3500  1 0  0 out_port_v.sym
{
T 7200 3500 5  10 1 1 0 0 1 1 
refdes=gpio_0_oe[7:0]
}
C 6200 3900  1 0  0 out_port_v.sym
{
T 7200 3900 5  10 1 1 0 0 1 1 
refdes=gpio_0_lat[7:0]
}
C 6200 4300  1 0 0 out_port.sym
{
T 7200 4300 5  10 1 1 0 0 1 1
refdes=txd_pad_out
}
C 6200 4700  1 0 0 out_port.sym
{
T 7200 4700 5  10 1 1 0 0 1 1
refdes=tx_irq
}
C 6200 5100  1 0 0 out_port.sym
{
T 7200 5100 5  10 1 1 0 0 1 1
refdes=rx_irq
}
C 6200 5500  1 0 0 out_port.sym
{
T 7200 5500 5  10 1 1 0 0 1 1
refdes=rts_pad_out
}
C 6200 5900  1 0 0 out_port.sym
{
T 7200 5900 5  10 1 1 0 0 1 1
refdes=ps2_data_oe
}
C 6200 6300  1 0 0 out_port.sym
{
T 7200 6300 5  10 1 1 0 0 1 1
refdes=ps2_data_avail
}
C 6200 6700  1 0 0 out_port.sym
{
T 7200 6700 5  10 1 1 0 0 1 1
refdes=ps2_clk_oe
}
C 6200 7100  1 0 0 out_port.sym
{
T 7200 7100 5  10 1 1 0 0 1 1
refdes=pic_nmi
}
C 6200 7500  1 0 0 out_port.sym
{
T 7200 7500 5  10 1 1 0 0 1 1
refdes=pic_irq
}
C 6200 7900  1 0 0 out_port.sym
{
T 7200 7900 5  10 1 1 0 0 1 1
refdes=new_packet
}
C 6200 8300  1 0 0 out_port.sym
{
T 7200 8300 5  10 1 1 0 0 1 1
refdes=ms_right
}
C 6200 8700  1 0 0 out_port.sym
{
T 7200 8700 5  10 1 1 0 0 1 1
refdes=ms_mid
}
C 6200 9100  1 0 0 out_port.sym
{
T 7200 9100 5  10 1 1 0 0 1 1
refdes=ms_left
}
