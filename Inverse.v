module Inverse(
	input sign,
	input [31:0] dij,det, 
	output [31:0] result
);
	wire tmpsign;
	wire [31:0] tmpdet,tmp1,one;
	
	assign one = 32'h3f800000;
	assign tmpsign = det[31] ^ sign; 
	assign tmpdet  = {tmpsign,det[30:0]} ; 
	
	Division d0(.a_operand(one),.b_operand(tmpdet),.Exception(),.result(tmp1));
	Mul m1(dij,tmp1,result);
	
endmodule 
