`timescale 1ns / 1ps

module CORETB;

	// Inputs
	reg PCLK;
	reg PRESETN;
	reg PSEL;
	reg PENABLE;
	reg [1:0] PADDR;
	reg PWRITE;
	reg [7:0] PWDATA;
	reg RX;

	// Outputs
	wire [7:0] PRDATA;
	wire PREADY;
	wire TX;
	wire TXRDY;
	wire RXRDY;
	wire [7:0] DATAOUT;

	// Instantiate the Unit Under Test (UUT)
	UAPBCORE uut (
		.PCLK(PCLK), 
		.PRESETN(PRESETN), 
		.PSEL(PSEL), 
		.PENABLE(PENABLE), 
		.PADDR(PADDR), 
		.PWRITE(PWRITE), 
		.PWDATA(PWDATA), 
		.PRDATA(PRDATA), 
		.PREADY(PREADY), 
		.RX(RX), 
		.TX(TX), 
		.TXRDY(TXRDY), 
		.RXRDY(RXRDY), 
		.DATAOUT(DATAOUT)
	);
always #16PCLK=~PCLK;
	initial begin
		// Initialize Inputs
		PCLK = 1;
		PRESETN = 0;
		PSEL = 0;
		PENABLE = 0;
		PADDR = 0;
		PWRITE = 0;
		PWDATA = 0;
		RX = 1;

		#16;
		
		PRESETN=1'b1;
		#32;
/////////////////////////////////////		
		PWRITE=1;
		PSEL=1;
		#32;
		PWDATA=8'b1101;
		PADDR=2'b00;
		PENABLE=1;
		#32;
		PWRITE=0;
		PSEL=0;
		PENABLE=0;
		#32;
/////////////////////////////////////////
      PWRITE=1;
		PSEL=1;
		#32;
		PWDATA=8'b0;
		PADDR=2'b01;
		PENABLE=1;
		#32;
		PWRITE=0;
		PSEL=0;
		PENABLE=0;
		#32;
//////////////////////////////////////////		
      PWRITE=1;
		PSEL=1;
		#32;
		PWDATA=8'h9a;
		PADDR=2'b10;
		PENABLE=1;
		#32;
		PWRITE=0;
		PSEL=0;
		PENABLE=0;
		#64;
///////////////////////////////////////
      
////////////////////////////////////////
      PRESETN=1'b0;
		#32;
      PWRITE=1;
		#110000;
		PWRITE=0;
		#48;
		#40000;
////////////////////////////////////////		
		RX=1'b0;
      #7186;
      
		RX=1'b1;
      #7168;
      RX=1'b0;
      #7168;
      RX=1'b1;
      #7168;
      RX=1'b0;
      #7168;
      RX=1'b1;
      #7168;
      RX=1'b0;
      #7168;
      RX=1'b1;
      #7168;
      RX=1'b0;
      #7168;
      
      RX=1'b1;
      #7168;		
		PENABLE=1;
		#20000;
		
//////////////////////////////////////
      		
$finish;		

	end
      
endmodule

