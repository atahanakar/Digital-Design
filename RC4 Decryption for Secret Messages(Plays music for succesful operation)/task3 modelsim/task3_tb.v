module task3_tb;
reg clk,reset;
reg[7:0]q,q_d,q_m;

wire wren,wren_d,cracked,failed;
wire[23:0]secret_key;
wire [7:0]data,data_d,address,address_m,address_d;


task3 dut(clk,
	reset,
	wren,
	q,
	data,
	address,
	secret_key,
	address_m,
	q_m,
	address_d,
	data_d,
	wren_d,
	q_d,
	cracked,
	failed);

initial begin 
clk=1'b1; #1;
forever begin 
clk=1'b0; #1;
clk=1'b1; #1;
end
end 



initial begin 
q=5; q_d=4;   q_m=9; 

#2000000;
dut.state=11'b01_100_110_100;

#8;

$stop(0);
end

endmodule






/*
module task3(clk,
	reset,
	wren,
	q,
	data,
	address,
	secret_key,
	address_m,
	q_m,
	address_d,
	data_d,
	wren_d,
	q_d,
	cracked,
	failed); */
