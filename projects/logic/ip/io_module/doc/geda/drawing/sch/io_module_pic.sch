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
refdes=int_in[7:0]
}
C 2300 1900 1 0 0 in_port.sym  
{
T 2300 1900 5 10 1 1 0 6 1 1 
refdes=wr
}
C 2300 2300 1 0 0 in_port.sym  
{
T 2300 2300 5 10 1 1 0 6 1 1 
refdes=reset
}
C 2300 2700 1 0 0 in_port.sym  
{
T 2300 2700 5 10 1 1 0 6 1 1 
refdes=rd
}
C 2300 3100 1 0 0 in_port.sym  
{
T 2300 3100 5 10 1 1 0 6 1 1 
refdes=cs
}
C 2300 3500 1 0 0 in_port.sym  
{
T 2300 3500 5 10 1 1 0 6 1 1 
refdes=clk
}
C 4600 300  1 0  0 out_port_v.sym
{
T 5600 300 5  10 1 1 0 0 1 1 
refdes=rdata[7:0]
}
C 4600 700  1 0 0 out_port.sym
{
T 5600 700 5  10 1 1 0 0 1 1
refdes=nmi_out
}
C 4600 1100  1 0 0 out_port.sym
{
T 5600 1100 5  10 1 1 0 0 1 1
refdes=irq_out
}
