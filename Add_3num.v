 module Add_3num(
	input [31:0] in1,in2,in3,
	output [31:0] result
);
	wire [31:0] tmp1,tmp2;
	Addition_Subtraction a1(.a_operand(in1),.b_operand(in2),.AddBar_Sub(0),.Exception(),.result(tmp1));
	Addition_Subtraction a2(.a_operand(in3),.b_operand(tmp1),.AddBar_Sub(0),.Exception(),.result(result));
 
endmodule 