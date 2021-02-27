module task1(clk,reset,address,i,finished_task1,finished_task1,wren_task1);
input clk,reset;
output reg [7:0]address;
output reg[7:0] i;
output reg finished_task1;
output wren_task1;

assign wren_task1=~finished_task1;



reg [8:0]k=0;
reg [8:0]fake_address=0;

always@ (posedge clk or posedge reset)begin 
if(reset)begin
k<=8'd0;
fake_address<=8'd0;
finished_task1<=1'b0;
end
else begin 
if(k<=255)begin 
address<=fake_address;
i<=k;
k<=k+1;
fake_address<=fake_address+8'd1;
finished_task1<=1'b0;
end

if(k==256)
finished_task1<=1'b1;
end 
end


endmodule 



