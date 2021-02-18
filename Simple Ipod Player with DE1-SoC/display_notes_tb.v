
//module display_notes(sw,out);
module display_notes_tb;
reg [3:0]sw;
wire[31:0]out;



`define DO1 4'b0001
`define RE  4'b0011
`define MI  4'b0101
`define FA  4'b1001
`define SOL 4'b0111
`define LA  4'b1011
`define SI  4'b1101
`define DO2 4'b1111
//sounds 
`define do1_sound 32'd50_000_000 / 32'd523
`define re_sound 32'd50_000_000 / 32'd587
`define mi_sound 32'd50_000_000 / 32'd659
`define fa_sound 32'd50_000_000 / 32'd698
`define sol_sound 32'd50_000_000 / 32'd783
`define la_sound 32'd50_000_000 / 32'd880
`define si_sound 32'd50_000_000 / 32'd987
`define do2_sound 32'd50_000_000 / 32'd1046
`define no_sound  32'd0


display_notes dut(sw,out);

initial begin 
sw=4'b0000; #5;
$display("expected out=%d ,out= %d",`no_sound,out);
#5;
sw=4'b0001;  #5;
$display("expected out=%d ,out= %d",`do1_sound,out);
#5;
sw=4'b0011;  #5;
$display("expected out=%d ,out= %d",`re_sound,out);
#5;
sw=4'b0101; 
$display("expected out=%d ,out= %d",`mi_sound,out);
#5;
sw=4'b1001;  #5;
$display("expected out=%d ,out= %d",`fa_sound,out);
#5;
sw=4'b0111;  #5;
$display("expected out=%d ,out= %d",`sol_sound,out);
#5;



end



endmodule 