//Mustafa Destegül
//2109973

module ALU #(parameter W=8)(input1, input2, ALUControl2, ALUControl1, ALUControl0, CarryOut, overflow, Negative, Zero, out);
	
	input [W-1:0] input1, input2;
	input ALUControl2, ALUControl1, ALUControl0;	
	output reg [W-1:0] out;
	output reg CarryOut, overflow, Negative, Zero;
	

	reg [W-1:0] opr_1, opr_2;
	reg [W:0] result;
	reg nz_reg, oc_reg;
	
	initial begin
		CarryOut = 0;
		overflow = 0;
		Negative = 0;
		Zero= 0;
		nz_reg = 0;
		oc_reg = 0;
	end
	
	
	always @ (*) 
	begin
		if({ALUControl2,ALUControl1,ALUControl0} > 3'b010) begin
			nz_reg = 1;
			oc_reg = 0;
		end else begin
			nz_reg = 1;
			oc_reg = 1;
		end
		if({ALUControl2,ALUControl1,ALUControl0} == 3'b000) begin
			opr_1 = input1;
			opr_2 = input2;
			result = input1 + input2;
		end else if({ALUControl2,ALUControl1,ALUControl0}== 3'b001) begin
			opr_1 = input1;
			opr_2 = ~input2 + 1'b1; 
			result = input1 + ~input2 + 1'b1;
		end else if({ALUControl2,ALUControl1,ALUControl0} == 3'b010) begin
			opr_1 = input1;
			opr_2 = input2;
			result = input1 & input2;
		end else if({ALUControl2,ALUControl1,ALUControl0} == 3'b011) begin
			result = input1 | input2;
		end else if({ALUControl2,ALUControl1,ALUControl0} == 3'b100) begin
			result = input1 ^ input2;
		end else if({ALUControl2,ALUControl1,ALUControl0} == 3'b101) begin
			result = 8'd0;
		end
//		end else if({ALUControl2,ALUControl1,ALUControl0} == 3'b110) begin
//			result = input1 ^ input2;
//		end else if({ALUControl2,ALUControl1,ALUControl0} == 3'b111) begin
//			result = ~(input1 ^ input2);
//		end
	
		if(nz_reg == 1) begin
			if(result[W-1] == 1) begin
				Negative = 1;
			end else begin
				Negative = 0;
			end
			
			if(result[W-1:0] == 0) begin
				Zero = 1;
			end else begin
				Zero = 0;
			end
		end
		
		if(oc_reg == 1) begin
			CarryOut	= result[W];
			overflow = ((opr_1[W-1] == 0 & opr_2[W-1] == 0 & result[W-1] == 1) | (opr_1[W-1] == 1 & opr_2[W-1] == 1 & result[W-1] == 0)) ? 1 : 0; //result[W] ^ result[W-1];
		end else begin
			CarryOut= 0;
			overflow = 0;
		end
	
		out = result[W-1:0];
	end

endmodule
