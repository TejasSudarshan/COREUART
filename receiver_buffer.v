`timescale 1ns/1ps
module buffer_r( Clk, dataIn,RD, WR, rpaddr, dataOut, Rst,EMPTY); 

input  Clk,RD,WR,Rst;
input [1:0]rpaddr;
output  EMPTY; 

input [7:0]dataIn;
output reg[7:0] dataOut; 

assign EMPTY = (RD && !Rst)? 1'b1:1'b0;  

reg[0:7]mem[3:0];

always @(posedge Clk)
begin
if(!Rst)begin
if(WR && !RD) 
mem[rpaddr]=dataIn;

else if(RD && !WR)
dataOut=mem[rpaddr];

else
dataOut=0;
end
end

endmodule
