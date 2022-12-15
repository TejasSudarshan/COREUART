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


wire rxtorx;
wire RR; //rxrdy to rxempty
wire TT; //txfull to txrdy

uart uart(.clk(PCLK),.reset_n(PRESETN),.paddr(PADDR),.r_data(DATAOUT),.rd_uart(PENABLE),.wr_uart(PWRITE),.rx_empty(RR),.w_data(data_intodatain),.t_x(TX),.rx(rxtorx),.TIMER_FINAL_VALUE(o_baud_valuetodatain),.tx_full(TT));

apbslave apbslave(.pclk(PCLK),.presetn(PRESETN),.psel(PSEL),.penable(PENABLE),.P_ADDR(PADDR),.pwrite(PWRITE),.PW_DATA(PWDATA),.rx(RX),.Pr_data(PRDATA),.P_READY(PREADY),.o_baud_val(o_baud_valuetodatain),.data_in(data_intodatain),.RXOUT(rxtorx),.TX_RDY(TXRDY),.RX_RDY(RXRDY),.tf_TXRDY(TT),.rbuff_RXRDY(RR));


endmodule
