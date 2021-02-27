module task2_tb;//task2(clk,reset,wren,q,data,address,secret_key);
reg clk,reset;
reg[23:0]secret_key;
reg[7:0]q;

wire wren;
wire[7:0]data,address;


task2 dut(clk,reset,wren,q,data,address,secret_key);


initial begin 
clk=1'b1; #5;
forever begin 
clk=1'b0; #5;
clk=1'b1; #5;
end
end


initial begin 
secret_key=23'h000249;

#10 ; //first clk 

#10 ;//second clk 
reset=1'b0;
#2590;

#10;
reset=1'b0;
#2600;

$stop(0);
end 


endmodule


