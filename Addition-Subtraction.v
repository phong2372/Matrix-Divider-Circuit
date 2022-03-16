module Addition_Subtraction(
	input [31:0] a_operand,b_operand, 
	input AddBar_Sub,				  
	output Exception,
	output [31:0] result              
);
	wire operation_sub_addBar;
	wire Comp_enable;
	wire output_sign;
	wire [31:0] operand_a,operand_b;
	wire [23:0] significand_a,significand_b;
	wire [7:0] exponent_diff;
	wire [23:0] significand_b_add_sub;
	wire [7:0] exponent_b_add_sub;
	wire [24:0] significand_add;
	wire [30:0] add_sum;
	wire [23:0] significand_sub_complement;
	wire [24:0] significand_sub;
	wire [30:0] sub_diff;
	wire [24:0] subtraction_diff; 
	wire [7:0] exponent_sub;
	assign {Comp_enable,operand_a,operand_b} = (a_operand[30:0] < b_operand[30:0]) ? {1'b1,b_operand,a_operand} : {1'b0,a_operand,b_operand};
	assign exp_a = operand_a[30:23];
	assign exp_b = operand_b[30:23];
	assign Exception = (&operand_a[30:23]) | (&operand_b[30:23]);
	assign output_sign = AddBar_Sub ? Comp_enable ? !operand_a[31] : operand_a[31] : operand_a[31] ;
	assign operation_sub_addBar = AddBar_Sub ? operand_a[31] ^ operand_b[31] : ~(operand_a[31] ^ operand_b[31]);
	assign significand_a = (|operand_a[30:23]) ? {1'b1,operand_a[22:0]} : {1'b0,operand_a[22:0]};
	assign significand_b = (|operand_b[30:23]) ? {1'b1,operand_b[22:0]} : {1'b0,operand_b[22:0]};
	assign exponent_diff = operand_a[30:23] - operand_b[30:23];
	assign significand_b_add_sub = significand_b >> exponent_diff;
	assign exponent_b_add_sub = operand_b[30:23] + exponent_diff; 
	assign perform = (operand_a[30:23] == exponent_b_add_sub);
	//------------------------------------------------ADD BLOCK------------------------------------------//
	assign significand_add = (perform & operation_sub_addBar) ? (significand_a + significand_b_add_sub) : 25'd0; 
	assign add_sum[22:0] = significand_add[24] ? significand_add[23:1] : significand_add[22:0];
	assign add_sum[30:23] = significand_add[24] ? (1'b1 + operand_a[30:23]) : operand_a[30:23];
	//------------------------------------------------SUB BLOCK------------------------------------------//
	assign significand_sub_complement = (perform & !operation_sub_addBar) ? ~(significand_b_add_sub) + 24'd1 : 24'd0 ; 
	assign significand_sub = perform ? (significand_a + significand_sub_complement) : 25'd0;
	priority_encoder pe(significand_sub,operand_a[30:23],subtraction_diff,exponent_sub);
	assign sub_diff[30:23] = exponent_sub;
	assign sub_diff[22:0] = subtraction_diff[22:0];
	//-------------------------------------------------OUTPUT--------------------------------------------//
	assign result = Exception ? 32'b0 : ((!operation_sub_addBar) ? {output_sign,sub_diff} : {output_sign,add_sum});
endmodule