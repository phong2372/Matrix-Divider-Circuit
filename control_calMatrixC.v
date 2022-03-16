module control_calMatrixC(
	input clk, start,
	output encalMxC,donecalMxC,
	output reg [3:0] addrMxC,
	output reg [3:0] rd1MxB,rd2MxB,rd3MxB,rd4MxB,rd5MxB,rd6MxB,rd7MxB,rd8MxB,rd9MxB
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
		5'b10000: {addrMxC,rd1MxB,rd2MxB,rd3MxB,rd4MxB,rd5MxB,rd6MxB,rd7MxB,rd8MxB,rd9MxB} = {4'd0 , 4'd5, 4'd6, 4'd7, 4'd9,	4'd10, 4'd11, 4'd13,	4'd14, 4'd15};
 		5'b10001: {addrMxC,rd1MxB,rd2MxB,rd3MxB,rd4MxB,rd5MxB,rd6MxB,rd7MxB,rd8MxB,rd9MxB} = {4'd1 , 4'd4, 4'd6,	4'd7,	4'd8,	4'd10, 4'd11, 4'd12,	4'd14, 4'd15}; 
		5'b10010: {addrMxC,rd1MxB,rd2MxB,rd3MxB,rd4MxB,rd5MxB,rd6MxB,rd7MxB,rd8MxB,rd9MxB} = {4'd2 , 4'd4, 4'd5,	4'd7,	4'd8,	4'd9 , 4'd11, 4'd12,	4'd13, 4'd15};
		5'b10011: {addrMxC,rd1MxB,rd2MxB,rd3MxB,rd4MxB,rd5MxB,rd6MxB,rd7MxB,rd8MxB,rd9MxB} = {4'd3 , 4'd4, 4'd5,	4'd6,	4'd8,	4'd9 , 4'd10, 4'd12,	4'd13, 4'd14};
		5'b10100: {addrMxC,rd1MxB,rd2MxB,rd3MxB,rd4MxB,rd5MxB,rd6MxB,rd7MxB,rd8MxB,rd9MxB} = {4'd4 , 4'd1, 4'd2,	4'd3,	4'd9,	4'd10, 4'd11, 4'd13,	4'd14, 4'd15};
		5'b10101: {addrMxC,rd1MxB,rd2MxB,rd3MxB,rd4MxB,rd5MxB,rd6MxB,rd7MxB,rd8MxB,rd9MxB} = {4'd5 , 4'd0, 4'd2,	4'd3,	4'd8,	4'd10, 4'd11, 4'd12,	4'd14, 4'd15};
		5'b10110: {addrMxC,rd1MxB,rd2MxB,rd3MxB,rd4MxB,rd5MxB,rd6MxB,rd7MxB,rd8MxB,rd9MxB} = {4'd6 , 4'd0, 4'd1,	4'd3,	4'd8,	4'd9 , 4'd11, 4'd12,	4'd13, 4'd15};
		5'b10111: {addrMxC,rd1MxB,rd2MxB,rd3MxB,rd4MxB,rd5MxB,rd6MxB,rd7MxB,rd8MxB,rd9MxB} = {4'd7 , 4'd0, 4'd1,	4'd2,	4'd8,	4'd9 , 4'd10, 4'd12,	4'd13, 4'd14};
		5'b11000: {addrMxC,rd1MxB,rd2MxB,rd3MxB,rd4MxB,rd5MxB,rd6MxB,rd7MxB,rd8MxB,rd9MxB} = {4'd8 , 4'd1, 4'd2,	4'd3,	4'd5,	4'd6 , 4'd7	, 4'd13,	4'd14, 4'd15};
		5'b11001: {addrMxC,rd1MxB,rd2MxB,rd3MxB,rd4MxB,rd5MxB,rd6MxB,rd7MxB,rd8MxB,rd9MxB} = {4'd9 , 4'd0, 4'd2,	4'd3,	4'd4,	4'd6 , 4'd7	, 4'd12,	4'd14, 4'd15};
		5'b11010: {addrMxC,rd1MxB,rd2MxB,rd3MxB,rd4MxB,rd5MxB,rd6MxB,rd7MxB,rd8MxB,rd9MxB} = {4'd10, 4'd0, 4'd1,	4'd3,	4'd4,	4'd5 , 4'd7	, 4'd12,	4'd13, 4'd15};
		5'b11011: {addrMxC,rd1MxB,rd2MxB,rd3MxB,rd4MxB,rd5MxB,rd6MxB,rd7MxB,rd8MxB,rd9MxB} = {4'd11, 4'd0, 4'd1,	4'd2,	4'd4,	4'd5 , 4'd6	, 4'd12,	4'd13, 4'd14};
		5'b11100: {addrMxC,rd1MxB,rd2MxB,rd3MxB,rd4MxB,rd5MxB,rd6MxB,rd7MxB,rd8MxB,rd9MxB} = {4'd12, 4'd1, 4'd2,	4'd3,	4'd5,	4'd6 , 4'd7	, 4'd9 ,	4'd10, 4'd11};
		5'b11101: {addrMxC,rd1MxB,rd2MxB,rd3MxB,rd4MxB,rd5MxB,rd6MxB,rd7MxB,rd8MxB,rd9MxB} = {4'd13, 4'd0, 4'd2,	4'd3,	4'd4,	4'd6 , 4'd7	, 4'd8 ,	4'd10, 4'd11};
		5'b11110: {addrMxC,rd1MxB,rd2MxB,rd3MxB,rd4MxB,rd5MxB,rd6MxB,rd7MxB,rd8MxB,rd9MxB} = {4'd14, 4'd0, 4'd1,	4'd3,	4'd4,	4'd5 , 4'd7	, 4'd8 ,	4'd9 , 4'd11};
		5'b11111: {addrMxC,rd1MxB,rd2MxB,rd3MxB,rd4MxB,rd5MxB,rd6MxB,rd7MxB,rd8MxB,rd9MxB} = {4'd15, 4'd0, 4'd1,	4'd2,	4'd4,	4'd5 , 4'd6	, 4'd8 ,	4'd9 , 4'd10};
		default: {addrMxC,rd1MxB,rd2MxB,rd3MxB,rd4MxB,rd5MxB,rd6MxB,rd7MxB,rd8MxB,rd9MxB} = 40'hz;  
		endcase 
	end
	
	assign donecalMxC = (state==5'b11111) ? 1'b1 : 1'b0; 
	assign encalMxC = OK ? 1'b1 : 1'b0;

endmodule 
	
	