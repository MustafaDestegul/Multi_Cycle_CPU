
module Simple_Register #(parameter W=8)(clk, reset, load, out);

	input [W-1:0] load;
	input clk, reset;
	
	output reg [W-1:0] out;
	
	initial begin
		out <= 0;
	end
	
	always @ (posedge clk)
	begin
		//check reset
		if(reset == 1) begin
			out <= 0;
		end else begin
			out <= load[7:0];
		end
 	
	end
	
endmodule
