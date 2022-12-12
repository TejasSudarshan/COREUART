#IRP TEAM-1

Design and Implementation of SOC: Processor to device interface APB bridge to UART.

APB

PWDATA = 8bit
PRDATA = 8bit
PADDR = 2bit
DATAOUT = 8bit

ADDRESS: 2bit

address  00: Baud value (8bit) 

address  01: precision (8bit)

address  10: send the data that has to be transmitted (8bit)

address  11: not used.


Write/Read operation

pwrite = 0  psel = 1 penable = 1   (Read Operation)

pwrite = 1  psel = 1 penable = 1   (Write operation)

//////////////////////////////////////////////////

Baudrate Generator

FINAL_VALUE = 8bit

PCLK = 30MHz
 
baud rate can be tested on: 
1)  128000
2)  56000
3)  38400
4)  19200




How to find the Baud value is the FINAL VALUE folder.
