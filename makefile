#-----------Makefile for Verilator-----------#

source := RISCV_Top_Single_Cycle.sv
testbench := testbench_RISCV.cpp
top := RISCV_Top_Single_Cycle
opts := --trace


all:
	echo "Verilator simulation"
verilate:
	verilator --cc $(source)
	verilator -Wall $(opts) -cc $(source) --exe $(testbench)
	make -C obj_dir -f V$(top).mk V$(top)

wave:
	./obj_dir/V$(top)
	gtkwave waveform.vcd
clean:
	rm -fr obj_dir waveform.vcd
