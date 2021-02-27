
 /*module fsm(clk,
	flash_mem_address,
	flash_mem_waitrequest,
	flash_mem_readdata,
	flash_mem_readdatavalid,
	flash_mem_read,
	synchronized_clk,
	song_data,
	button
	);
input clk,flash_mem_waitrequest,flash_mem_readdatavalid,synchronized_clk;
input [31:0] flash_mem_readdata;
input [7:0]button;

output reg [22:0]flash_mem_address;
output reg[7:0]song_data;
output flash_mem_read;

module fsm(synchronized_clk,
button,
flash_mem_readdata,
flash_mem_address,
flash_data,
ready
	);


input synchronized_clk;
input [31:0] flash_mem_readdata;
input [7:0]button;

output reg [22:0]flash_mem_address;
output reg[7:0]flash_data;
output reg ready;
 */
module fsm_tb;
reg clk;
reg[31:0]flash_mem_readdata;
reg [7:0]button; 

wire [22:0] flash_mem_address;
wire [7:0] flash_data;
wire ready;

parameter F=8'h46 ;
parameter E=8'h45 ;
parameter R=8'h52 ; 
parameter D=8'h44; 
parameter B=8'h42 ;

parameter f_l=8'h66 ;
parameter e_l=8'h65;
parameter r_l=8'h72;
parameter d_l=8'h64;
parameter b_l=8'h62;


fsm dut(clk,
button,
flash_mem_readdata,
flash_mem_address,
flash_data,
ready
	);

initial begin 
clk=1'b0; #5;
forever begin 
clk=1'b1; #5;
clk=1'b0; #5;
end
end


initial begin 
clk=1'b1;
flash_mem_readdata=32'd1;  button=8'hx; #10; //first cycle
flash_mem_readdata=32'd1;   button=8'h65; #10; //play
flash_mem_readdata=32'd1;   button=8'hx; #10;  
flash_mem_readdata=32'd1;   button=8'hx; #10;
flash_mem_readdata=32'd1;  button=8'hx; #10;
flash_mem_readdata=32'd1;  button=8'hx; #10;
flash_mem_readdata=32'd1;  button=8'hx; #10;
flash_mem_readdata=32'd1;  button=8'hx; #10;
flash_mem_readdata=32'd1;  button=8'hx; #10;
flash_mem_readdata=32'd1;   button=8'hx; #10;


$stop(0);
end 

endmodule 










