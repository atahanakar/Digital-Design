//library ieee;
//use ieee.std_logic_1164.all;
//use ieee.numeric_std.all;

module ksa 
  (
    input CLOCK_50   ,         // -- Clock pin
    input [3:0]KEY  ,            //   -- push button switches
   input [9:0] SW ,               // : in  std_logic_vector(9 downto 0);  -- slider switches
   output[9:0]  LEDR , // -- red lights
   output [6:0] HEX0 ,// 
  output  [6:0]HEX1 ,//
   output [6:0]HEX2 , //
  output [6:0] HEX3 ,//
   output [6:0]HEX4 ,// 
   output [6:0]HEX5 //
	) ;
	


    wire[3:0]nIn,nIn1,nIn2,nIn3,nIn4,nIn5;
 SevenSegmentDisplayDecoder for_Hex0 ( HEX0 ,secret_key[3:0] );
  SevenSegmentDisplayDecoder for_Hex1 ( HEX1 ,secret_key[7:4] );
   SevenSegmentDisplayDecoder for_Hex2 ( HEX2 ,secret_key[11:8] );
    SevenSegmentDisplayDecoder for_Hex3 ( HEX3 ,secret_key[15:12] );
     SevenSegmentDisplayDecoder for_Hex4 ( HEX4 ,secret_key[19:16] );
      SevenSegmentDisplayDecoder for_Hex5 ( HEX5 ,secret_key[23:20] );
		
		//s memory
	wire	[7:0]  address,address_m,address_d;
	wire wren_task1;
	wire	  clock;
	wire	[7:0]  data,data_d; //data
	wire	  wren,wren_d;
	wire	[7:0]  q,q_m,q_d;
	wire[23:0] secret_key;
    wire clk=CLOCK_50;
    wire reset_n=~KEY[3];
	
	 
	
	 
	 //task2b
	
	assign secret_key=24'h000249 ;
	 
	
	 s_memory  S_MEM(address,clk,data,wren,q);
	 task2b TASK222BBBBB(clk,reset_n,wren,q,data,address,secret_key,address_m,q_m,address_d,data_d,wren_d,q_d,LEDR[1:0]); //clk,reset,wren,q,data,address,secret_key
	 e_memory E_MEM(address_m,clk,q_m);
	 d_memory D_MEM(address_d,clk,data_d,wren_d,q_d);
	 
	 
	 /*	
parameter WRITE_S=7'b000000_0;
parameter WRITE_S_MEMORY=7'b000001_1;
parameter INCREMENT_I1=7'b000010_0;
parameter WRITE_J=7'b000011_0;




//i,j 
reg[8:0]i1=0;
reg[8:0]i2=0;
reg[8:0]j=0;

//some parameters
wire[1:0]key_length =2'd3;

//first we need to write to memory 
reg[6:0] state=WRITE_S; 

assign wren=state[0];


always@(posedge clk or posedge reset_n) begin 
if(reset_n) begin
i1<=0;
i2<=0;
j<=0;
state<=WRITE_S;
end
else begin 
case(state) 
WRITE_S: begin if(i1<=255) begin 
		address<=i1 ;
		data<=i1;
		state<=WRITE_S_MEMORY;
		end 
		else 
		state<=WRITE_J;
		end
WRITE_S_MEMORY:begin  //give memory time to write.
				state<=INCREMENT_I1;

					end
INCREMENT_I1: begin 
			i1<=i1+1;
			state<=WRITE_S;
			end
			


endcase 
end
	end
	*/ 


endmodule 