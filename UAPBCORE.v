`timescale 1ns/1ps
`define BITWIDTH 8

module UAPBCORE(
input PCLK,
input PRESETN,
input PSEL,
input PENABLE,
input [1:0]PADDR,
input PWRITE,
input [`BITWIDTH-1:0]PWDATA,
output [`BITWIDTH-1:0]PRDATA,
output wire PREADY,
input RX,
output wire TX,

output wire TXRDY,
output wire RXRDY,
output wire[`BITWIDTH-1:0]DATAOUT
);


wire [`BITWIDTH-1:0]data_intodatain;
wire [`BITWIDTH-1:0]o_baud_valuetodatain;

wire RR;
wire TT;

//wire clktoclk; for the fpga testing

uart uart(.clk(PCLK),.reset_n(PRESETN),.paddr(PADDR),.r_data(DATAOUT),.rd_uart(PENABLE),.wr_uart(PWRITE),.rx_empty(RR),.w_data(data_intodatain),.t_x(TX),.rx(RX),.TIMER_FINAL_VALUE(o_baud_valuetodatain)/*,.tick(baudtick),.roverflow(OE),.rparityerror(PE),.rframingerror(FE),*/,.tx_full(TT));

apbslave apbslave(.pclk(PCLK),.presetn(PRESETN),.psel(PSEL),.penable(PENABLE),.P_ADDR(PADDR),.pwrite(PWRITE),.PW_DATA(PWDATA),.Pr_data(PRDATA),.P_READY(PREADY),.o_baud_val(o_baud_valuetodatain),.data_in(data_intodatain),.TX_RDY(TXRDY),.RX_RDY(RXRDY),.tf_TXRDY(TT),.rbuff_RXRDY(RR)/*.OVER_FLOW(OVERFLOW),.FRAMING_ERR(FRAMINGERR),.PARITY_ERR(PARITYERR),.rbuff_OVERFLOW(OE),.rbuff_PARITY_ERR(PE),.rbuff_FRAMING_ERR(FE)*/);

  //finalvalue finavalue(.clock(PCLK),.clk(clktoclk)); for fpga testing

endmodule
