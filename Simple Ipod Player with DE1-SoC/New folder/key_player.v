
module key_player(key,out);
input[3:0]key;
output reg[31:0]out;

`define DO1 4'b1000
`define RE  4'b0100
`define MI  4'b0010
`define FA  4'b0001
//`define SOL 4'b0100
`define LA  4'b0101
`define SI  4'b0110
`define DO2 4'b0111

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
casex(~key) //This will output the input of the clock divider to give the wanted note.
`DO1:out= `mi_sound;
`RE: out= `re_sound;
`MI: out= `do1_sound;
`FA: out= `do2_sound;
default: out=`no_sound ;  //no sound because when sw0 is down there should be no sound.
endcase




endmodule 