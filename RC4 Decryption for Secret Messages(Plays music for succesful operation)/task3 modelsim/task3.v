

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
	failed);
input clk,reset;
input[7:0]q,q_m,q_d;

output [23:0] secret_key;
output   wren,wren_d;
output reg [7:0]data,data_d,address,address_m,address_d;
output  failed,cracked;


//states 
parameter TASK1=			 11'b00_000_000_000;
parameter WRITE_S_MEMORY=	 11'b00_000_001_001;
parameter INCREMENT_I1=		 11'b00_000_010_000;
parameter TASK2=			 11'b00_000_011_000;
parameter GET_Si=			 11'b00_000_100_000;
parameter GET_SECRET_KEY=	 11'b00_000_101_000;
parameter GET_J=			 11'b00_000_110_000;
parameter ADDRESS_J=		 11'b00_000_111_000;
parameter Get_SJ=			 11'b00_001_000_000;
parameter Get_Address_I2=	 11'b00_001_001_000;
parameter Wait_for_data=	 11'b00_001_010_000;
parameter Write_to_Si=		 11'b00_001_011_001;
parameter Wait_for_data2=	 11'b00_001_100_000;
parameter Write_to_Sj=		 11'b00_001_101_001;
parameter INCREMENT_I2=		 11'b00_001_110_000;
//task2b states
parameter TASK2B=		  	 11'b00_001_111_000;
parameter GET_I3_ADDRESS= 	 11'b00_010_000_000;
parameter GET_Si3=		  	 11'b00_010_001_000;
parameter GET_NEW_J1=	     11'b00_010_010_000;
parameter GET_J1_ADDRESS2=	 11'b00_010_011_000;
parameter GET_Sj1=       	 11'b00_010_100_000;
parameter Wait_for_data3= 	 11'b00_010_101_000;
parameter Write_to_Sj1=   	 11'b00_010_110_001;
parameter Wait_for_data4= 	 11'b00_010_111_000;
parameter Write_to_Si3=   	 11'b00_011_000_001;
parameter SWAPPED_J1=  	  	 11'b00_011_001_000;
parameter GET_NEW_J1_2=   	 11'b00_011_001_000;
parameter SWAPPED_I3= 	  	 11'b00_011_010_000;
parameter GET_NEW_I3=     	 11'b00_011_011_000;
parameter Sum_Si_Sj=	  	 11'b00_011_100_000;
parameter WAIT_FOR_SUM_ARRAY=11'b00_011_101_000;
parameter GET_F=		     11'b00_011_110_000;
parameter start_ROM=		 11'b00_011_111_000;
parameter WAIT_ROM=			 11'b00_100_000_000;
parameter XOR_F_and_enc=	 11'b00_100_001_000;
parameter WRITE_TO_DECRYPTED=11'b00_100_010_010;
parameter INCREMENT_K=		 11'b00_100_011_000;
parameter SUCCESS=			 11'b00_100_100_000;
//task3 states 
parameter TASK3=			  11'b00_100_101_000;
parameter CRACKED=			  11'b01_100_110_100;
parameter FAILED=			  11'b10_100_111_000;
parameter READ_DECRYPTED=	  11'b00_101_000_000;
parameter WAIT_READ_DECRYPTED=11'b00_101_001_000;
parameter GOT_DECRYPTED=	  11'b00_101_010_000;
parameter GET_FAKE_SECRET_KEY=11'b00_101_011_000;
parameter GET_CRACKED_SIGNAL=11'b01_101_100_000;
parameter GET_FAILED_SIGNAL= 11'b10_101_101_000;

//To make your life easier in the lab, I will tell you that, 
//for every test case we will give you, 
//the two most significant bits in the correct key are 0




//i,j ,k
reg[8:0]i1=0;
reg[8:0]i2=0;
reg[8:0]i3=0;
reg[8:0]j=0;
reg[8:0]j1=0;
reg[8:0]k=0;
reg[8:0]k1=0;
//value of si sj
reg[7:0]value_si,value_sj,value_si3,value_sj1;
//secret key part
reg[7:0] fake_secret_key;
reg[23:0]longer_fake_secret_key;
reg[1:0] part;
//some parameters
wire[1:0]key_length =2'd3;
wire[5:0]message_length=6'd32;
reg[1:0] key_data;
//first we need to write to memory 
reg[10:0] state=TASK3;  //extra 2 bits for crakced and failed
//f value 
reg[7:0] f;
//decrypted encrypted things .
reg[7:0]value_encrypted,value_decrypted;
//state shower
wire[5:0]fake_state=state[8:3];
//secret key byte number 
reg[7:0]secret_key_byte0=0;
reg[7:0]secret_key_byte1=0;
reg[7:0]secret_key_byte2=0;

assign wren=state[0];
assign wren_d=state[1];
assign failed=state[10]; //for some reason did not work .
assign cracked=state[9];
assign secret_key=longer_fake_secret_key;

