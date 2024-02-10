module Control_Unit(

//input(opcode) 
input [6:0]opcode_i,


//outputs(control signals)
output MemtoReg_o,
output MemWrite_o,
output MemRead_o,
output ALUSrc_o,
output RegWrite_o,
output [1:0]ALUOp_o,
output Branch_o

);



//For R-type , I-type and Load instructions RegWrite should be high
//RegWrite = 1(Write)      RegWrite = 0(Read)
assign RegWrite_o = (opcode_i == 7'b0110011 | opcode_i == 7'b0000011 | opcode_i == 7'b0010011) ? 1'b1 :  1'b0;


//For Store instructions only MemWrite should be high
assign MemWrite_o = (opcode_i == 7'b0100011) ? 1'b1 : 1'b0;


//For Load instruction only MemRead should be high
assign MemRead_o = (opcode_i == 7'b0000011) ? 1'b1 : 1'b0;


//For I-type , Loads and Stores ALUSrc is high
assign ALUSrc_o = (opcode_i == 7'b0010011 | opcode_i == 7'b0000011 | opcode_i == 7'b0100011) ? 1'b1 : 1'b0;


/**Writing Back ALUresult(0)         Writing back contents of Data memory(1)**/      
assign MemtoReg_o = (opcode_i == 7'b0110011 | opcode_i == 7'b0010011 | opcode_i == 7'b1101111 | opcode_i == 7'b1100111) ? 1'b0:
		  (opcode_i == 7'b0000011) ? 1'b1 : 1'b0;
	   

//Only high for branch instructions
assign Branch_o = (opcode_i == 7'b1100011) ? 1'b1 : 1'b0;


/**00 = Loads and S-type               01 = B-type            10 = R-type and I-type **/
assign ALUOp_o = (opcode_i == 7'b0000011 | opcode_i == 7'b0100011) ? 2'b00:
	       (opcode_i == 7'b1100011) ? 2'b01:
	        2'b10;
 

endmodule
