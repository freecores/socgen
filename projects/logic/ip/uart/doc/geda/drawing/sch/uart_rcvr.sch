v 20100214 1
C 1400 300 1 0 0 in_port.sym  
{
T 1400 300 5 10 1 1 0 6 1 1 
refdes=rxd_pad_in
}
C 1400 700 1 0 0 in_port.sym  
{
T 1400 700 5 10 1 1 0 6 1 1 
refdes=reset
}
C 1400 1100 1 0 0 in_port.sym  
{
T 1400 1100 5 10 1 1 0 6 1 1 
refdes=parity
}
C 1400 1500 1 0 0 in_port.sym  
{
T 1400 1500 5 10 1 1 0 6 1 1 
refdes=force_parity
}
C 1400 1900 1 0 0 in_port.sym  
{
T 1400 1900 5 10 1 1 0 6 1 1 
refdes=clk
}
C 1400 2300 1 0 0 in_port.sym  
{
T 1400 2300 5 10 1 1 0 6 1 1 
refdes=baud_clk
}
C 4900 300  1 0  0 out_port_v.sym
{
T 5900 300 5  10 1 1 0 0 1 1 
refdes=rxd_data_out[SIZE-1:0]
}
C 4900 700  1 0 0 out_port.sym
{
T 5900 700 5  10 1 1 0 0 1 1
refdes=rxd_stop_error
}
C 4900 1100  1 0 0 out_port.sym
{
T 5900 1100 5  10 1 1 0 0 1 1
refdes=rxd_parity_error
}
C 4900 1500  1 0 0 out_port.sym
{
T 5900 1500 5  10 1 1 0 0 1 1
refdes=rxd_buffer_full
}
