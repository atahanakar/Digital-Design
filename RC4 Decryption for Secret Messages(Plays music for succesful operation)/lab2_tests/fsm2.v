module fsm2(clk,
			waitrequest,
			read,
			ready,
			flash_data,
			song_data_out); //clk50_M
input clk,waitrequest,ready;
output read; 
input[7:0]flash_data;
output reg[7:0]song_data_out;

reg [4:0]state; 

parameter IDLE=5'b000_00;
parameter READ=5'b100_01;
parameter GetAddress=5'b001_10;


assign read=state[0];



always@(posedge clk)
case(state)
	IDLE: if(ready)
	state<=READ;
	READ: if(~waitrequest)state<=GetAddress;
			else state<=READ;
	GetAddress:begin song_data_out<=flash_data;
					state<=IDLE;
				end
endcase 






endmodule 

