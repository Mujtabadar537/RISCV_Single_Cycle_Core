module ALU(

input [31:0]operand1_i,
input [31:0]operand2_i,
input [3:0]ALU_Control_i,

output logic [31:0] ALUResult_o,
output logic zero_o

);


always_comb begin

zero_o = 0;

case(ALU_Control_i)

	4'b0000:
		ALUResult_o = operand1_i & operand2_i;
	4'b0001:
		ALUResult_o = operand1_i | operand2_i;
	4'b0010:
		ALUResult_o = operand1_i + operand2_i;
	4'b0110:
		ALUResult_o = operand1_i - operand2_i;
	4'b0011:
		ALUResult_o = operand1_i ^ operand2_i;
	4'b0100:
		ALUResult_o = operand1_i << operand2_i;
	4'b0101:
		ALUResult_o = operand1_i >> operand2_i;
	default:
		ALUResult_o = 32'h00000000;
endcase


//condition for zero flag
if(ALUResult_o == 32'h00000000) zero_o = 1;




end



endmodule
