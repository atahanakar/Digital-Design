
module task2(clk,reset,wren,q,data,address,secret_key);
input clk,reset;
input[7:0]q;
input[23:0] secret_key;

output   wren;
output reg [7:0]data,address;


//states 
parameter TASK1=7'b000000_0;
parameter WRITE_S_MEMORY=7'b000001_1;
parameter INCREMENT_I1=7'b000010_0;
parameter TASK2=7'b000011_0;
parameter GET_Si=7'b000_100_0;
parameter GET_SECRET_KEY=7'b000_101_0;
parameter GET_J=7'b000_110_0;
parameter ADDRESS_J=7'b000_111_0;
parameter Get_SJ=7'b001_000_0;
parameter Get_Address_I2=7'b001_001_0;
parameter Wait_for_data=7'b001_010_0;
parameter Write_to_Si=7'b001_011_1;
parameter Wait_for_data2=7'b001_100_0;
parameter Write_to_Sj=7'b001_101_1;
parameter INCREMENT_I2=7'b001_110_0;


//i,j 
reg[8:0]i1=0;
reg[8:0]i2=0;
reg[8:0]j=0;
//value of si sj
reg[7:0]value_si,value_sj;
//secret key part
reg[7:0] fake_secret_key;
reg[1:0] part;
//some parameters
wire[1:0]key_length =2'd3;
reg[1:0] key_data;
//first we need to write to memory 
reg[6:0] state=TASK1; 
//state shower
wire[5:0]fake_state=state[6:1];

assign wren=state[0];


always@(posedge clk or posedge reset) begin 
if(reset) begin
i1<=0;
i2<=0;
j<=0;
state<=TASK1;
end
else begin 
case(state) 
TASK1: begin if(i1<=255) begin 
		address<=i1 ;
		data<=i1;
		state<=WRITE_S_MEMORY;
		end 
		else 
		state<=TASK2;
		end
WRITE_S_MEMORY:begin  //give memory time to write.
				state<=INCREMENT_I1;

					end
INCREMENT_I1: begin 
			i1<=i1+1;
			state<=TASK1;
			end
TASK2: begin 
		if(i2<=255)begin
		address<=i2; //address i
		state<=GET_Si;
		end
		else state<=TASK2;
		end
GET_Si: begin  //give memory time to get Si
		
		part<=i2%3;
		state<=GET_SECRET_KEY;
		end 
GET_SECRET_KEY: begin 
			value_si<=q;
			if(part==2'd0)begin 
			fake_secret_key<=secret_key[23:16];
			state<=GET_J;
			end
			if(part==2'd1)begin 
			fake_secret_key<=secret_key[15:8];
			state<=GET_J;
			end
			if(part==2'd2)begin 
			fake_secret_key<=secret_key[7:0];
			state<=GET_J;
			end
			end
GET_J: begin 
		j<=(j+value_si+fake_secret_key)%256;
		state<=ADDRESS_J;
		end
ADDRESS_J: begin 
		address<=j;
		state<=Get_SJ;
		end
Get_SJ: begin  //give memory time to get Sj
		state<=Get_Address_I2;
	end
Get_Address_I2:begin 
		value_sj<=q;
		state<=Wait_for_data;

			end
Wait_for_data:begin  //s[i]=s[j];
					//s[j]=s[i]
			address<=j;
			data<=value_si;
			state<=Write_to_Sj;
			end
Write_to_Sj://wait for memory to write
			state<=Wait_for_data2;
Wait_for_data2:begin 
			address<=i2;
			data<=value_sj;
			state<=Write_to_Si;
				end
Write_to_Si: //wait for memory to write
			state<=INCREMENT_I2;
			


INCREMENT_I2: begin 
		i2<=i2+1;
		state<=TASK2;
		end


endcase 
end
	end



endmodule 
