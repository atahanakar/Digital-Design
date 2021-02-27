
module led_controller(clk_in,out,out2);  //out2 is LEDs kind of clk divider.
input clk_in; 
output  out;
output[7:0] out2;

reg [31:0]counter2=32'd0; //start to count from 0. 
reg [9:0]counter_for_leds=10'b0_0000_0001_1; //start from led0 bit 0 is sayingg that it is going right bit 9 says that it is going left

always@(posedge clk_in )begin
counter2<=counter2+1'd1;
if((counter2>=32'd50_000_000 - 1'd1) &&(counter_for_leds[0]) )begin
counter2<=1'd0;
counter_for_leds[7:1]<=counter_for_leds[7:1]<<1; //shifted one to left to 
if(counter_for_leds[7]==1'b1)begin
counter_for_leds[0]<=1'b0; 
counter_for_leds[8]<=1'b1;
end
end
else if((counter2>=32'd50_000_000 - 1'd1) &&~(counter_for_leds[0]) )begin
counter2<=1'd0;
counter_for_leds[8:2]<=counter_for_leds[8:2]>>1; //shifted one to right to 
if(counter_for_leds[2]==1'b1)begin
counter_for_leds[0]<=1'b1; 
counter_for_leds[1]<=1'b1;
end
end
end

assign out=(counter2<32'd25_000_000)?1'b0: 1'b1; //give the output in a given frequency.
assign out2=8'b1111_1111&counter_for_leds[8:1];   //counter_for_leds is basically shifted makes our work easier.
endmodule 