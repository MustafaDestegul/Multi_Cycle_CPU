
module Register_With_WE #(parameter W= 16) (clk, reset, we, load, out);

	input clk, reset, we;
	input [W-1:0] load;
	output reg [W-1:0] out;

	initial begin
		out <= 0;
	end
	
	always @ (posedge clk)
	begin
		if(reset == 1) begin
			out <= 0;
		end else begin
			if(we == 1) begin
				out <= load;
			end
		end
	
	end
endmodule
