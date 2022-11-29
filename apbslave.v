`timescale 1ns / 1ps
`define IDLE 2'b00
`define SETUP 2'b11
`define R_ENABLE 2'b10
`define W_ENABLE 2'b01
`define BITWIDTH 8 	
																																																																																														
module apbslave(

input  pclk,
input  presetn,
input  psel,
input  penable,
input  [1:0]P_ADDR,
input  pwrite,
input  [`BITWIDTH-1:0]PW_DATA,
output reg[`BITWIDTH-1:0]Pr_data,
output reg P_READY,
output [`BITWIDTH-1:0]o_baud_val,
output [`BITWIDTH-1:0]data_in,
output PARITY_EN,

output  TX_RDY,
output  RX_RDY,
input tf_TXRDY,
input rbuff_RXRDY


);

wire tx_done;
wire rx_done;


reg [`BITWIDTH-1:0] mem[0:3];

reg[1:0] state,next_state;



assign TX_RDY = (tf_TXRDY)? 1'b1:1'b0;
assign RX_RDY = (rbuff_RXRDY)? 1'b1:1'b0;

always @(posedge pclk, negedge presetn)begin
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
 
always@(posedge pclk)
 begin
 
case(state)
`SETUP:begin
  P_READY=1'b0;
  end

`W_ENABLE:begin
 mem[P_ADDR]= PW_DATA;
 P_READY=1'b1; 

 end 
 
`R_ENABLE:begin
 P_READY=1'b1;
 Pr_data=mem[P_ADDR];
 
end

`IDLE:begin
 
  end 
 
endcase
end 
 
assign o_baud_val=mem[0];

assign data_in=mem[2];

endmodule
