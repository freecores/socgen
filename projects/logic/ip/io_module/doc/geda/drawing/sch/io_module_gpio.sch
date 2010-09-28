v 20100214 1
C 2300 300 1 0 0 in_port_v.sym   
{
T 2300 300 5 10 1 1 0 6 1 1
refdes=wdata[7:0]
}
C 2300 700 1 0 0 in_port_v.sym   
{
T 2300 700 5 10 1 1 0 6 1 1
refdes=waddr[ADDR_WIDTH-1:0]
}
C 2300 1100 1 0 0 in_port_v.sym   
{
T 2300 1100 5 10 1 1 0 6 1 1
refdes=raddr[ADDR_WIDTH-1:0]
}
C 2300 1500 1 0 0 in_port_v.sym   
{
T 2300 1500 5 10 1 1 0 6 1 1
refdes=gpio_1_in[7:0]
}
C 2300 1900 1 0 0 in_port_v.sym   
{
T 2300 1900 5 10 1 1 0 6 1 1
refdes=gpio_0_in[7:0]
}
C 2300 2300 1 0 0 in_port.sym  
{
T 2300 2300 5 10 1 1 0 6 1 1 
refdes=wr
}
C 2300 2700 1 0 0 in_port.sym  
{
T 2300 2700 5 10 1 1 0 6 1 1 
refdes=reset
}
C 2300 3100 1 0 0 in_port.sym  
{
T 2300 3100 5 10 1 1 0 6 1 1 
refdes=rd
}
C 2300 3500 1 0 0 in_port.sym  
{
T 2300 3500 5 10 1 1 0 6 1 1 
refdes=cs
}
C 2300 3900 1 0 0 in_port.sym  
{
T 2300 3900 5 10 1 1 0 6 1 1 
refdes=clk
}
C 5100 300  1 0  0 out_port_v.sym
{
T 6100 300 5  10 1 1 0 0 1 1 
refdes=rdata[7:0]
}
C 5100 700  1 0  0 out_port_v.sym
{
T 6100 700 5  10 1 1 0 0 1 1 
refdes=gpio_1_out[7:0]
}
C 5100 1100  1 0  0 out_port_v.sym
{
T 6100 1100 5  10 1 1 0 0 1 1 
refdes=gpio_1_oe[7:0]
}
C 5100 1500  1 0  0 out_port_v.sym
{
T 6100 1500 5  10 1 1 0 0 1 1 
refdes=gpio_1_lat[7:0]
}
C 5100 1900  1 0  0 out_port_v.sym
{
T 6100 1900 5  10 1 1 0 0 1 1 
refdes=gpio_0_out[7:0]
}
C 5100 2300  1 0  0 out_port_v.sym
{
T 6100 2300 5  10 1 1 0 0 1 1 
refdes=gpio_0_oe[7:0]
}
C 5100 2700  1 0  0 out_port_v.sym
{
T 6100 2700 5  10 1 1 0 0 1 1 
refdes=gpio_0_lat[7:0]
}
