//Mustafa Destegül
//2109973
module Instr_Data_Mem(clk,Address, RD, MemWrite,WD);
	input [7:0] Address;
	input [7:0] WD;
	input clk, MemWrite;
	output reg [15:0] RD;
	
	reg [7:0] Memory [0:63];
	
	
	integer i;	
	
	initial begin		// initializing memory for debug purposes														
		{Memory[1],Memory[0]}   = 16'b10_1_001_1_0_00010011;		//BL #19
		{Memory[3],Memory[2]}   = 16'b11_1_001_0_010_000101;  	//MOV R2, #5																						
		{Memory[5],Memory[4]}   = 16'b11_0_000_0_000_100100;  	//LDR R0,[R4,#4]
		{Memory[7],Memory[6]}   = 16'b00_0_000_0_011_001_110;		//ADD R3,R1,#6	
		{Memory[9],Memory[8]}   = 16'b00_0_010_0_001_010_001;		//SUB R1,R2,#1	
		{Memory[11],Memory[10]} = 16'b00_0_100_0_000_001_100;		//AND R0,R1,#4		
		{Memory[13],Memory[12]} = 16'b00_0_101_0_000_001_100;		//ORR R0,R1,#4	
		{Memory[15],Memory[14]} = 16'b00_0_110_0_010_011_011;		//XOR R2,R3,#3			
		{Memory[17],Memory[16]} = 16'b00_0_111_0_000_111_111;		//CLR R0	
		{Memory[19],Memory[18]} = 16'b01_0_000_0_010_111_111;		//RTL R2   ; all other shifts made with this since they are same almost exept shift_type control signal.	
		{Memory[21],Memory[20]} = 16'b10_1_000_0_0_00010011;		//BUN #19 
		{Memory[23],Memory[22]} = 16'b10_1_001_1_0_00010011;		//BL #19
		{Memory[25],Memory[24]} = 16'b10_0_010_1_111_100000;		//BX LR , BX R7
		{Memory[27],Memory[26]} = 16'b11_0_010_0_010_000_100;		//STR R2,[R0,#4]
		{Memory[29],Memory[28]} = 16'b00_0_001_0_011_010_100;		//ADDI R3,R2,R4
		{Memory[31],Memory[30]} = 16'b10_0_100_0_0_00010101;		//BEQ #21
		{Memory[33],Memory[32]} = 16'b10_0_101_0_0_00010101;		//BNE #21
		{Memory[35],Memory[34]} = 16'b10_0_010_1_010_101011;		//BIL R2
		{Memory[37],Memory[36]} = 16'b10_0_110_0_0_00010101;		//BCS #21
		{Memory[39],Memory[38]}   = 16'b10_0_111_0_0_00011110;		//BCC #30
		
		for(i=40; i<64; i= i+1) begin
			Memory[i] = 0;
		end
		
	end
	
	always @(Address)
	begin
		RD = {Memory[Address+1],Memory[Address]};
	end

	
	always @(posedge clk)  // wrie at the rising edge of the clock
	begin
		if(MemWrite) begin
			Memory[Address] <= WD;
		end
	end


	
endmodule

