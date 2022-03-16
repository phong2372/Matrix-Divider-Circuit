module detMatrix_33(
	input [31:0] in1,in2,in3,in4,in5,in6,in7,in8,in9,
	output[31:0] o_result
);
	wire [31:0] tmp1,tmp2,tmp3,tmp4,tmp5,tmp6,tmp7,tmp8;
	
	Mul_3num m1(.in1(in1),.in2(in5),.in3(in9),.result(tmp1));
	Mul_3num m2(.in1(in2),.in2(in6),.in3(in7),.result(tmp2));
	Mul_3num m3(.in1(in3),.in2(in4),.in3(in8),.result(tmp3));
	
	Mul_3num m4(.in1(in7),.in2(in5),.in3(in3),.result(tmp4));
	Mul_3num m5(.in1(in8),.in2(in6),.in3(in1),.result(tmp5));
	Mul_3num m6(.in1(in9),.in2(in4),.in3(in2),.result(tmp6));
	
	Add_3num add1(.in1(tmp1),.in2(tmp2),.in3(tmp3),.result(tmp7));
	Add_3num add2(.in1(tmp4),.in2(tmp5),.in3(tmp6),.result(tmp8));
	
	Addition_Subtraction sub(.a_operand(tmp7),.b_operand(tmp8),.AddBar_Sub(1),.Exception(),.result(o_result));
endmodule 