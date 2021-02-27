
module speed_control(clk,key,speed);
input clk;
input [2:0]key;
output reg speed;

wire [7:0]reset_speed= 32'h470;

always@(clk)
case(key)
3'b110:speed=speed-32'h10;
3'b101:speed=speed+32'h10;
3'b011:speed=reset_speed;
default: speed=reset_speed; 
endcase 

endmodule 
