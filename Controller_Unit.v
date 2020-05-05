//Mustafa Destegul
//2109973
//intro_2008@hotmail.com

module Controller_Unit(clk,
							  reset,
							  run,
							  op,
							  immediate,
							  cmd,
							  L_or_S,
							  ALUFlags,
							  Reset_PC,
							  Current_State,
							  Next_State,
							  IRWrite,
							  RegSrc,
							  RdSel,
							  RegWrite,
							  PCChoose,
							  PCWrite,
							  MemWrite,
							  WD3_Sel,
							  sh_type,
							  ALUControl,
							  ALUSrcA,
							  ALUSrcB,
							  ResultSrc,
							  AdrSrc,
							  PCChoose2
							  );

//inputs
input clk;
input [1:0] op;
input [2:0] cmd;
input L_or_S;
input reset;
input run;
input immediate;
input [3:0] ALUFlags;

//Outputs
output [2:0] Current_State;
output [2:0] Next_State;
output wire Reset_PC;  // if reset is pressed ,PC=0 , goes to the very first instruction 
output wire IRWrite;
output wire RegWrite;
output wire PCWrite;
output wire RdSel;
output wire RegSrc;
output wire PCChoose2;
output wire MemWrite;
output wire [2:0] sh_type;
output wire [2:0] ALUControl,WD3_Sel;
output wire [1:0] ResultSrc,AdrSrc;
output wire [1:0] PCChoose,ALUSrcA,ALUSrcB;
//Other variables

parameter IDLE		  =3'b000;
parameter FETCH     =3'b001;
parameter DECODE    =3'b010;
parameter EXECUTE_C1=3'b011;
parameter EXECUTE_C2=3'b100;
parameter EXECUTE_C3=3'b101;



reg [2:0] Current_State;
reg [2:0] Next_State;

assign Reset_PC = Current_State==IDLE ? 1
					 : 0;  
assign IRWrite  = Current_State==FETCH ? 1	
					 : 0; 
assign PCWrite  =((Current_State==FETCH) || (Current_State==DECODE && op==2'b10 && cmd==3'b000) || (Current_State==EXECUTE_C1 && op==2'b10 && ~(cmd==3'b000 || cmd==3'b010)) || (Current_State==EXECUTE_C2 && op==2'b10 && cmd==3'b010) || (Current_State==EXECUTE_C1 && op==2'b10 && cmd==3'b011) )  ? 1
					 : 0; 
assign RegWrite =(((Current_State==EXECUTE_C2 && op==2'b00 && ~(cmd==3'b001 || cmd==3'b011 || cmd==3'b111)) || ( Current_State==FETCH && op==2'b00 && (cmd==3'b001 ||cmd==3'b011)) || (Current_State==EXECUTE_C1 && op==2'b01) || ((Current_State==EXECUTE_C1) && op==2'b11 && cmd==3'b001) || ( Current_State==EXECUTE_C3 && op==2'b11 && cmd==3'b000) || (Current_State==EXECUTE_C1 && op==2'b10 && ~(cmd==3'b000))) && (~(op==2'b11 && cmd==3'b010)))  ? 1  // if STR don't write to register again.
					 : 0;
