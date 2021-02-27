module fsm(synchronized_clk,
button,
flash_mem_readdata,
flash_mem_address,
flash_data,
ready
	);
input synchronized_clk;
input [31:0] flash_mem_readdata;
input [7:0]button;

output reg [22:0]flash_mem_address;
output reg[7:0]flash_data;
output reg ready;


//Buttons 
parameter F=8'h46 ;
parameter E=8'h45 ;
parameter R=8'h52 ; 
parameter D=8'h44; 
parameter B=8'h42 ;

parameter f_l=8'h66 ;
parameter e_l=8'h65;
parameter r_l=8'h72;
parameter d_l=8'h64;
parameter b_l=8'h62;


//states
parameter IDLE=6'b0000_00;
parameter GetAddress=6'b0001_01;
parameter GetData=6'b0010_00;
parameter PlaySong=6'b0011_00;
parameter Forward=6'b0100_00;
parameter Backward=6'b0101_00;
parameter Pause=6'b0110_00;
parameter Restart=6'b0111_00;
parameter Finished=6'b1000_10;
reg [5:0] c_state=IDLE;
reg[5:0]n_state;


wire PLAY_BUTTON=    (button==E)|(button==e_l);
wire RESTART_BUTTON= (button==R)|(button==r_l);
wire FORWARD_BUTTON= (button==F)|(button==f_l);
wire PAUSE_BUTTON=   (button==D)|(button==d_l);
wire BACKWARD_BUTTON=(button==B)|(button==b_l);

//Initializiation
reg flag=1'b0;



always@ (posedge synchronized_clk)begin
if(flag==1) begin 
case (c_state)
IDLE: if(PLAY_BUTTON)begin ready<=1;
		n_state<=GetAddress;end 
		else begin 
		n_state<=IDLE; 
		flash_mem_address<=23'h0;
		end
GetAddress: if(PAUSE_BUTTON) flash_mem_address<=flash_mem_address;
				else if(PLAY_BUTTON) flash_mem_address<=flash_mem_address+23'd1;
				else if(FORWARD_BUTTON)flash_mem_address<=flash_mem_address+23'd1;
				else if(BACKWARD_BUTTON)flash_mem_address<=flash_mem_address-23'd1;
				else if(RESTART_BUTTON)flash_mem_address<=23'd0;
				else flash_data<=flash_mem_readdata[31:24];
GetData:   begin 
				flash_data<=8'b0;
				ready<=1'b0;
				n_state<=IDLE;
				end
				
				default:n_state<=GetAddress;
endcase 
			c_state<=n_state;
			flag<=~flag;
end  else begin 
			if(PAUSE_BUTTON)
			flash_data<=8'b0;
			else begin 
			flash_data<=flash_mem_readdata[7:0];
			flag<=~flag;
			end
			end
			
	end
	
endmodule


	
 








