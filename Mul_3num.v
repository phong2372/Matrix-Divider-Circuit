module Mul_3num(
	input [31:0] in1,in2,in3,
	output [31:0] result
);
	wire [31:0] tmp1;
	Mul m0 (in1,in2,tmp1);
	Mul m1 (in3,tmp1,result);
endmodule 
