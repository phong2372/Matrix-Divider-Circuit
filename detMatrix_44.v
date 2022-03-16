module detMatrix_44(
	input [31:0] a11,a12,a13,a14,
	input [31:0] d11,d12,d13,d14,
	output [31:0] result,
	output detZero
);
	wire [31:0] tmp1,tmp2,tmp3,tmp4,tmp5,tmp6; 
	
	Mul m1(a11,d11,tmp1);
	Mul m2(a12,d12,tmp2);
	
	Mul m3(a13,d13,tmp3);
	Mul m4(a14,d14,tmp4);
		
	Addition_Subtraction a1(.a_operand(tmp1),.b_operand(tmp3),.AddBar_Sub(0),.Exception(),.result(tmp5));
	Addition_Subtraction a2(.a_operand(tmp2),.b_operand(tmp4),.AddBar_Sub(0),.Exception(),.result(tmp6));
		
	Addition_Subtraction a3(.a_operand(tmp5),.b_operand(tmp6),.AddBar_Sub(1),.Exception(),.result(result));
	
	assign detZero = (result==32'd0) ? 1'b1 : 1'b0;
endmodule 