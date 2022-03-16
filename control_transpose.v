module control_transpose(
	input clk, start,
	output done,en,
	output reg [3:0] addrtmpMxB,addrMxC
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
			OK <= 0; 
		end 
	end 
	always@(state)begin
		case(state)
			5'b10000: {addrtmpMxB,addrMxC} = 8'b0000_0000;
			5'b10001: {addrtmpMxB,addrMxC} = 8'b0001_0100;
			5'b10010: {addrtmpMxB,addrMxC} = 8'b0010_1000;
			5'b10011: {addrtmpMxB,addrMxC} = 8'b0011_1100;
			5'b10100: {addrtmpMxB,addrMxC} = 8'b0100_0001;
			5'b10101: {addrtmpMxB,addrMxC} = 8'b0101_0101;
			5'b10110: {addrtmpMxB,addrMxC} = 8'b0110_1001;
			5'b10111: {addrtmpMxB,addrMxC} = 8'b0111_1101;
			5'b11000: {addrtmpMxB,addrMxC} = 8'b1000_0010;
			5'b11001: {addrtmpMxB,addrMxC} = 8'b1001_0110;
			5'b11010: {addrtmpMxB,addrMxC} = 8'b1010_1010;
			5'b11011: {addrtmpMxB,addrMxC} = 8'b1011_1110;
			5'b11100: {addrtmpMxB,addrMxC} = 8'b1100_0011;
			5'b11101: {addrtmpMxB,addrMxC} = 8'b1101_0111;
			5'b11110: {addrtmpMxB,addrMxC} = 8'b1110_1011;
			5'b11111: {addrtmpMxB,addrMxC} = 8'b1111_1111;
			default:  {addrtmpMxB,addrMxC} = 8'hz;
		endcase 
	end
	
	assign done = (state==5'b11111) ? 1'b1 : 1'b0; 
	assign en = OK ? 1'b1 : 1'b0;
	
endmodule 