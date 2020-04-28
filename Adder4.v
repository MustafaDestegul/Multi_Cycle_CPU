module Adder4 (adder_4_in, adder_4_out);

input [7:0] adder_4_in;
output reg [7:0] adder_4_out;



always@(adder_4_in)
begin
	adder_4_out<=adder_4_in + 8'd4;

end
endmodule

