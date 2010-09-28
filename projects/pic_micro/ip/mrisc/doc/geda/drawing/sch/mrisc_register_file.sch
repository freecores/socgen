v 20100214 1
C 1700 300 1 0 0 in_port_v.sym   
{
T 1700 300 5 10 1 1 0 6 1 1
refdes=rf_wr_data[7:0]
}
C 1700 700 1 0 0 in_port_v.sym   
{
T 1700 700 5 10 1 1 0 6 1 1
refdes=rf_wr_bnk[1:0]
}
C 1700 1100 1 0 0 in_port_v.sym   
{
T 1700 1100 5 10 1 1 0 6 1 1
refdes=rf_wr_addr[4:0]
}
C 1700 1500 1 0 0 in_port_v.sym   
{
T 1700 1500 5 10 1 1 0 6 1 1
refdes=rf_rd_bnk[1:0]
}
C 1700 1900 1 0 0 in_port_v.sym   
{
T 1700 1900 5 10 1 1 0 6 1 1
refdes=rf_rd_addr[4:0]
}
C 1700 2300 1 0 0 in_port.sym  
{
T 1700 2300 5 10 1 1 0 6 1 1 
refdes=rst
}
C 1700 2700 1 0 0 in_port.sym  
{
T 1700 2700 5 10 1 1 0 6 1 1 
refdes=rf_we
}
C 1700 3100 1 0 0 in_port.sym  
{
T 1700 3100 5 10 1 1 0 6 1 1 
refdes=clk
}
C 4500 300  1 0  0 out_port_v.sym
{
T 5500 300 5  10 1 1 0 0 1 1 
refdes=rf_rd_data[7:0]
}
