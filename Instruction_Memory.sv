module Instruction_Memory(

/* verilator lint_off UNUSED */

input reset_i , [31:0]Read_Address_i,

output [31:0]instruction_o

);


logic [31:0] memory [1023:0];

/* verilator lint_off WIDTH */

assign instruction_o = (reset_i == 1'b1) ? 32'h00000000 : memory[Read_Address_i[31:2]];

/* verilator lint_on WIDTH */


initial begin

$readmemh("instructions.hex",memory);

end


/* verilator lint_on UNUSED */


endmodule
