v 20100214 1
C 1800 300 1 0 0 in_port_v.sym   
{
T 1800 300 5 10 1 1 0 6 1 1
refdes=parity_type[1:0]
}
C 1800 700 1 0 0 in_port_v.sym   
{
T 1800 700 5 10 1 1 0 6 1 1
refdes=data[SIZE-1:0]
}
C 1800 1100 1 0 0 in_port.sym  
{
T 1800 1100 5 10 1 1 0 6 1 1 
refdes=two_stop_enable
}
C 1800 1500 1 0 0 in_port.sym  
{
T 1800 1500 5 10 1 1 0 6 1 1 
refdes=stop_value
}
C 1800 1900 1 0 0 in_port.sym  
{
T 1800 1900 5 10 1 1 0 6 1 1 
refdes=start_value
}
C 1800 2300 1 0 0 in_port.sym  
{
T 1800 2300 5 10 1 1 0 6 1 1 
refdes=reset
}
C 1800 2700 1 0 0 in_port.sym  
{
T 1800 2700 5 10 1 1 0 6 1 1 
refdes=parity_enable
}
C 1800 3100 1 0 0 in_port.sym  
{
T 1800 3100 5 10 1 1 0 6 1 1 
refdes=load
}
C 1800 3500 1 0 0 in_port.sym  
{
T 1800 3500 5 10 1 1 0 6 1 1 
refdes=edge_enable
}
C 1800 3900 1 0 0 in_port.sym  
{
T 1800 3900 5 10 1 1 0 6 1 1 
refdes=clk
}
C 4300 300  1 0 0 out_port.sym
{
T 5300 300 5  10 1 1 0 0 1 1
refdes=pad_out
}
C 4300 700  1 0 0 out_port.sym
{
T 5300 700 5  10 1 1 0 0 1 1
refdes=buffer_empty
}
