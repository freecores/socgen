v 20100214 1
C 1200 300 1 0 0 in_port_v.sym   
{
T 1200 300 5 10 1 1 0 6 1 1
refdes=wdata[7:0]
}
C 1200 700 1 0 0 in_port_v.sym   
{
T 1200 700 5 10 1 1 0 6 1 1
refdes=waddr[7:0]
}
C 1200 1100 1 0 0 in_port_v.sym   
{
T 1200 1100 5 10 1 1 0 6 1 1
refdes=raddr[7:0]
}
C 1200 1500 1 0 0 in_port.sym  
{
T 1200 1500 5 10 1 1 0 6 1 1 
refdes=wr
}
C 1200 1900 1 0 0 in_port.sym  
{
T 1200 1900 5 10 1 1 0 6 1 1 
refdes=rxd_pad_in
}
C 1200 2300 1 0 0 in_port.sym  
{
T 1200 2300 5 10 1 1 0 6 1 1 
refdes=reset
}
C 1200 2700 1 0 0 in_port.sym  
{
T 1200 2700 5 10 1 1 0 6 1 1 
refdes=rd
}
C 1200 3100 1 0 0 in_port.sym  
{
T 1200 3100 5 10 1 1 0 6 1 1 
refdes=cts_pad_in
}
C 1200 3500 1 0 0 in_port.sym  
{
T 1200 3500 5 10 1 1 0 6 1 1 
refdes=cs
}
C 1200 3900 1 0 0 in_port.sym  
{
T 1200 3900 5 10 1 1 0 6 1 1 
refdes=clk
}
C 3600 300  1 0  0 out_port_v.sym
{
T 4600 300 5  10 1 1 0 0 1 1 
refdes=rdata[7:0]
}
C 3600 700  1 0 0 out_port.sym
{
T 4600 700 5  10 1 1 0 0 1 1
refdes=txd_pad_out
}
C 3600 1100  1 0 0 out_port.sym
{
T 4600 1100 5  10 1 1 0 0 1 1
refdes=tx_irq
}
C 3600 1500  1 0 0 out_port.sym
{
T 4600 1500 5  10 1 1 0 0 1 1
refdes=rx_irq
}
C 3600 1900  1 0 0 out_port.sym
{
T 4600 1900 5  10 1 1 0 0 1 1
refdes=rts_pad_out
}
