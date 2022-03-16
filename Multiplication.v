module Multiplication(
		input [31:0] a_operand,
		input [31:0] b_operand,
		output Exception,Overflow,Underflow,
		output [31:0] result
);
	wire sign,product_round,normalised,zero;
	wire [8:0] exponent,sum_exponent;
	wire [22:0] product_mantissa;
	wire [23:0] operand_a,operand_b;
	wire [47:0] product,product_normalised; 
	assign sign = a_operand[31] ^ b_operand[31];	
	assign Exception = (&a_operand[30:23]) | (&b_operand[30:23]);
	assign operand_a = (|a_operand[30:23]) ? {1'b1,a_operand[22:0]} : {1'b0,a_operand[22:0]};
	assign operand_b = (|b_operand[30:23]) ? {1'b1,b_operand[22:0]} : {1'b0,b_operand[22:0]};
	assign product = operand_a * operand_b;			 
	assign product_round = |product_normalised[22:0];   
	assign normalised = product[47] ? 1'b1 : 1'b0;	
	assign product_normalised = normalised ? product : product << 1;	 
	assign product_mantissa = product_normalised[46:24] + {21'b0,(product_normalised[23] & product_round)};
	assign zero = Exception ? 1'b0 : (product_mantissa == 23'd0) ? 1'b1 : 1'b0;
	assign sum_exponent = a_operand[30:23] + b_operand[30:23];
	assign exponent = sum_exponent - 8'd127 + normalised;
	assign Overflow = ((exponent[8] & !exponent[7]) & !zero) ;  
	assign Underflow = ((exponent[8] & exponent[7]) & !zero) ? 1'b1 : 1'b0; 
	assign result = Exception ? 32'd0 : zero ? {sign,31'd0} : Overflow ? {sign,8'hFF,23'd0} : Underflow ? {sign,31'd0} : {sign,exponent[7:0],product_mantissa};
endmodule