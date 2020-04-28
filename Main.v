// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 13.1.0 Build 162 10/23/2013 SJ Full Version"
// CREATED		"Fri Apr 24 14:02:35 2020"

module Main(
	clk,
	PCWrite,
	MemWrite,
	IRWrite,
	RegWrite,
	Rd_Sel,
	Reg_Src,
	AdrSrc,
	ALUControl,
	ALUSrcA,
	ALUSrcB,
	PCChoose,
	ResultSrc,
	ShiftType,
	WD3_Sel,
	AAALU_RESULT,
	AAInstr_Entry,
	AAReg_16bit,
	ALUFlags,
	Instr,
	Mux_Out_8x1,
	RD_OUTPUT,
	Reg0_Out,
	Reg1_Out,
	Reg2_Out,
	Reg3_Out,
	Reg4_Out
);


input wire	clk;
input wire	PCWrite;
input wire	MemWrite;
input wire	IRWrite;
input wire	RegWrite;
input wire	Rd_Sel;
input wire	Reg_Src;
input wire	[1:0] AdrSrc;
input wire	[2:0] ALUControl;
input wire	[1:0] ALUSrcA;
input wire	[1:0] ALUSrcB;
input wire	[1:0] PCChoose;
input wire	[1:0] ResultSrc;
input wire	[2:0] ShiftType;
input wire	[2:0] WD3_Sel;
output wire	[7:0] AAALU_RESULT;
output wire	[7:0] AAInstr_Entry;
output wire	[7:0] AAReg_16bit;
output wire	[3:0] ALUFlags;
output wire	[15:0] Instr;
output wire	[7:0] Mux_Out_8x1;
output wire	[2:0] RD_OUTPUT;
output wire	[7:0] Reg0_Out;
output wire	[7:0] Reg1_Out;
output wire	[7:0] Reg2_Out;
output wire	[7:0] Reg3_Out;
output wire	[7:0] Reg4_Out;

wire	[3:0] ALUFlags_ALTERA_SYNTHESIZED;
wire	[7:0] INDIRECT;
wire	[15:0] instr_ALTERA_SYNTHESIZED;
wire	[7:0] src2_Extension;
wire	SYNTHESIZED_WIRE_0;
wire	[7:0] SYNTHESIZED_WIRE_1;
wire	[7:0] SYNTHESIZED_WIRE_41;
wire	[7:0] SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	[7:0] SYNTHESIZED_WIRE_42;
wire	[7:0] SYNTHESIZED_WIRE_43;
wire	[7:0] SYNTHESIZED_WIRE_44;
wire	[7:0] SYNTHESIZED_WIRE_8;
wire	[7:0] SYNTHESIZED_WIRE_9;
wire	[7:0] SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_11;
wire	[7:0] SYNTHESIZED_WIRE_45;
wire	SYNTHESIZED_WIRE_46;
wire	[15:0] SYNTHESIZED_WIRE_47;
wire	[7:0] SYNTHESIZED_WIRE_15;
wire	[7:0] SYNTHESIZED_WIRE_17;
wire	[7:0] SYNTHESIZED_WIRE_18;
wire	[2:0] SYNTHESIZED_WIRE_19;
wire	[2:0] SYNTHESIZED_WIRE_20;
wire	[7:0] SYNTHESIZED_WIRE_21;
wire	[7:0] SYNTHESIZED_WIRE_26;
wire	[2:0] SYNTHESIZED_WIRE_31;
wire	[7:0] SYNTHESIZED_WIRE_34;
wire	SYNTHESIZED_WIRE_48;
wire	[7:0] SYNTHESIZED_WIRE_36;
wire	[7:0] SYNTHESIZED_WIRE_38;
wire	[7:0] SYNTHESIZED_WIRE_39;
wire	[7:0] SYNTHESIZED_WIRE_40;

assign	AAALU_RESULT = SYNTHESIZED_WIRE_42;
assign	AAInstr_Entry = SYNTHESIZED_WIRE_26;
assign	Mux_Out_8x1 = SYNTHESIZED_WIRE_21;
assign	RD_OUTPUT = SYNTHESIZED_WIRE_20;
assign	SYNTHESIZED_WIRE_0 = 0;
assign	SYNTHESIZED_WIRE_4 = 0;
assign	SYNTHESIZED_WIRE_11 = 0;
assign	SYNTHESIZED_WIRE_46 = 0;
assign	SYNTHESIZED_WIRE_48 = 0;




