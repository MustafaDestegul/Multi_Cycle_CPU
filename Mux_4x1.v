
module Mux_4x1 #(parameter W=8) (s0,s1,in0,in1,in2,in3,out);
	

	input s0,s1;
	input [W-1:0] in0,in1,in2,in3;
	output reg [W-1:0] out;

	always @ (*) 
	begin
		case({s1,s0})					
			2'b00: out = in0;
			2'b01: out = in1;
			2'b10: out = in2;
			2'b11: out = in3;
		
		endcase
	end

endmodule
