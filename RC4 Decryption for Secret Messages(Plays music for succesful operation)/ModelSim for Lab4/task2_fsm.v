module task2_fsm(clk,
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
input clk,reset,finished_task1;
input[23:0] secret_key;
input [7:0]q,q_m,q_d;

//q is from SRAM

output reg [7:0]data_d,address,data;
output reg [4:0] address_d,address_m;
output  reg wren_d,wren;
output reg done_task2;



//states
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



reg [8:0] i=9'd0; 
reg [8:0] j=9'd0;
reg [8:0] fake_address=9'd0;
reg [7:0]secret_byte;
reg [8:0] fake_address_d=9'd0;
reg [8:0] fake_address_m=9'd0;
reg [7:0] sum;
reg [6:0] state=WAIT;
reg [7:0] value,value_d,value_m;

wire [1:0]keylength=2'd3; //keylength is 3.
reg [7:0] secret_key_data;//i mod keylength

always@(posedge clk or posedge reset)begin 
if(reset) begin //reset
i<=9'd0;  //data
j<=9'd0;
fake_address<=9'd0;
fake_address_m<=9'd0;
fake_address_d<=9'd0;
wren_d<=0;
wren<=0;
address_d<=5'd0;
address_m<=5'd0;
address<=8'd0;
done_task2=0;
state<=WAIT;
end
else begin 

case(state)
WAIT: if(finished_task1)state<=GO_TO_S; 
			else state<=WAIT ; //wait until task1 writes to the s memory
GO_TO_S:begin  if(i<=255) begin 
						 wren<=0;
						 done_task2<=0;
						 wren_d<=0;
						 address<=i;
						 state<=GET_S;
						 end
				else state<=FINISHED;
		end
GET_S: begin 	// now we have the value of q   
		sum<=q+j; //save this to sum ,we need the value of secret_key[i mod keylength]
		state<=GO_TO_ROM;
		secret_key_data<= i%keylength; //before the clk we need this data.
		end
GO_TO_ROM: begin 
			if(secret_key_data==0)begin 
			secret_byte<=secret_key[23:16];
			state<=GET_NEW_J;
			end
			if(secret_key_data==1)begin 
			secret_byte<=secret_key[15:8];
			state<=GET_NEW_J;
			end
			if(secret_key_data==2)begin 
			secret_byte<=secret_key[7:0];
			state<=GET_NEW_J;
			end
			end

GET_NEW_J: begin 
			j<=(sum+secret_byte) %256; // new value of j 
			state<=START_SWAP_J;
			end 
START_SWAP_J:  begin 
			address<=j;  //address gets j 
			wren<=0;
			state<=GET_ADDRESS_J;
			end
GET_ADDRESS_J:begin 
			value<=q;//save the value s[j]
			state<=SWAP;
			end
SWAP:begin
			data<=value;
			address<=i;
			wren=1;
			state<=DONE_SWAP;
	end
DONE_SWAP: begin 	
		state<=INCREMENT;

			end



			
INCREMENT: begin 
		i<=i+1;
		state<=GO_TO_S;
			end 

FINISHED: begin  
		state<=FINISHED;
		done_task2=1;
		end
endcase
end 
end



endmodule 


