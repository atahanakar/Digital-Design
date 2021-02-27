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
	wire	  clock;
	wire	[7:0]  data,data_d; //data
	wire	  wren,wren_d,code_runing,failed,cracked;
	wire	[7:0]  q,q_m,q_d;
	wire[23:0] secret_key;
    wire clk; //bonus 
    wire reset_n=~KEY[3];

	 
	
	 
	 //task3
	
	 
	
	 s_memory  S_MEM(address,clk,data,wren,q);
	 task3 TASK222BBBBB(clk,reset_n,wren,q,data,address,secret_key,address_m,q_m,address_d,data_d,wren_d,q_d,cracked,failed); //clk,reset,wren,q,data,address,secret_key
	 e_memory E_MEM(address_m,clk,q_m);
	 d_memory D_MEM(address_d,clk,data_d,wren_d,q_d);
	 
	 
	 assign LEDR[0]=cracked;
	 assign LEDR[1]=failed;
	 // let's do some bonus 
	 //let's use a slower clk 
	 wire[31:0]slower = 32'd2;
	 
	assign clk=SW[0]?CLOCK_50:0;//SW0 is like a go signal.
 	assign LEDR[9]=SW[9];
	assign LEDR[8]=SW[8];
	assign LEDR[7]=SW[7];
	assign LEDR[6]=SW[6];
	assign LEDR[5]=SW[5];
	assign LEDR[4]=SW[4];
	assign LEDR[3]=SW[3];
	assign LEDR[2]=SW[2];
	

endmodule 