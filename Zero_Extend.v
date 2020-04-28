
module Zero_Extend(input1,input2,output1,output2);
		
	input [2:0] input1;
	input [5:0] input2;
	
	output reg [7:0] output1;
	output reg [7:0] output2;
	
	always @ (input1 or input2)
	begin
		output1= {5'b0, input1};			//zero extention  to 8 bit
		output2= {2'b0, input1};			//zero extention  to 8 bit
	end
	
	
endmodule
