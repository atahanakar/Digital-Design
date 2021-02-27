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
 SevenSegmentDisplayDecoder for_Hex0 ( HEX0 ,nIn );
  SevenSegmentDisplayDecoder for_Hex1 ( HEX1 ,nIn1 );
   SevenSegmentDisplayDecoder for_Hex2 ( HEX2 ,nIn2 );
    SevenSegmentDisplayDecoder for_Hex3 ( HEX3 ,nIn3 );
     SevenSegmentDisplayDecoder for_Hex4 ( HEX4 ,nIn4 );
      SevenSegmentDisplayDecoder for_Hex5 ( HEX5 ,nIn5 );
		
		//s memory
	wire	[7:0]  address;
	wire wren_task1;
	wire	  clock;
	wire	[7:0]  data,data2,data_d; //data
	wire	  wren=~finished_task1;
	wire    wren2=1'b0;
	wire	[7:0]  q,q1;
	wire finished_task1;
	wire[23:0] secret_key;
    wire clk=CLOCK_50;
    wire reset_n=~KEY[3];
	
	 
	 //task1
	  task1 TASK111(clk,reset_n,address,data,finished_task1,wren_task1); //generated q. 
	 s_memory SSSSSS(address,clk,data,wren,q);
	 
	 //task2
	
	 assign secret_key[23:10]=14'b0; //set this bits to 0.
	 assign secret_key[9:0]=SW[9:0];
	// task2_fsm TASK222(clk,reset_n,secret_key,q,address_d,data_d,wren_d,q_d,q_m,address_m,finished_task1,wren,i,address);
	d_memory DDDDD(address_d,clk,data_d,wren_d,q_d);
	
	 
	
	 


endmodule 