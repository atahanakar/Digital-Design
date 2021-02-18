
module hex_controller(sw,out);
input[3:0]sw;
output reg[41:0] out; //


`define DO1 4'b0001
`define RE  4'b0011
`define MI  4'b0101
`define FA  4'b1001
`define SOL 4'b0111
`define LA  4'b1011
`define SI  4'b1101
`define DO2 4'b1111
	  //     654 3210
`define NOTHING 7'b111_1111
	  //     654 3210
`define EIGHT 7'b000_0000
`define TWO   7'b010_0100  
`define ZERO  7'b100_0000
`define THREE 7'b011_0000
`define ONE   7'b111_1001
//		  654_3210
`define     d  7'b010_0001
`define     o  7'b010_0011
`define     r  7'b010_1111
`define     E  7'b000_0110
`define     n  7'b010_1011  //double n = m
`define     i  7'b111_1011
`define     f  7'b000_1110
`define     a  7'b000_1000
`define     s  7'b001_0010
`define     L  7'b100_0111  //L 
`define		H  7'b000_1001
`define     y  7'b001_1001
`define		b  7'b000_0011

  //    0000
  //   5    1
  //   5    1
  //    6666
  //   4    2
  //   4    2
  //    3333
  //


always@(*)
case(sw)

`DO1:out= {`NOTHING,`NOTHING,`NOTHING,`NOTHING,`d,`o};
`RE: out= {`NOTHING,`NOTHING,`NOTHING,`NOTHING,`r,`E};
`MI: out= {`NOTHING,`NOTHING,`NOTHING,`n,`n,`i};
`FA: out= {`NOTHING,`NOTHING,`NOTHING,`NOTHING,`f,`a};
`SOL:out= {`NOTHING,`NOTHING,`NOTHING,`s,`o,`ONE};
`LA: out= {`NOTHING,`NOTHING,`NOTHING,`NOTHING,`L,`a};
`SI: out= {`NOTHING,`NOTHING,`NOTHING,`NOTHING,`s,`i};
`DO2:out= {`NOTHING,`NOTHING,`NOTHING,`d,`o,`TWO};
4'bxxx0: out={`H,`E,`y,`b,`r,`o};
default:out= {`H,`E,`y,`b,`r,`o};  //no sound because when sw0 is down there should be no sound.
endcase
endmodule 