Register_With_WE	b2v_inst(
	.clk(clk),
	.reset(SYNTHESIZED_WIRE_0),
	.we(PCWrite),
	.load(SYNTHESIZED_WIRE_1),
	.out(SYNTHESIZED_WIRE_43));
	defparam	b2v_inst.W = 8;


Zero_Extend	b2v_inst1(
	.input_(instr_ALTERA_SYNTHESIZED[2:0]),
	.output_(src2_Extension));


Mux_4x1	b2v_inst10(
	.s0(ALUSrcB[0]),
	.s1(ALUSrcB[1]),
	.in0(SYNTHESIZED_WIRE_41),
	.in1(src2_Extension),
	.in2(SYNTHESIZED_WIRE_3),
	.in3(INDIRECT),
	.out(SYNTHESIZED_WIRE_40));
	defparam	b2v_inst10.W = 8;


Simple_Register	b2v_inst11(
	.clk(clk),
	.reset(SYNTHESIZED_WIRE_4),
	.load(SYNTHESIZED_WIRE_42),
	.out(SYNTHESIZED_WIRE_15));
	defparam	b2v_inst11.W = 8;


Adder4	b2v_inst12(
	.adder_4_in(SYNTHESIZED_WIRE_43),
	.adder_4_out(SYNTHESIZED_WIRE_8));


Mux_8x1	b2v_inst13(
	.s0(WD3_Sel[0]),
	.s1(WD3_Sel[1]),
	.s2(WD3_Sel[2]),
	.in0(SYNTHESIZED_WIRE_44),
	.in1(INDIRECT),
	.in2(SYNTHESIZED_WIRE_8),
	.in3(SYNTHESIZED_WIRE_9),
	.in4(src2_Extension),
	.in5(SYNTHESIZED_WIRE_10),
	
	
	.out(SYNTHESIZED_WIRE_21));
	defparam	b2v_inst13.W = 8;


Simple_Register	b2v_inst14(
	.clk(clk),
	.reset(SYNTHESIZED_WIRE_11),
	.load(SYNTHESIZED_WIRE_45),
	.out(SYNTHESIZED_WIRE_34));
	defparam	b2v_inst14.W = 8;





Register_With_WE	b2v_inst18(
	.clk(clk),
	.reset(SYNTHESIZED_WIRE_46),
	.we(IRWrite),
	.load(SYNTHESIZED_WIRE_47),
	.out(instr_ALTERA_SYNTHESIZED));
	defparam	b2v_inst18.W = 16;


Mux_4x1	b2v_inst20(
	.s0(ResultSrc[0]),
	.s1(ResultSrc[1]),
	.in0(SYNTHESIZED_WIRE_15),
	.in1(SYNTHESIZED_WIRE_42),
	.in2(SYNTHESIZED_WIRE_17),
	.in3(SYNTHESIZED_WIRE_18),
	.out(SYNTHESIZED_WIRE_44));
	defparam	b2v_inst20.W = 8;


Register_File	b2v_inst21(
	.clk(clk),
	.RegWrite(RegWrite),
	.A1(instr_ALTERA_SYNTHESIZED[5:3]),
	.A2(SYNTHESIZED_WIRE_19),
	.A3(SYNTHESIZED_WIRE_20),
	
	.WD3(SYNTHESIZED_WIRE_21),
	.RD1(SYNTHESIZED_WIRE_36),
	.RD2(SYNTHESIZED_WIRE_38),
	.Reg0(Reg0_Out),
	.Reg1(Reg1_Out),
	.Reg2(Reg2_Out),
	.Reg3(Reg3_Out),
	.Reg4(Reg4_Out));
	defparam	b2v_inst21.W = 8;



producer4	b2v_inst23(
	.out(SYNTHESIZED_WIRE_3));



Simple_Reg_16bit	b2v_inst27(
	.clk(clk),
	.reset(SYNTHESIZED_WIRE_46),
	.load(SYNTHESIZED_WIRE_47),
	.out(INDIRECT));
	defparam	b2v_inst27.W = 16;


