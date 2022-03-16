module Mul(   
  input [31:0] in1,in2,
  output reg [31:0] result
);
  wire [31:0] ten,tmp1,tmp2,tmp3,tmp4;
  
  assign ten = 32'b01000001001000000000000000000000;
  
  Multiplication m0(.a_operand(in1),.b_operand(in2),.Exception(),.Overflow(),.Underflow(),.result(tmp1));
  
  //Division d0(.a_operand(in1),.b_operand(ten),.Exception(),.result(tmp2));
  //Multiplication m1(.a_operand(tmp2),.b_operand(in2),.Exception(),.Overflow(),.Underflow(),.result(tmp3));
  //Multiplication m2(.a_operand(tmp3),.b_operand(ten),.Exception(),.Overflow(),.Underflow(),.result(tmp4));
  
  always@(*)begin
    if (in1==32'b00111111100000000000000000000000) 
      result = in2;
    else 
    if (in2==32'b00111111100000000000000000000000) 
      result = in1;
    else 
    if (in1==32'b10111111100000000000000000000000)
      result = {1'b1,in2[30:0]};
    else
    if (in2==32'b10111111100000000000000000000000)
      result = {1'b1,in1[30:0]};
    else
    if (in1==32'b0) 
      result = 32'b0;
    else
    if (in2==32'b0)
      result = 32'b0;
    //if (in1==in2)
      //result = tmp4;
    else
      result = tmp1;  
  end  
endmodule 



