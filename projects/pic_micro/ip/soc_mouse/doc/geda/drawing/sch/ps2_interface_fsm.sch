v 20100214 1
C 1700 300 1 0 0 in_port_v.sym   
{
T 1700 300 5 10 1 1 0 6 1 1
refdes=bit_count[3:0]
}
C 1700 700 1 0 0 in_port.sym  
{
T 1700 700 5 10 1 1 0 6 1 1 
refdes=write
}
C 1700 1100 1 0 0 in_port.sym  
{
T 1700 1100 5 10 1 1 0 6 1 1 
refdes=usec_delay_done
}
C 1700 1500 1 0 0 in_port.sym  
{
T 1700 1500 5 10 1 1 0 6 1 1 
refdes=reset
}
C 1700 1900 1 0 0 in_port.sym  
{
T 1700 1900 5 10 1 1 0 6 1 1 
refdes=ps2_idle
}
C 1700 2300 1 0 0 in_port.sym  
{
T 1700 2300 5 10 1 1 0 6 1 1 
refdes=ps2_clk_fall
}
C 1700 2700 1 0 0 in_port.sym  
{
T 1700 2700 5 10 1 1 0 6 1 1 
refdes=frame0
}
C 1700 3100 1 0 0 in_port.sym  
{
T 1700 3100 5 10 1 1 0 6 1 1 
refdes=force_startbit
}
C 1700 3500 1 0 0 in_port.sym  
{
T 1700 3500 5 10 1 1 0 6 1 1 
refdes=clk
}
C 4700 300  1 0 0 out_port.sym
{
T 5700 300 5  10 1 1 0 0 1 1
refdes=shift_frame
}
C 4700 700  1 0 0 out_port.sym
{
T 5700 700 5  10 1 1 0 0 1 1
refdes=ps2_data_oe
}
C 4700 1100  1 0 0 out_port.sym
{
T 5700 1100 5  10 1 1 0 0 1 1
refdes=ps2_clk_oe
}
C 4700 1500  1 0 0 out_port.sym
{
T 5700 1500 5  10 1 1 0 0 1 1
refdes=load_tx_data
}
C 4700 1900  1 0 0 out_port.sym
{
T 5700 1900 5  10 1 1 0 0 1 1
refdes=load_rx_data
}
C 4700 2300  1 0 0 out_port.sym
{
T 5700 2300 5  10 1 1 0 0 1 1
refdes=enable_usec_delay
}
C 4700 2700  1 0 0 out_port.sym
{
T 5700 2700 5  10 1 1 0 0 1 1
refdes=busy
}
