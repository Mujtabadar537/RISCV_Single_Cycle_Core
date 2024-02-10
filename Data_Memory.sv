module Data_Memory(

/* verilator lint_off UNUSED */


//inputs
input clk_i,reset_i,
input MemWrite_i,
input MemRead_i,
input [31:0]Address_i,
input [31:0]Write_data_i,


//outputs
output [31:0]Read_data_o

);


logic [31:0] memory [1023:0];


//write operation
always_ff @(posedge clk_i) begin

memory[Address_i] <= Write_data_i;

end


//read operation
assign Read_data_o = (reset_i == 1'b1) ? 32'h00000000 : memory[Address_i];




/* verilator lint_on UNUSED */

endmodule
