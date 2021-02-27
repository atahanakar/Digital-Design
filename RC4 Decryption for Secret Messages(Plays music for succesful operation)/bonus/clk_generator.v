

module clk_divider(clk_in,SW,slower,clk_out); //got help from internet.
input clk_in;
input SW;
input[31:0]slower;
output clk_out;

reg [31:0]counter = 32'd0; //start to count from 0


always@(posedge clk_in)  //synchronous always block 
begin 
counter<= counter+32'd1;
if(counter>=SW?slower:1)
counter<=32'd0;
end

assign clk_out= (counter<(SW?slower:1)/2)? 1'b0: 1'b1;  //give the value of the out determined by the given note

endmodule 