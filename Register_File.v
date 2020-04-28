
module Register_File #(parameter W=8) (clk, RegWrite, A1, A2, A3, WD3, PC_in, RD1, RD2, Reg0, Reg1, Reg2,Reg3, Reg4,LR);
	
	//inputs
	input clk, RegWrite;
	input [2:0] A1, A2, A3;
	input [W-1:0] WD3, PC_in;
	
	//outputs
	output [W-1:0] RD1,RD2;
	output reg [W-1:0] Reg0, Reg1, Reg2,Reg3, Reg4,LR;
	
	wire [W-1:0] out0, out1, out2,out3, out4, out5, out6, out7;
	
	//	//internal wires
	wire [7:0] write_enable;
	wire [7:0] decoder_out;
   wire [W-1:0] PC_out;
	
	
	//structural components
	Dex_3x8 d1(.in0(A3[0]), .in1(A3[1]), .in2(A3[2]), .out0(decoder_out[0]), .out1(decoder_out[1]), .out2(decoder_out[2]), .out3(decoder_out[3]),
																							 .out4(decoder_out[4]), .out5(decoder_out[5]), .out6(decoder_out[6]), .out7(decoder_out[7]));
																							 

  always@(*)
	begin
	
		Reg0<=out0;
		Reg1<=out1;
		Reg2<=out2;
		Reg3<=out3;
		Reg4<=out4;
		LR<=out7;
	
	end
																						
																						
	and a0(write_enable[0], RegWrite, decoder_out[0]);
	and a1(write_enable[1], RegWrite, decoder_out[1]);
	and a2(write_enable[2], RegWrite, decoder_out[2]);
	and a3(write_enable[3], RegWrite, decoder_out[3]);
	and a4(write_enable[4], RegWrite, decoder_out[4]);
	and a5(write_enable[5], RegWrite, decoder_out[5]);
	and a6(write_enable[6], RegWrite, decoder_out[6]);
	and a7(write_enable[7], RegWrite, decoder_out[7]);
	
	Register_With_WE #(W) R0(clk, 0, write_enable[0], WD3, out0);
	Register_With_WE #(W) R1(clk, 0, write_enable[1], WD3, out1);
	Register_With_WE #(W) R2(clk, 0, write_enable[2], WD3, out2);
	Register_With_WE #(W) R3(clk, 0, write_enable[3], WD3, out3);
	Register_With_WE #(W) R4(clk, 0, write_enable[4], WD3, out4);
	Register_With_WE #(W) R5(clk, 0, write_enable[5], WD3, out5);
	Register_With_WE #(W) R6(clk, 0, write_enable[6], WD3, out6);
	Register_With_WE #(W) R7(clk, 0, write_enable[7], WD3, out7);
	Register_With_WE #(W) R15(clk, 0, 1, PC_in, PC_out);
	
	Mux_8x1 m1(.s0(A1[0]),.s1(A1[1]),.s2(A1[2]),.in0(out0),.in1(out1),.in2(out2),.in3(out3),.in4(out4),
																			  .in5(out5),.in6(out6),.in7(out7),.out(RD1));
	Mux_8x1 m2(.s0(A2[0]),.s1(A2[1]),.s2(A2[2]),.in0(out0),.in1(out1),.in2(out2),.in3(out3),.in4(out4),
																			  .in5(out5),.in6(out6),.in7(out7),.out(RD2));

	
endmodule
