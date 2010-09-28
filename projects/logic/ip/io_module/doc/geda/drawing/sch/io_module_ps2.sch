v 20100214 1
C 1300 300 1 0 0 in_port_v.sym   
{
T 1300 300 5 10 1 1 0 6 1 1
refdes=wdata[7:0]
}
C 1300 700 1 0 0 in_port_v.sym   
{
T 1300 700 5 10 1 1 0 6 1 1
refdes=waddr[7:0]
}
C 1300 1100 1 0 0 in_port_v.sym   
{
T 1300 1100 5 10 1 1 0 6 1 1
refdes=raddr[7:0]
}
C 1300 1500 1 0 0 in_port.sym  
{
T 1300 1500 5 10 1 1 0 6 1 1 
refdes=wr
}
C 1300 1900 1 0 0 in_port.sym  
{
T 1300 1900 5 10 1 1 0 6 1 1 
refdes=reset
}
C 1300 2300 1 0 0 in_port.sym  
{
T 1300 2300 5 10 1 1 0 6 1 1 
refdes=rd
}
C 1300 2700 1 0 0 in_port.sym  
{
T 1300 2700 5 10 1 1 0 6 1 1 
refdes=ps2_data_in
}
C 1300 3100 1 0 0 in_port.sym  
{
T 1300 3100 5 10 1 1 0 6 1 1 
refdes=ps2_clk_in
}
C 1300 3500 1 0 0 in_port.sym  
{
T 1300 3500 5 10 1 1 0 6 1 1 
refdes=cs
}
C 1300 3900 1 0 0 in_port.sym  
{
T 1300 3900 5 10 1 1 0 6 1 1 
refdes=clk
}
C 4000 300  1 0  0 out_port_v.sym
{
T 5000 300 5  10 1 1 0 0 1 1 
refdes=y_pos[9:0]
}
C 4000 700  1 0  0 out_port_v.sym
{
T 5000 700 5  10 1 1 0 0 1 1 
refdes=x_pos[9:0]
}
C 4000 1100  1 0  0 out_port_v.sym
{
T 5000 1100 5  10 1 1 0 0 1 1 
refdes=rdata[7:0]
}
C 4000 1500  1 0 0 out_port.sym
{
T 5000 1500 5  10 1 1 0 0 1 1
refdes=rcv_data_avail
}
C 4000 1900  1 0 0 out_port.sym
{
T 5000 1900 5  10 1 1 0 0 1 1
refdes=ps2_data_oe
}
C 4000 2300  1 0 0 out_port.sym
{
T 5000 2300 5  10 1 1 0 0 1 1
refdes=ps2_clk_oe
}
C 4000 2700  1 0 0 out_port.sym
{
T 5000 2700 5  10 1 1 0 0 1 1
refdes=new_packet
}
C 4000 3100  1 0 0 out_port.sym
{
T 5000 3100 5  10 1 1 0 0 1 1
refdes=ms_right
}
C 4000 3500  1 0 0 out_port.sym
{
T 5000 3500 5  10 1 1 0 0 1 1
refdes=ms_mid
}
C 4000 3900  1 0 0 out_port.sym
{
T 5000 3900 5  10 1 1 0 0 1 1
refdes=ms_left
}