assign RdSel    =((Current_State==DECODE &&  op==2'b00 /*(For all cmd)*/) || (Current_State==EXECUTE_C1 && op==2'b01 ) || (Current_State==DECODE &&  op==2'b11 /*(For all cmd)*/) )  ? 0 
					 :( Current_State==EXECUTE_C1 &&  op==2'b10 && (cmd==3'b001 || cmd==3'b010)) ? 1 
					 : 0;
assign PCChoose = Current_State==FETCH ? 2'b01 
					 :((Current_State==DECODE && op==2'b10 && cmd==3'b000) || (Current_State==EXECUTE_C1 && op==2'b10 && ~(cmd==3'b000 || cmd==3'b010) ))  ? 2'b10 // for brach not for BIN, BX nad Bun 
					 :(Current_State==EXECUTE_C2 && op==2'b10 && cmd==3'b010) ? 2'b11
					 : 2'b00;
assign PCChoose2= Current_State<=EXECUTE_C1 && op==2'b10 && cmd==3'b011 ? 1
					 : 0;
assign AdrSrc   = Current_State==FETCH ? 2'b00
					 :(Current_State==EXECUTE_C2 && op==2'b11 && (cmd==3'b000 ||cmd==3'b010))  ? 2'b01
					 :(Current_State==EXECUTE_C2 && op==2'b00 && (cmd==3'b001 || cmd==3'b011) || (Current_State==EXECUTE_C1 && op==2'b10 &&  cmd==3'b010) ) ? 2'b10
					 : 2'b00; 
															
assign ResultSrc=((Current_State==EXECUTE_C2 && op==2'b00 && ~(cmd==3'b001 || cmd==3'b011 || cmd==3'b111)) || ( Current_State==EXECUTE_C3 && op==2'b00 && (cmd==3'b001 ||cmd==3'b011)) || ( Current_State==EXECUTE_C2 && op==2'b11 && (cmd==3'b000 ||cmd==3'b010))) ? 2'b00
					 : (Current_State==EXECUTE_C2 && op==2'b00 && cmd==3'b111) ? 2'b10   // for clear
					 :	(Current_State==EXECUTE_C1 && op==2'b01) ? 2'b11  
					 : 2'b00;

assign RegSrc   =((Current_State==DECODE && op==2'b00 && /* For all cmd*/ ~immediate) || (Current_State==DECODE && op==2'b00 && cmd==3'b001))  ? 0
					 :((Current_State==DECODE && op==2'b01 /* For all cmd*/)  || (Current_State==DECODE && op==2'b10 && (cmd==3'b010 || cmd==3'b011)))  ? 1 //  if branch indirect and BX exchange  
					 : 0;										  
assign ALUSrcA  =((Current_State==EXECUTE_C1 && op==2'b00 && ~(cmd==3'b001 || cmd==3'b011 || cmd==3'b111) ) || (Current_State==EXECUTE_C1 && op==2'b11 && (cmd==3'b000 || cmd==3'b010) ))? 2'b01 
					 :(Current_State==EXECUTE_C3 && op==2'b00 && (cmd==3'b001 || cmd== 3'b011)) ? 2'b10
					 : 2'b00;				 
					 
assign ALUSrcB	 =((Current_State==EXECUTE_C1 && op==2'b00 && ~(cmd==3'b001 || cmd==3'b011 || cmd==3'b111) && immediate ) || (Current_State==EXECUTE_C1 && op==2'b11 && (cmd==3'b000 || cmd==3'b010))) ? 2'b01 
					 :(Current_State==EXECUTE_C1 && op==2'b00 && ~(cmd==3'b001 || cmd==3'b011 || cmd==3'b111) && ~immediate) ? 2'b00
					 :(Current_State==EXECUTE_C3 && op==2'b00 && (cmd==3'b001 || cmd== 3'b011)) ? 2'b11 
					 : 2'b00;

assign ALUControl=((Current_State==EXECUTE_C1 && op==2'b00 && cmd==3'b000)|| (Current_State==EXECUTE_C3 && op==2'b00 && cmd==3'b001) || (Current_State==EXECUTE_C1 && op==2'b11 && (cmd==3'b000 || cmd==3'b010))) ? 3'b000
					 : ((Current_State==EXECUTE_C1 && op==2'b00 && cmd==3'b010)|| (Current_State==EXECUTE_C3 && op==2'b00 && cmd==3'b011)) ? 3'b001
					 :  (Current_State==EXECUTE_C1 && op==2'b00 && cmd==3'b100) ? 3'b010
					 :	 (Current_State==EXECUTE_C1 && op==2'b00 && cmd==3'b101)	? 3'b011
					 :  (Current_State==EXECUTE_C1 && op==2'b00 && cmd==3'b110) ? 3'b100 
					 : 3'b000;
					 /*:  (Current_State==EXECUTE_C1 && op==2'b00 && cmd==3'b111) ? 3'b101;*/ // No need since CLR operation is done by giving 0 to MUX not by ALU

assign WD3_Sel= ((Current_State==EXECUTE_C2 && op==2'b00 && ~(cmd==3'b001 || cmd==3'b011)) || ( Current_State==EXECUTE_C3 && op==2'b00 && (cmd==3'b001 ||cmd==3'b011)) || (Current_State==EXECUTE_C1 && op==2'b01 )) ? 3'b000 
					 :(Current_State==EXECUTE_C3 && op==2'b11 && cmd==3'b000) ? 3'b001
					 :(( Current_State==EXECUTE_C1) && op==2'b11 && cmd==3'b001) ? 3'b011
					 :(Current_State==DECODE && op==2'b10 && (cmd==3'b001 || cmd==3'b010)) ? 3'b010
					 : 3'b000;

assign sh_type = Current_State==EXECUTE_C1 && op==2'b01 && cmd==3'b000 ? 3'b000 
					 :Current_State==EXECUTE_C1 && op==2'b01 && cmd==3'b001 ? 3'b001
					 :Current_State==EXECUTE_C1 && op==2'b01 && cmd==3'b010 ? 3'b010
					 :Current_State==EXECUTE_C1 && op==2'b01 && cmd==3'b011 ? 3'b011
					 :Current_State==EXECUTE_C1 && op==2'b01 && cmd==3'b100 ? 3'b100
					 : 3'b000;
					 
assign MemWrite=(Current_State==EXECUTE_C2 && op==2'b11 && cmd==3'b010) ? 1
					 : 0;
//----------Seq Logic-----------------------------
always @(posedge clk)
 begin : FSM_SEQ
   if (reset == 1'b1) begin
    Current_State <=   IDLE;
   end 
	else begin
    Current_State <=   Next_State;
   end
 end


always@(Current_State)
begin
	case(Current_State)
			IDLE:
				begin	
					if(run==1'b1) 
						begin
							Next_State<=FETCH;
													   								
						end
					else	
						begin
							Next_State<=IDLE;
									
						end
				end
			FETCH:
				begin
					
					//	PCChoose<=2'b01;		// PC+2
						//PCWrite<=1;
						//AdrSrc<=2'b00;	
						Next_State<=DECODE;	   								
				end
				
			DECODE:
				begin
					if(op==2'b00)						// Data processing operations 
						begin
							if(cmd==3'b000)    		//ADD
								begin
//									if(immediate)			// THIS SHADED AREAS FOR YOU TO UNDERSTAND WHICH AND WHERE CONTROL SIGNALS ARE ASSERTED.
//									RdSel<=0;				
//									else begin	
//								//	RdSel<=0;
//									RegSrc<=0;							
//									end
									Next_State <=EXECUTE_C1;
								end
							else if(cmd==3'b001)  // ADDI			// same for all other operations, normally no need to specfiy the cmd command since in all operatiosn RdSel=0 and RegSrc=0 but anyway :)
								begin
								//	RdSel<=0;
								//	RegSrc<=0;	
									Next_State <=EXECUTE_C1;
								end
							else if (cmd==3'b010)  // SUB								
									Next_State <=EXECUTE_C1;								
							
							else if(cmd==3'b011)  // SUBI

									Next_State <=EXECUTE_C1;
					
							else if (cmd==3'b100)  // AND
								
									Next_State <=EXECUTE_C1;
								
							else if (cmd==3'b101)  // ORR
								
									Next_State <=EXECUTE_C1;
								
							else if (cmd==3'b110)  // XOR
								
									Next_State <=EXECUTE_C1;
								
							else if (cmd==3'b111)  // CLR
								
									Next_State <=EXECUTE_C1;							
									
						end	
					else if(op==2'b01)					// shift operations
						begin
							if(cmd==3'b000)    		//RTL 
								begin
//									RegSrc<=1;													
									Next_State <=EXECUTE_C1;
								end
							else if(cmd==3'b001)  // RTR		// same for all other operations, normally no need to specfiy the cmd command 
								begin
								//	RegSrc<=1;	
									Next_State <=EXECUTE_C1;
								end
							else if (cmd==3'b010)  // SHL
								//	RegSrc<=1;
									Next_State <=EXECUTE_C1;								
							
							else if(cmd==3'b011)  // ASHR    // arithmetic shift riight
								//	RegSrc<=1;
									Next_State <=EXECUTE_C1;
								
							else if (cmd==3'b100)  // LSHR	// Logical shift riight
								//	RegSrc<=1;
									Next_State <=EXECUTE_C1;					
						end
					
					if(op==2'b11)
						begin
							if(cmd==3'b000)			//LDR operation. Loads from data memory to register file specified by destination register
								begin
						//			RdSel<=0;
									Next_State<=EXECUTE_C1;
								end
							else if (cmd==3'b001)	// MOV operation. it will load an immediate value to the destination register. just 2 cycle.
								begin
								//	RdSel<=0;
								//	WD3_Sel<=3'b011;
								// RegWrite<=1;
									Next_State<=EXECUTE_C1;
								
								end
							else if(cmd==3'b010)		// STR operation. The data in the destination register will be loaded to the Data/Instruction memory.
								begin
							//		RdSel<=0;
							//		RegSrc<=1;
									Next_State<=EXECUTE_C1;							
								end
							else if({cmd,immediate}==4'b1111)	//END; termination of the software go to IDLE stage...
								begin
									Next_State<=IDLE;
								end
						end
						
					else if(op==2'b10)
						begin
							if(cmd==3'b000)				//BUN. Branch unconditional.
								begin
									//PCChoose<=2;  
									//PCWrite<=1;
									Next_State<=FETCH;								
								end
							else if(cmd==3'b001)			//BL.
								begin
									
									//RdSel<=1;
									//WD3_Sel<=2;  //  
									Next_State<=EXECUTE_C1;							
								end
							else if(cmd==3'b011)			//BX
								begin
									//RegSrc<=1;
									Next_State<=EXECUTE_C1;
								end
							else if(cmd==3'b010)			//BIN
								begin
									//RegSrc<=1;
									//WD3_Sel<=3'b011;
									//RdSel<=1
									Next_State<=EXECUTE_C1;			
								end
							else if(cmd==3'b100)			//BEQ
								begin
									if(ALUFlags[2]==1'b1)   // if zero flag is set, take the branch, else not.
										Next_State<=EXECUTE_C1;
									else 
										Next_State<=FETCH;
								end
							else if(cmd==3'b101)			//BNE
								begin
									if(ALUFlags[2]==1'b0)   // if zero flag is not set, take the branch, else not.
										Next_State<=EXECUTE_C1;
									else 
										Next_State<=FETCH;		
								end
							else if(cmd==3'b110)
								begin
									if(ALUFlags[1]==1'b1)   // if carry flag is  set, take the branch, else not.
										Next_State<=EXECUTE_C1;
									else 
										Next_State<=FETCH;		
								end
							else if(cmd==3'b111)
								begin
									if(ALUFlags[1]==1'b0)   // if carry flag is not set, take the branch, else not.
										Next_State<=EXECUTE_C1;
									else 
										Next_State<=FETCH;		
								end
						
						
						
						end
					
					
					
					
					
				end
			EXECUTE_C1:
				begin
					if(op==2'b00)
						begin
							if(cmd==3'b000)					//ADD
								begin
//									if(immediate)
//										begin
//										ALUSrcA<=2'b01;
//										ALUSrcB<=2'b01;
//										ALUControl<=3'b000;
//										end
//									else 
//										begin
//										ALUSrcA<=2'b01;
//										ALUSrcB<=2'b00;
//										ALUControl<=3'b000;
//									   end
									Next_State <=EXECUTE_C2;
								end
							else if (cmd==3'b001)				//ADDI				
								begin			
									Next_State <=EXECUTE_C2;								
								end
							else if (cmd==3'b010)				//SUB
								begin
//									if(immediate)
//										begin
//										ALUSrcA<=2'b01;										Except ADDI and SUBI, all other process are same
//										ALUSrcB<=2'b01;
//										ALUControl<=3'b000;									For generalization, except cmd=001(andl) and cmd =011(subI) and cmd=111(clear)
//										end																immediate: 
//									else 																			ALUSrcA=01
//										begin																		ALUSrcb=01	
//										ALUSrcA<=2'b01;														ALUControl= CHANGES 
//										ALUSrcB<=2'b00;												R-Type : 
//										ALUControl<=3'b000;													ALUSrcA=01
//									   end																		ALUSrcb=01	
									Next_State <=EXECUTE_C2;								//				ALUControl= CHANGES 
								end
							else if (cmd==3'b011)					//SUBI
								begin			
									Next_State <=EXECUTE_C2;								
								end
							//For all other operation the 
							else if (cmd==3'b100)				//AND
								begin
									Next_State <=EXECUTE_C2;
								end
							else if (cmd==3'b101)				//ORR
								begin
									Next_State <=EXECUTE_C2;
								end
							else if (cmd==3'b110)				//XOR
								begin
									Next_State <=EXECUTE_C2;
								end
							else if (cmd==3'b111)				//CLR
								begin
									Next_State <=EXECUTE_C2;
									
								end
								
						end
					else if(op==2'b01)
						begin
							if(cmd==3'b000)						// RTL
								begin
//									sh_type<=3'b000;						// this control signals are all same for the other instruction but only sh_type is changing
//									ResultSrc<=2'b11;
//									RdSel<=0;
//									WD3_Sel<=3'b000;
								Next_State<=FETCH;
								end
							else if (cmd==3'b001)				//RTR
								begin			
									Next_State <=FETCH;								
								end
							//For all other operation the 
							else if (cmd==3'b010)				//SHL
								begin
									Next_State <=FETCH;
								end
							else if (cmd==3'b011)				//ASHR
								begin
									Next_State <=FETCH;
								end
							else if (cmd==3'b100)				//LSHR
								begin
									Next_State <=FETCH;
								end					
						end
					else if (op==2'b11)
						begin
							if(cmd==3'b000)						//LDR
								begin
								//	ALUSrcA<=1;
								//	ALUSrcB<=1;
								// ALUControl<=3'b000;
									Next_State<=EXECUTE_C2;
								end
							else if(cmd==3'b010)					// STR
								begin
								// 
								//	ALUSrcA<=1;
								//	ALUSrcB<=1;
								// ALUControl<=3'b000;
									Next_State<=EXECUTE_C2;	
								end
							else if(cmd==3'b001)
								begin
									Next_State<=FETCH;
								end
						end
					else if(op==2'b10)
						begin	
							if(cmd==3'b001)			//BL.
								begin
								//PCChoose<=2;
								//PCWrite<=1;
								//RegWrite<=1;
								   Next_State<=FETCH;							
								end
							else if(cmd==3'b010)	  //BIL
								begin
								//adrSrc<=2;
								//RegWrite<=1;
									Next_State<=EXECUTE_C2;
								end
							else if(cmd==3'b011)	  //BX
								begin
								//PCChoose2<=1;
									Next_State<=FETCH;
								end
							else if(cmd==3'b100)		//BEQ
								begin
								//PCChoose<=2;
								//PCWrite<=1;
								//RegWrite<=1;
								   Next_State<=FETCH;	
								end
							else if(cmd==3'b101)		//BNE
								begin
								//PCChoose<=2;
								//PCWrite<=1;
								//RegWrite<=1;
								   Next_State<=FETCH;	
								end
							else if(cmd==3'b110)		//BCS
								begin
								//PCChoose<=2;
								//PCWrite<=1;
								//RegWrite<=1;
								   Next_State<=FETCH;	
								end
							else if(cmd==3'b111)		//bcc
								begin
								//PCChoose<=2;
								//PCWrite<=1;
								//RegWrite<=1;
								   Next_State<=FETCH;	
								end							
						end
				
				end
			EXECUTE_C2:
				begin
					if(op==2'b00)									// Data processing
						begin
							if(cmd==3'b000)
								begin									// since for both imm and Rm will be written in the same way to the register 
									//ResultSrc<=2'd0;
									//WD3_Sel  <=3'd0;
									Next_State <=FETCH; //  
								end
						
							else if(cmd==3'b001)					// ADD indirect															**	FOR cmd==111,ResultSrc==2 should be given to select the mux output as 0
								begin
									
									//AdrSrc<=2'b10;						// the address is chosen pointed by Rm reg.
									Next_State <=EXECUTE_C3;	
								end
							else if(cmd==3'b010)					//SUB
								begin
									//ResultSrc<=2'd0 yazılacak. 
									//WD3_Sel  <=3'd0;
									Next_State <=FETCH; //  
								end
							else if(cmd==3'b011)					// SUB indirect	
								begin	
									//AdrSrc<=2'b10;						// the address is chosen pointed by Rm reg.
									Next_State <=EXECUTE_C3;
								end
							else if(cmd==3'b100)					//AND
								
									Next_State <=FETCH; //  
							
							else if(cmd==3'b101)					//ORR
							
									Next_State <=FETCH; //  
							
							else if(cmd==3'b110)					//XOR
								
									Next_State <=FETCH; //  
													
							
							else if(cmd==3'b111)					//CLR
									//ResultSrc<=2'd2 yazılacak. 
									//WD3_Sel  <=3'd0;
									Next_State <=FETCH;
						end
					else if(op==2'b11)
						begin
							if(cmd==3'b000)						//LDR
								begin
									//ResultSrc<=0;
									//AdrSrc<=1;
									Next_State<=EXECUTE_C3;				
								end
							else if (cmd==3'b010)
								begin
									//ResultSrc<=0;
									//AdrSrc<=1;
									//MemWrite<=1
									Next_State<=FETCH;		
								end
						end
					else if(op==2'b10)
						begin
							if(cmd==3'b010)		//BIL
								begin
									//PCChoose<=3;
									//PCWrite<=1
									Next_State<=FETCH;
								end
						end
				end							
			EXECUTE_C3:							// Extra cycle for indirect operations ADDI and SUBI and LDR operation
				begin
					if(op==2'b00)
						begin
							if(cmd==3'b001)     			// ADD indirect. 1 cycle extra to take data from the memory
								begin
									//ALUSrcA<=2'b10;
									//ALUSrcB<=2'b11;
									//ALUControl<=3'b000;
									//ResultSrc<=2'b00;
									//WD3_Sel  <=3'b000;
									Next_State <=FETCH;											
								end
							else if(cmd==3'b011)			// SUB indirect
								begin
									//ALUSrcA<=2'b10;
									//ALUSrcB<=2'b11;
									//ALUControl<=3'b001;
									//ResultSrc<=2'b00;
									//WD3_Sel  <=3'b000;
									Next_State <=FETCH;	
		
								end
						 end	
	
					else if(op==2'b11)
						begin
							if(cmd==3'b000)
								begin
								//WD3_Sel<=1;
								//RegWrite<=1;
									Next_State<=FETCH;
								end
						
						end
				
				end
	
	
	
	endcase

end


endmodule
