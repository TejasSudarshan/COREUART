# ADLD-IRP





How to finad the find the Baud value is the FINAL VALUE folder.

ADDRESS: 2bit

address  00: send Baud value 8bit (8'b00001101), value = 13. for baudrate 128000.
address  01: precision is set to 8'b0, can be set to any value.
address  10: send the data that has to be transmitted 8'b01010101.
address  11: not used.


baud rate can be tested on: 
1)  56000
2)  38400
3)  19200
