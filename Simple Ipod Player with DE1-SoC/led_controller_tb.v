

module led_controller_tb;
reg clk_in;
wire out2;
wire out;



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


led_controller dut(clk_in,out,out2);

initial begin 
clk_in=1'b0; #5;
forever begin
clk_in=1'b1; #5;
clk_in=1'b0; #5;
end
end 
initial begin 
#1000000000;

$stop(0);


end


endmodule  