always@(posedge clk or posedge reset) begin 
if(reset) begin
i1<=0;
i2<=0;
i3<=0;
j<=0;
j1<=0;
k<=0;
k1<=0;
longer_fake_secret_key<=0;
secret_key_byte0<=0;
secret_key_byte1<=0;
secret_key_byte2<=0;
state<=TASK3;
end
else begin 
case(state) 
TASK3: begin //need to get new secret key
		longer_fake_secret_key<={secret_key_byte0,secret_key_byte1,secret_key_byte2};
		longer_fake_secret_key<=longer_fake_secret_key+1;
		state<=GET_FAKE_SECRET_KEY;
		end
GET_FAKE_SECRET_KEY:begin 
		secret_key_byte0<={2'b00,longer_fake_secret_key[21:16]};
		secret_key_byte1<=longer_fake_secret_key[15:8];
		secret_key_byte2<=longer_fake_secret_key[7:0];
		
		if(longer_fake_secret_key>24'hFFF_FFF)//can't reach that max value!!!
		state<=FAILED;
		else state<=TASK1;
		end
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
		else state<=TASK2B;
		end
GET_Si: begin  //give memory time to get Si
		
		part<=i2%key_length;
		state<=GET_SECRET_KEY;
		end 
GET_SECRET_KEY: begin 
			value_si<=q;
			if(part==2'd0)begin 
			fake_secret_key<=secret_key_byte0;
			state<=GET_J;
			end
			if(part==2'd1)begin 
			fake_secret_key<=secret_key_byte1;
			state<=GET_J;
			end
			if(part==2'd2)begin 
			fake_secret_key<=secret_key_byte2;
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

//NEW TASK2B

TASK2B: begin  //parameters i3,j1,k,f
		if(k<=6'd31) begin 
		i3<=(i3+1)%256;
		state<=GET_I3_ADDRESS;
		end
		else state<=CRACKED;
		end
GET_I3_ADDRESS: begin 
			address<=i3;
			state<=GET_Si3;
			end
GET_Si3: begin  //give memory time to get Si3
		
		state<=GET_NEW_J1;
		end
GET_NEW_J1: begin  
		value_si3<=q; //save it. s[i3]
		j1<=(j1+q)%256; //j=j+s[i3]
		state<=GET_J1_ADDRESS2;
		end
GET_J1_ADDRESS2: begin 
		address<=j1; 
		state<=GET_Sj1;
			end
GET_Sj1: begin  //give memory time to get Sj1
		
		state<=Wait_for_data3;
		end
Wait_for_data3: begin 
			value_sj1<=q; // store the value of s[j1] 
			//**//
			address<=j1;
			data<=value_si3;
			state<=Write_to_Sj1;
			end
Write_to_Sj1: begin //give memory time to write Sj1 
		state<=Wait_for_data4;
		end
Wait_for_data4: begin 
			address<=i3;
			data<=value_sj1;
			state<=Write_to_Si3;
			end
Write_to_Si3: begin //give memory time to write S[i3]
			state<=Sum_Si_Sj; 
				end

Sum_Si_Sj: begin 
			address<=(value_sj1+value_si3)%256; // s[i]+s[j]
			state<=WAIT_FOR_SUM_ARRAY;
			end
WAIT_FOR_SUM_ARRAY: begin  //waiting to get the array value
				state<=GET_F;
					end		
GET_F: 		begin 
		f<=q; //f = s[ (s[i]+s[j]) ]
		state<= start_ROM;
		end		
start_ROM: begin //need to get encrypted input
		address_m<=k; 
		state<=WAIT_ROM;
			end		
WAIT_ROM: begin  //chill and wait for rom to get encrypted_input[k]
		
		state<=XOR_F_and_enc;

			end
XOR_F_and_enc:begin 
				address_d<=k;
				data_d <= f^q_m; // f xor encrypted_input[k]
				state<=WRITE_TO_DECRYPTED;
				end
WRITE_TO_DECRYPTED: begin //wait for decrypted to Write !!wren_d is 1

			state<=READ_DECRYPTED;
end

//task3 kinda things.

READ_DECRYPTED: begin
				address_d<=k;
				state<=WAIT_READ_DECRYPTED;
				end

WAIT_READ_DECRYPTED: begin //give memory time to read decrypted value
				state<= GOT_DECRYPTED;
					end		

GOT_DECRYPTED:  begin  //7*16+10*1=122 16*6+1 =97 2*16=32 (space)
				if(q_d==8'h20 || ((q_d >=8'h61)&&(q_d<=8'h7A)) ) begin 
				k<=k+1;// we are doing the incrementing here 
				if(k>message_length)  state<=CRACKED; 
				else state<=TASK2B;
				 end else begin 
				 i1<=0;
				 i2<=0;
				 i3<=0;
				 j<=0;
				 j1<=0;
				 k<=0;
				 state<= TASK3; //do everything again
				        end
											
end
CRACKED: begin 
		
		state<=GET_CRACKED_SIGNAL;
		end 
GET_CRACKED_SIGNAL: begin state<=GET_CRACKED_SIGNAL;		end
FAILED: begin 
		
		state<=GET_FAILED_SIGNAL;
		end 
GET_FAILED_SIGNAL: state<=GET_FAILED_SIGNAL;
endcase 
end
	end



endmodule 
