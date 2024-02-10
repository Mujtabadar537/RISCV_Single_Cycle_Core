module Program_Counter(

input clk_i,reset_i,
input [31:0]pcnext_i,

output logic [31:0]pc_o

);

always_ff @(posedge clk_i) begin

if(reset_i) begin
pc_o <= 32'h00000000;
end

else begin
pc_o <= pcnext_i;
end


end



endmodule
