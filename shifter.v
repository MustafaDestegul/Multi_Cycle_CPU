
module shifter(data, sh_type, out);
	input [7:0] data;
	input [2:0] sh_type;
	
	output reg [7:0] out;
	
	always @(*)
	begin
		if(sh_type==3'd0) 					//rotate left
			out = {data[6:0],data[7]};
		else if(sh_type==3'd1)					//rotate right
			out = {data[0],data[7:1]};
		else if(sh_type==3'd2)					//shift left
			out = {data[6:0],1'b0};
		else if(sh_type==3'd3)					//arithmetic shift right
			out = {data[7],data[7:1]};
		else if(sh_type==3'd4)					// logical shift right
			out = {1'b0,data[7:1]};
	end

endmodule
