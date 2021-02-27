
module task1_tb;
reg clk,reset;
wire [7:0]address,i; 
wire finished_task1,wren;


task1 dut(clk,reset,address,i,finished_task1,wren);


initial begin 
clk=1'b1; #5;
forever begin 
clk=1'b0; #5;
clk=1'b1; #5;
end
end


initial begin 

#10 ; //first clk 
reset=1'b1;
#10 ;//second clk 
reset=1'b0;
#2590;
reset=1'b1;
#10;
reset=1'b0;
#2600;

$stop(0);
end 







endmodule 