#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include <VRISCV_Top_Single_Cycle.h>


int main(int argc , char** argv)
{
	Verilated::commandArgs(argc,argv);
	VRISCV_Top_Single_Cycle* top = new VRISCV_Top_Single_Cycle;
	
	top -> reset_i = 0;
	top -> clk_i = 0;
	top -> eval();
	
	Verilated::traceEverOn(true);
	VerilatedVcdC* wave = new VerilatedVcdC;
	top -> trace(wave,100);
	wave -> open("waveform.vcd");
	
	
	
	for(int i=0; i<500; i++)
	{
		if(i < 10)
		{
			top -> reset_i = 1;
		}
		
		else 
		{
			top -> reset_i = 0;
		}
	
	
	
		top -> eval();
		wave -> dump(i);
		top -> clk_i = !top -> clk_i;
				
	}
	
	
	
	wave->close();
    	delete top;
    	delete wave;	
	
	
	
	
	return 0;
}
