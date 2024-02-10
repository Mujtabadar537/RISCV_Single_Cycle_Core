`include "Program_Counter.sv"
`include "Instruction_Memory.sv"
`include "Add.sv"
`include "mux.sv"
`include "ALU.sv"
`include "Data_Memory.sv"
`include "AND_Gate.sv"
`include "Control_Unit.sv"
`include "ALU_Control.sv"
`include "Register_File.sv"



module RISCV_Top_Single_Cycle(

input clk_i,
input reset_i

);


wire [31:0]pcnext_wire;
wire [31:0]pc_wire;
wire [31:0]ADD4_wire;
wire [31:0]ADD_wire;
wire [31:0]instruction_wire;
wire [31:0]writedata_wire;
wire [31:0]immout_wire;
wire Branch_wire;
wire Zero_wire;
wire PCSrc_wire;
wire MemtoReg_wire;
wire MemRead_wire;
wire MemWrite_wire;
wire [31:0]Read_data1_wire;
wire [31:0]Read_data2_wire;
wire ALUSrc_wire;
wire RegWrite_wire;
wire [31:0]ALU_input2_wire;
wire [31:0]ALUResult_wire;
wire [3:0]ALUControl_wire;
wire [1:0]ALUOp_wire;
wire [31:0]Read_data_wire;


//Module Instantiation
Program_Counter PC(

.clk_i(clk_i),
.reset_i(reset_i),
.pcnext_i(pcnext_wire),

.pc_o(pc_wire)

);

//----------------------------------------------------------



Instruction_Memory IM(


.reset_i(reset_i), 
.Read_Address_i(pc_wire),

.instruction_o(instruction_wire)



);


//----------------------------------------------------------


Add ADD4(

.in1_i(pc_wire),
.in2_i(32'h4),

.sum_o(ADD4_wire)

);


//----------------------------------------------------------


Add Branch_Target(

.in1_i(pc_wire),
.in2_i(immout_wire),

.sum_o(ADD_wire)


);



//----------------------------------------------------------


mux branch_mux(

.in1_i(ADD4_wire),
.in2_i(ADD_wire),
.sel_i(PCSrc_wire),

.out_o(pcnext_wire)

);



//----------------------------------------------------------


AND_Gate AND(

.in1_i(Branch_wire),
.in2_i(Zero_wire),

.out_o(PCSrc_wire)

);



//----------------------------------------------------------



Control_Unit CU(


.opcode_i(instruction_wire[6:0]),


.MemtoReg_o(MemtoReg_wire),
.MemWrite_o(MemWrite_wire),
.MemRead_o(MemRead_wire),
.ALUSrc_o(ALUSrc_wire),
.RegWrite_o(RegWrite_wire),
.ALUOp_o(ALUOp_wire),
.Branch_o(Branch_wire)

);




//----------------------------------------------------------


ALU_Control ALU_C(

.funct3_i(instruction_wire[14:12]),
.funct7_bit5_i(instruction_wire[30]),
.ALUOp_i(ALUOp_wire),


.control_line_o(ALUControl_wire)

);




//----------------------------------------------------------



Register_File RF(

.clk_i(clk_i),
.reset_i(reset_i),
.Read_Register1_i(instruction_wire[19:15]),
.Read_Register2_i(instruction_wire[24:20]),
.Write_Register_i(instruction_wire[11:7]),
.Write_data_i(writedata_wire),
.RegWrite_i(RegWrite_wire),


.Read_data1_o(Read_data1_wire),
.Read_data2_o(Read_data2_wire)


);




//----------------------------------------------------------


Imm_Gen immediate_generator(

.instruction_i(instruction_wire),

.Immediate_o(immout_wire)

);



//----------------------------------------------------------


mux mux_ALU(

.in1_i(Read_data2_wire),
.in2_i(immout_wire),
.sel_i(ALUSrc_wire),

.out_o(ALU_input2_wire)

);




//----------------------------------------------------------



ALU arithmetic_logic_unit(

.operand1_i(Read_data1_wire),
.operand2_i(ALU_input2_wire),
.ALU_Control_i(ALUControl_wire),

.ALUResult_o(ALUResult_wire),
.zero_o(Zero_wire)


);



//----------------------------------------------------------


Data_Memory DM(

.clk_i(clk_i),
.reset_i(reset_i),
.MemWrite_i(MemWrite_wire),
.MemRead_i(MemRead_wire),
.Address_i(ALUResult_wire),
.Write_data_i(Read_data2_wire),

.Read_data_o(Read_data_wire)


);



//----------------------------------------------------------


mux mux_WriteBack(

.in1_i(ALUResult_wire),
.in2_i(Read_data_wire),
.sel_i(MemtoReg_wire),

.out_o(writedata_wire)

);


endmodule
