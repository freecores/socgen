v 20100214 1
C 2300 300 1 0 0 in_port_v.sym   
{
T 2300 300 5 10 1 1 0 6 1 1
refdes=txd_data_in[SIZE-1:0]
}
C 2300 700 1 0 0 in_port.sym  
{
T 2300 700 5 10 1 1 0 6 1 1 
refdes=txd_parity
}
C 2300 1100 1 0 0 in_port.sym  
{
T 2300 1100 5 10 1 1 0 6 1 1 
refdes=txd_load
}
C 2300 1500 1 0 0 in_port.sym  
{
T 2300 1500 5 10 1 1 0 6 1 1 
refdes=txd_force_parity
}
C 2300 1900 1 0 0 in_port.sym  
{
T 2300 1900 5 10 1 1 0 6 1 1 
refdes=txd_break
}
C 2300 2300 1 0 0 in_port.sym  
{
T 2300 2300 5 10 1 1 0 6 1 1 
refdes=rxd_parity
}
C 2300 2700 1 0 0 in_port.sym  
{
T 2300 2700 5 10 1 1 0 6 1 1 
refdes=rxd_pad_in
}
C 2300 3100 1 0 0 in_port.sym  
{
T 2300 3100 5 10 1 1 0 6 1 1 
refdes=rxd_force_parity
}
C 2300 3500 1 0 0 in_port.sym  
{
T 2300 3500 5 10 1 1 0 6 1 1 
refdes=rts_in
}
C 2300 3900 1 0 0 in_port.sym  
{
T 2300 3900 5 10 1 1 0 6 1 1 
refdes=reset
}
C 2300 4300 1 0 0 in_port.sym  
{
T 2300 4300 5 10 1 1 0 6 1 1 
refdes=cts_pad_in
}
C 2300 4700 1 0 0 in_port.sym  
{
T 2300 4700 5 10 1 1 0 6 1 1 
refdes=clk
}
C 5800 300  1 0  0 out_port_v.sym
{
T 6800 300 5  10 1 1 0 0 1 1 
refdes=rxd_data_out[SIZE-1:0]
}
C 5800 700  1 0 0 out_port.sym
{
T 6800 700 5  10 1 1 0 0 1 1
refdes=txd_pad_out
}
C 5800 1100  1 0 0 out_port.sym
{
T 6800 1100 5  10 1 1 0 0 1 1
refdes=txd_buffer_empty
}
C 5800 1500  1 0 0 out_port.sym
{
T 6800 1500 5  10 1 1 0 0 1 1
refdes=rxd_stop_error
}
C 5800 1900  1 0 0 out_port.sym
{
T 6800 1900 5  10 1 1 0 0 1 1
refdes=rxd_parity_error
}
C 5800 2300  1 0 0 out_port.sym
{
T 6800 2300 5  10 1 1 0 0 1 1
refdes=rxd_buffer_full
}
C 5800 2700  1 0 0 out_port.sym
{
T 6800 2700 5  10 1 1 0 0 1 1
refdes=rts_pad_out
}
C 5800 3100  1 0 0 out_port.sym
{
T 6800 3100 5  10 1 1 0 0 1 1
refdes=cts_out
}
