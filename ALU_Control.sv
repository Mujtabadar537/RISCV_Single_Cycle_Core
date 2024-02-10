module ALU_Control(


//inputs
input [2:0]funct3_i,
input funct7_bit5_i,
input [1:0]ALUOp_i,


//outputs
output logic [3:0]control_line_o


);



always_comb begin

if(ALUOp_i == 2'b00) begin
	control_line_o = 4'b0010;//ADD operation (Loads and Stores)
end


else if(ALUOp_i == 2'b01) begin

	control_line_o = 4'b0110;//SUB operation

end


else if(ALUOp_i == 2'b10) begin

	if({funct7_bit5_i,funct3_i} == 4'b0000) begin
		control_line_o = 4'b0010;//ADD operation (R-type)
	end

	else if({funct7_bit5_i,funct3_i} == 4'b1000) begin
		control_line_o = 4'b0110;//SUB operation (R-type)
	end

	else if({funct7_bit5_i,funct3_i} == 4'b0111) begin
		control_line_o = 4'b0000;//AND operation
	end

	else if({funct7_bit5_i,funct3_i} == 4'b0110) begin
		control_line_o = 4'b0001;//OR operation
	end
		
	else if({funct7_bit5_i,funct3_i} == 4'b0100) begin
		control_line_o = 4'b0011;//XOR operation
	end

end
	



end














endmodule
