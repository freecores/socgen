v 20100214 1
C 2300 300 1 0 0 in_port_v.sym   
{
T 2300 300 5 10 1 1 0 6 1 1
refdes=Write_Data[WIDTH-1:0]
}
C 2300 700 1 0 0 in_port_v.sym   
{
T 2300 700 5 10 1 1 0 6 1 1
refdes=WR_Add[ADDR-1:0]
}
C 2300 1100 1 0 0 in_port_v.sym   
{
T 2300 1100 5 10 1 1 0 6 1 1
refdes=RD_Add[ADDR-1:0]
}
C 2300 1500 1 0 0 in_port.sym  
{
T 2300 1500 5 10 1 1 0 6 1 1 
refdes=clk
}
C 2300 1900 1 0 0 in_port.sym  
{
T 2300 1900 5 10 1 1 0 6 1 1 
refdes=WR
}
C 2300 2300 1 0 0 in_port.sym  
{
T 2300 2300 5 10 1 1 0 6 1 1 
refdes=RD
}
C 2300 2700 1 0 0 in_port.sym  
{
T 2300 2700 5 10 1 1 0 6 1 1 
refdes=CS
}
C 5600 300  1 0  0 out_port_v.sym
{
T 6600 300 5  10 1 1 0 0 1 1 
refdes=Read_Data[WIDTH-1:0]
}
