module Mulmatrix_44(
	input [31:0] a1,a2,a3,a4,
	input [31:0] b1,b2,b3,b4,
	output[31:0] result
);
	wire [31:0] tmp1,tmp2,tmp3,tmp4;
	
	Mul m1(a1,b1,tmp1);
	Mul m2(a2,b2,tmp2);
	Mul m3(a3,b3,tmp3);
	Mul m4(a4,b4,tmp4);
	
	Add_4num a(tmp1,tmp2,tmp3,tmp4,result);
endmodule 