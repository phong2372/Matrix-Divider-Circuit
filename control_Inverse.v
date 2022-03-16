module control_Inverse(
	input clk, start,
	output eninvMxB,doneinvMxB,reReg,
	output reg sign,
	output [3:0] addrMxBinv,addrtmpMxB
);
	reg OK;
	reg [4:0] state;
	 
	always @(posedge clk) begin
		if (start) begin
			OK <= 1'b1;
			state <= 5'b10000;
		 end
		else
			state <= 5'b00000;
		if (OK) begin 
			state <= state + 1;
		end 
		if (state==5'b11111) begin
			state <= 5'b00000;
			OK <= 1'b0; 
		end 
	end 
	
	always@(state)begin
		case(state)
			5'b10000: sign = 1'b0;
			5'b10001: sign = 1'b1;
			5'b10010: sign = 1'b0;
			5'b10011: sign = 1'b1;
			5'b10100: sign = 1'b1;
			5'b10101: sign = 1'b0;
			5'b10110: sign = 1'b1;
			5'b10111: sign = 1'b0;
			5'b11000: sign = 1'b0;
			5'b11001: sign = 1'b1;
			5'b11010: sign = 1'b0;
			5'b11011: sign = 1'b1;
			5'b11100: sign = 1'b1;
			5'b11101: sign = 1'b0;
			5'b11110: sign = 1'b1;
			5'b11111: sign = 1'b0;
			default:  sign = 1'hz;
		endcase 
	end
	
	assign doneinvMxB = (state==5'b11111) ? 1'b1 : 1'b0; 
	assign eninvMxB = OK ? 1'b1 : 1'b0;
	assign reReg = OK ? 1'b1 : 1'b0;
	assign addrMxBinv = OK ? state[3:0] : 4'hz; 
	assign addrtmpMxB = OK ? state[3:0] : 4'hz;
endmodule 
	
	