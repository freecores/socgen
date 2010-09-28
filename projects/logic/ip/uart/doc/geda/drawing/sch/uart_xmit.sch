v 20100214 1
C 2300 300 1 0 0 in_port_v.sym   
{
T 2300 300 5 10 1 1 0 6 1 1
refdes=txd_data_in[SIZE-1:0]
}
C 2300 700 1 0 0 in_port.sym  
{
T 2300 700 5 10 1 1 0 6 1 1 
refdes=txd_load
}
C 2300 1100 1 0 0 in_port.sym  
{
T 2300 1100 5 10 1 1 0 6 1 1 
refdes=txd_break
}
C 2300 1500 1 0 0 in_port.sym  
{
T 2300 1500 5 10 1 1 0 6 1 1 
refdes=reset
}
C 2300 1900 1 0 0 in_port.sym  
{
T 2300 1900 5 10 1 1 0 6 1 1 
refdes=parity
}
C 2300 2300 1 0 0 in_port.sym  
{
T 2300 2300 5 10 1 1 0 6 1 1 
refdes=force_parity
}
C 2300 2700 1 0 0 in_port.sym  
{
T 2300 2700 5 10 1 1 0 6 1 1 
refdes=clk
}
C 2300 3100 1 0 0 in_port.sym  
{
T 2300 3100 5 10 1 1 0 6 1 1 
refdes=baud_clk
}
C 5200 300  1 0 0 out_port.sym
{
T 6200 300 5  10 1 1 0 0 1 1
refdes=txd_pad_out
}
C 5200 700  1 0 0 out_port.sym
{
T 6200 700 5  10 1 1 0 0 1 1
refdes=txd_buffer_empty
}
