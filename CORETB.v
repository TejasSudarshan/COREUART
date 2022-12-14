`timescale 1ns / 1ps
`define SETUP 2'b11
`define W_ENABLE 2'b01
`define R_ENABLE 2'b10
`define BITWIDTH 8

module CORETB;

	// Inputs
	reg PCLK;
	reg PRESETN;
	reg PWRITE;
	reg PSEL;
	reg PENABLE;
	reg [1:0] PADDR;
	reg [`BITWIDTH-1:0] PWDATA;
   reg [1:0]state;
	wire [`BITWIDTH-1:0] PRDATA;
	wire PREADY;

   wire TX;
	reg RX;
   wire TXRDY;
   wire RXRDY;
   
	
	wire[7:0]DataOut;
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
		.DATAOUT(DataOut)	
		);
	

always #16PCLK = ~PCLK;
initial begin
 state=2'b00;
 PCLK=1'b1;
 PRESETN=1'b0;
 PSEL=1'b0;
 PENABLE=1'b0;
 PWRITE=1'b0;
 PWDATA='b0;
 PADDR='b0;
 RX=1'b1;
 #16;
 
 PRESETN=1;
 #32;
 setupw;
 write;
 PADDR=2'b00;
 PWDATA=8'b00001101; //final value
 idle;
/////////////////////////////////////// 
 setupw;
 write;
 PADDR=2'b01;
 PWDATA=8'b000; //precision
 idle;
//////////////////////////////////
 setupw;
 write;
 PADDR=2'b10;
 PWDATA=8'h9a; //data
 idle;
//////////////////////////////////
 setupw;
 write;
 PADDR=2'b11;
 PWDATA=8'b0000;
 idle;
/////////////////////////////////// 
 PWRITE=0;
 #32;
 
 PRESETN=0;
 PWRITE=1;
 #32;
 RX=1'b1;
 #384;

RX=1'b0;
#7168;
//////////////////////// 
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
//////////////////// 
RX=1'b1;
#7168;
PWRITE=0;
PENABLE=1;

#32;
#100000;
$finish;
 end


task write;
 begin
  @(negedge PCLK)begin
	  
	  PWRITE=1;
	  PSEL=1;
     PENABLE=1;
	  end
	  end	
endtask
	  

 
task read;
begin
  @(negedge PCLK)begin
	  
	  PSEL=1;
     PWRITE=0;
     PENABLE=1;
     $display("PADDR %b, PRDATA %h  ",PADDR,PRDATA);
	 end 
end
endtask

task idle;
@(negedge PCLK)begin
 
 PSEL=1'b0;
 PWRITE=0;
 PENABLE=1'b0;

end
endtask

task setupw;
@(negedge PCLK)begin
 
 PSEL=1'b1;
 PWRITE=1'b1;
 PENABLE=1'b0;
end
endtask

task setupr;
@(negedge PCLK)begin
 
 PSEL=1'b1;
 PWRITE=1'b0;
 PENABLE=1'b0; 
end
endtask
     
endmodule
