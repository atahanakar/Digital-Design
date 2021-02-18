
module doremi(sw,out);

input[3:0]sw;
output reg [31:0] out;
`define DO1 4'b0001
`define RE  4'b0011
`define MI  4'b0101
`define FA  4'b1001
`define SOL 4'b0111
`define LA  4'b1011
`define SI  4'b1101
`define DO2 4'b1111
//sounds 			//FREQUENCIES OF THE NOTES 
`define do1_sound 32'd50_000_000 / 32'd523
`define re_sound 32'd50_000_000 / 32'd587
`define mi_sound 32'd50_000_000 / 32'd659
`define fa_sound 32'd50_000_000 / 32'd698
`define sol_sound 32'd50_000_000 / 32'd783
`define la_sound 32'd50_000_000 / 32'd880
`define si_sound 32'd50_000_000 / 32'd987
`define do2_sound 32'd50_000_000 / 32'd1046
`define no_sound  32'd0

always @(*)
casex(sw) //This will output the input of the clock divider to give the wanted note.
`DO1:out= `do1_sound;
`RE: out= `re_sound;
`MI: out= `mi_sound;
`FA: out= `fa_sound;
`SOL:out= `sol_sound; 
`LA: out= `la_sound;
`SI: out= `si_sound;
`DO2:out= `do2_sound ;
4'bxxx0: out=`no_sound ;
default:out= `no_sound;  //no sound because when sw0 is down there should be no sound.
endcase




endmodule 
