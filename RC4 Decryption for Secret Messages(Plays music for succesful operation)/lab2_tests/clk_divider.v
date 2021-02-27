
module clk_divider(clk_in,notes,clk_out); //got help from internet.
input clk_in;
input[31:0]notes;
output clk_out;

reg [31:0]counter = 32'd0; //start to count from 0


always@(posedge clk_in)  //synchronous always block 
begin 
counter<= counter+32'd1;
if(counter>=notes)
counter<=32'd0;
end

assign clk_out= (counter<notes/2)? 1'b0: 1'b1;  //give the value of the out determined by the given note

endmodule 