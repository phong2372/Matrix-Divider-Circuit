 module Add_4num(
	input [31:0] in1,in2,in3,in4,
	output [31:0] result
);
	wire [31:0] tmp1,tmp2;
	
	Addition_Subtraction a1(.a_operand(in1),.b_operand(in2),.AddBar_Sub(0),.Exception(),.result(tmp1));
	Addition_Subtraction a2(.a_operand(in3),.b_operand(in4),.AddBar_Sub(0),.Exception(),.result(tmp2));
	Addition_Subtraction a3(.a_operand(tmp1),.b_operand(tmp2),.AddBar_Sub(0),.Exception(),.result(result));
 
endmodule 