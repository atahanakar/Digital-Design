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
   output [6:0]HEX5 , //


    wire[3:0]nIn,nIn1,nIn2,nIn3,nIn4,nIn5;
 SevenSegmentDisplayDecoder for_Hex0 ( HEX0 ,nIn );
  SevenSegmentDisplayDecoder for_Hex1 ( HEX1 ,nIn1 );
   SevenSegmentDisplayDecoder for_Hex2 ( HEX2 ,nIn2 );
    SevenSegmentDisplayDecoder for_Hex3 ( HEX3 ,nIn3 );
     SevenSegmentDisplayDecoder for_Hex4 ( HEX4 ,nIn4 );
      SevenSegmentDisplayDecoder for_Hex5 ( HEX5 ,nIn5 );


    wire clk=CLOCK_50;
    wire reset_n=KEY[3];


endmodule 