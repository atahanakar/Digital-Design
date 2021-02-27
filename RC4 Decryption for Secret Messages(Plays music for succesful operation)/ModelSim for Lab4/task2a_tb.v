module task2a_tb;
reg clk,reset,finished_task1; 
reg[23:0]secret_key;
reg [7:0]q,q_d,q_m;

wire[4:0]address_m,address_d;
wire[7:0] address,data,data_d;
wire wren_d,wren,done_task2;

parameter WAIT  = 7'd0 ;
parameter GET_S =7'd2;
parameter GO_TO_S = 7'd1;
parameter GO_TO_ROM=7'd3;
parameter GET_NEW_J=7'd4;
parameter START_SWAP_J= 7'd5;
parameter GET_ADDRESS_J=7'd6;
parameter SWAP=7'd7;
parameter DONE_SWAP=7'd8;
parameter INCREMENT=7'd9;
parameter FINISHED=7'd10;



task2_fsm dut(clk,
	reset,
	secret_key,
	q,
	address_d,
	data_d,
	wren_d,
	q_d,
	q_m,
	address_m,
	finished_task1,
	wren,
	data,
	address,
	done_task2);

initial begin 
clk=1'b1; #5; 
forever begin 
clk=1'b0; #5;
clk=1'b1; #5;
end
end

initial begin 

finished_task1=1'b0; //should be at WAIT STATE 
#10; //
finished_task1=1'b1;  secret_key=24'b00000000_00000010_01001001; //0x000249
#10; //should go to GO to s
 
 #10; //should go to GET s 
 q=8'd0;
 #10; //should go to go to rom 
// ggive the results of mod
 #10; //should go to  get new j 

 #10; //should go to start swap j

 #10; //get address j

 #10; // swap 

 #10; // done swap 

 #10; //INCREMENT

 #10; //Go to s
q=1;
 #10; // get s

 #10; //go to rom 

 #10; //get new j 

#10; //start swap j 

#40; // do all the states(rest) 

q=2; 

#80;

q=3; 

#80; 

q=4; 

#2400;

#20000;


$stop(0);
end





endmodule 

/*module task2_fsm(clk,
	reset,
	secret_key,
	q,
	address_d,
	data_d,
	wren_d,
	q_d,
	q_m,
	address_m,
	finished_task1,
	wren,
	data,
	address,
	done_task2);*/