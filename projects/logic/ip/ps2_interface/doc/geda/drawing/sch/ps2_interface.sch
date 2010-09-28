v 20100214 1
C 1400 300 1 0 0 in_port_v.sym   
{
T 1400 300 5 10 1 1 0 6 1 1
refdes=tx_data[7:0]
}
C 1400 700 1 0 0 in_port.sym  
{
T 1400 700 5 10 1 1 0 6 1 1 
refdes=tx_write
}
C 1400 1100 1 0 0 in_port.sym  
{
T 1400 1100 5 10 1 1 0 6 1 1 
refdes=rx_clear
}
C 1400 1500 1 0 0 in_port.sym  
{
T 1400 1500 5 10 1 1 0 6 1 1 
refdes=reset
}
C 1400 1900 1 0 0 in_port.sym  
{
T 1400 1900 5 10 1 1 0 6 1 1 
refdes=ps2_data_in
}
C 1400 2300 1 0 0 in_port.sym  
{
T 1400 2300 5 10 1 1 0 6 1 1 
refdes=ps2_clk_in
}
C 1400 2700 1 0 0 in_port.sym  
{
T 1400 2700 5 10 1 1 0 6 1 1 
refdes=clk
}
C 4200 300  1 0  0 out_port_v.sym
{
T 5200 300 5  10 1 1 0 0 1 1 
refdes=rx_data[7:0]
}
C 4200 700  1 0 0 out_port.sym
{
T 5200 700 5  10 1 1 0 0 1 1
refdes=tx_buffer_empty
}
C 4200 1100  1 0 0 out_port.sym
{
T 5200 1100 5  10 1 1 0 0 1 1
refdes=tx_ack_error
}
C 4200 1500  1 0 0 out_port.sym
{
T 5200 1500 5  10 1 1 0 0 1 1
refdes=rx_read
}
C 4200 1900  1 0 0 out_port.sym
{
T 5200 1900 5  10 1 1 0 0 1 1
refdes=rx_parity_rcv
}
C 4200 2300  1 0 0 out_port.sym
{
T 5200 2300 5  10 1 1 0 0 1 1
refdes=rx_parity_error
}
C 4200 2700  1 0 0 out_port.sym
{
T 5200 2700 5  10 1 1 0 0 1 1
refdes=rx_parity_cal
}
C 4200 3100  1 0 0 out_port.sym
{
T 5200 3100 5  10 1 1 0 0 1 1
refdes=rx_full
}
C 4200 3500  1 0 0 out_port.sym
{
T 5200 3500 5  10 1 1 0 0 1 1
refdes=rx_frame_error
}
C 4200 3900  1 0 0 out_port.sym
{
T 5200 3900 5  10 1 1 0 0 1 1
refdes=ps2_data_oe
}
C 4200 4300  1 0 0 out_port.sym
{
T 5200 4300 5  10 1 1 0 0 1 1
refdes=ps2_clk_oe
}
C 4200 4700  1 0 0 out_port.sym
{
T 5200 4700 5  10 1 1 0 0 1 1
refdes=busy
}
