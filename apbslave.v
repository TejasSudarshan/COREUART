`timescale 1ns / 1ps
`define IDLE 2'b00
`define SETUP 2'b11
`define R_ENABLE 2'b10
`define W_ENABLE 2'b01
	
																																																																																														
module apbslave(

input  pclk,
input  presetn,
input  psel,
input  penable,
input  [1:0]P_ADDR,
input  pwrite,
input  [BITWIDTH-1:0]PW_DATA,
input rx,
input  [BITWIDTH-1:0]datain,
output reg[BITWIDTH-1:0]Pr_data=8'b0,
output reg P_READY=8'b1,
output [BITWIDTH-1:0]o_baud_val,
output [BITWIDTH-1:0]data_in,
output  TX_RDY,
output  RX_RDY,
output  RXOUT,
input tf_TXRDY,
input rbuff_RXRDY
);
parameter BITWIDTH=8;

reg [BITWIDTH-1:0] mem[0:3];

reg[1:0] state,next_state;

reg rxout=1'b1;

assign TX_RDY = (tf_TXRDY)? 1'b1:1'b0;
assign RX_RDY = (rbuff_RXRDY)? 1'b1:1'b0;

always @(negedge pclk, negedge presetn)begin
 if(!presetn)begin
   state<=`IDLE;
 end else begin
  state<=next_state;
 case(state)
 
`IDLE:begin
  if(!presetn)
  next_state<=`IDLE;
  else
  next_state<=`SETUP;
  end
  
`SETUP :begin
	if(pwrite && psel)begin
     next_state <= `W_ENABLE;
	 end else if(!pwrite && psel)begin 
     next_state <= `R_ENABLE;
 end
 end
 
 
 `W_ENABLE : begin
  if(psel==1'b1 && pwrite==1'b1 && penable==1'b1)begin
   next_state<=`W_ENABLE; 	
  end else begin
   next_state<=`IDLE;
end
end
  
	 
 `R_ENABLE : begin
  if(psel==1'b1 && pwrite==1'b0 && penable==1'b1)begin
    next_state<=`R_ENABLE;
  end else begin
    next_state<=`IDLE;
  end
end  
  
  default: begin
   next_state <= `IDLE;
  end
  
  endcase  
end 
end
 
always@(negedge pclk)
 begin
 // mem[3]=data;
 // mem[0]=data1;
 // mem[1]=data3;
 // mem[2]=data2;

case(state)
`SETUP:begin
  P_READY = 1'b0;
  end

`W_ENABLE:begin
 mem[P_ADDR] = PW_DATA;
 P_READY = 1'b1; 

 end 
 
`R_ENABLE:begin
 P_READY = 1'b1;
 Pr_data = mem[P_ADDR];
 
 end

`IDLE:begin
 
  end 
 
endcase

 mem[3] = datain;

end 

always @(negedge pclk)begin
if(rx==1'b0)
rxout=1'b0;
else
rxout=1'b1;
end

assign RXOUT = rxout;
 
assign o_baud_val = mem[0];

assign data_in = mem[2];

endmodule