Mux_4x1	b2v_inst28(
	.s0(AdrSrc[0]),
	.s1(AdrSrc[1]),
	.in0(SYNTHESIZED_WIRE_43),
	.in1(SYNTHESIZED_WIRE_44),
	
	
	.out(SYNTHESIZED_WIRE_26));
	defparam	b2v_inst28.W = 8;


Instr_Data_Mem	b2v_inst3(
	.clk(clk),
	.MemWrite(MemWrite),
	.Address(SYNTHESIZED_WIRE_26),
	.WD(SYNTHESIZED_WIRE_41),
	.RD(SYNTHESIZED_WIRE_47));


Producer0	b2v_inst30(
	.out(SYNTHESIZED_WIRE_17));


Producer0	b2v_inst31(
	.out(SYNTHESIZED_WIRE_9));


Mux_4x1	b2v_inst32(
	.s0(PCChoose[0]),
	.s1(PCChoose[1]),
	.in0(SYNTHESIZED_WIRE_44),
	.in1(SYNTHESIZED_WIRE_45),
	.in2(instr_ALTERA_SYNTHESIZED[7:0]),
	
	.out(SYNTHESIZED_WIRE_1));
	defparam	b2v_inst32.W = 8;


shifter	b2v_inst33(
	.data(SYNTHESIZED_WIRE_41),
	.sh_type(ShiftType),
	.out(SYNTHESIZED_WIRE_18));


Producer7	b2v_inst35(
	.out0(SYNTHESIZED_WIRE_31)
	);


RandomNumberGenerator	b2v_inst36(
	.out(SYNTHESIZED_WIRE_10));


Mux_2x1	b2v_inst4(
	.s0(Rd_Sel),
	.in0(instr_ALTERA_SYNTHESIZED[8:6]),
	.in1(SYNTHESIZED_WIRE_31),
	.out(SYNTHESIZED_WIRE_20));
	defparam	b2v_inst4.W = 3;


Mux_2x1	b2v_inst5(
	.s0(Reg_Src),
	.in0(instr_ALTERA_SYNTHESIZED[2:0]),
	.in1(instr_ALTERA_SYNTHESIZED[8:6]),
	.out(SYNTHESIZED_WIRE_19));
	defparam	b2v_inst5.W = 3;


Mux_4x1	b2v_inst6(
	.s0(ALUSrcA[0]),
	.s1(ALUSrcA[1]),
	.in0(SYNTHESIZED_WIRE_43),
	.in1(SYNTHESIZED_WIRE_45),
	.in2(SYNTHESIZED_WIRE_34),
	
	.out(SYNTHESIZED_WIRE_39));
	defparam	b2v_inst6.W = 8;


Simple_Register	b2v_inst7(
	.clk(clk),
	.reset(SYNTHESIZED_WIRE_48),
	.load(SYNTHESIZED_WIRE_36),
	.out(SYNTHESIZED_WIRE_45));
	defparam	b2v_inst7.W = 8;


Simple_Register	b2v_inst8(
	.clk(clk),
	.reset(SYNTHESIZED_WIRE_48),
	.load(SYNTHESIZED_WIRE_38),
	.out(SYNTHESIZED_WIRE_41));
	defparam	b2v_inst8.W = 8;


ALU	b2v_inst9(
	.ALUControl2(ALUControl[2]),
	.ALUControl1(ALUControl[1]),
	.ALUControl0(ALUControl[0]),
	.input1(SYNTHESIZED_WIRE_39),
	.input2(SYNTHESIZED_WIRE_40),
	.CarryOut(ALUFlags_ALTERA_SYNTHESIZED[1]),
	.overflow(ALUFlags_ALTERA_SYNTHESIZED[0]),
	.Negative(ALUFlags_ALTERA_SYNTHESIZED[3]),
	.Zero(ALUFlags_ALTERA_SYNTHESIZED[2]),
	.out(SYNTHESIZED_WIRE_42));
	defparam	b2v_inst9.W = 8;

assign	AAReg_16bit = INDIRECT;
assign	ALUFlags = ALUFlags_ALTERA_SYNTHESIZED;
assign	Instr = instr_ALTERA_SYNTHESIZED;

endmodule
