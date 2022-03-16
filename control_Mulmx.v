module control_Mulmx(
	input clk, start,
	output enMulmx,doneMulmx,
	output [3:0] addrMxR,
	output reg [3:0] ra1MxA,ra2MxA,ra3MxA,ra4MxA,
	output reg [3:0] ra1MxBinv,ra2MxBinv,ra3MxBinv,ra4MxBinv
);

	reg OK ;
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
5'b10000:{ra1MxA,ra2MxA,ra3MxA,ra4MxA,ra1MxBinv,ra2MxBinv,ra3MxBinv,ra4MxBinv}={4'd0 ,4'd1 ,4'd2 ,4'd3 ,4'd0,4'd4,4'd8 ,4'd12}; 
5'b10001:{ra1MxA,ra2MxA,ra3MxA,ra4MxA,ra1MxBinv,ra2MxBinv,ra3MxBinv,ra4MxBinv}={4'd0 ,4'd1 ,4'd2 ,4'd3 ,4'd1,4'd5,4'd9 ,4'd13}; 
5'b10010:{ra1MxA,ra2MxA,ra3MxA,ra4MxA,ra1MxBinv,ra2MxBinv,ra3MxBinv,ra4MxBinv}={4'd0 ,4'd1 ,4'd2 ,4'd3 ,4'd2,4'd6,4'd10,4'd14}; 
5'b10011:{ra1MxA,ra2MxA,ra3MxA,ra4MxA,ra1MxBinv,ra2MxBinv,ra3MxBinv,ra4MxBinv}={4'd0 ,4'd1 ,4'd2 ,4'd3 ,4'd3,4'd7,4'd11,4'd15};  
5'b10100:{ra1MxA,ra2MxA,ra3MxA,ra4MxA,ra1MxBinv,ra2MxBinv,ra3MxBinv,ra4MxBinv}={4'd4 ,4'd5 ,4'd6 ,4'd7 ,4'd0,4'd4,4'd8 ,4'd12}; 
5'b10101:{ra1MxA,ra2MxA,ra3MxA,ra4MxA,ra1MxBinv,ra2MxBinv,ra3MxBinv,ra4MxBinv}={4'd4 ,4'd5 ,4'd6 ,4'd7 ,4'd1,4'd5,4'd9 ,4'd13};  
5'b10110:{ra1MxA,ra2MxA,ra3MxA,ra4MxA,ra1MxBinv,ra2MxBinv,ra3MxBinv,ra4MxBinv}={4'd4 ,4'd5 ,4'd6 ,4'd7 ,4'd2,4'd6,4'd10,4'd14};  
5'b10111:{ra1MxA,ra2MxA,ra3MxA,ra4MxA,ra1MxBinv,ra2MxBinv,ra3MxBinv,ra4MxBinv}={4'd4 ,4'd5 ,4'd6 ,4'd7 ,4'd3,4'd7,4'd11,4'd15};  
5'b11000:{ra1MxA,ra2MxA,ra3MxA,ra4MxA,ra1MxBinv,ra2MxBinv,ra3MxBinv,ra4MxBinv}={4'd8 ,4'd9 ,4'd10,4'd11,4'd0,4'd4,4'd8 ,4'd12};  
5'b11001:{ra1MxA,ra2MxA,ra3MxA,ra4MxA,ra1MxBinv,ra2MxBinv,ra3MxBinv,ra4MxBinv}={4'd8 ,4'd9 ,4'd10,4'd11,4'd1,4'd5,4'd9 ,4'd13}; 
5'b11010:{ra1MxA,ra2MxA,ra3MxA,ra4MxA,ra1MxBinv,ra2MxBinv,ra3MxBinv,ra4MxBinv}={4'd8 ,4'd9 ,4'd10,4'd11,4'd2,4'd6,4'd10,4'd14};
5'b11011:{ra1MxA,ra2MxA,ra3MxA,ra4MxA,ra1MxBinv,ra2MxBinv,ra3MxBinv,ra4MxBinv}={4'd8 ,4'd9 ,4'd10,4'd11,4'd3,4'd7,4'd11,4'd15}; 
5'b11100:{ra1MxA,ra2MxA,ra3MxA,ra4MxA,ra1MxBinv,ra2MxBinv,ra3MxBinv,ra4MxBinv}={4'd12,4'd13,4'd14,4'd15,4'd0,4'd4,4'd8 ,4'd12}; 
5'b11101:{ra1MxA,ra2MxA,ra3MxA,ra4MxA,ra1MxBinv,ra2MxBinv,ra3MxBinv,ra4MxBinv}={4'd12,4'd13,4'd14,4'd15,4'd1,4'd5,4'd9 ,4'd13}; 
5'b11110:{ra1MxA,ra2MxA,ra3MxA,ra4MxA,ra1MxBinv,ra2MxBinv,ra3MxBinv,ra4MxBinv}={4'd12,4'd13,4'd14,4'd15,4'd2,4'd6,4'd10,4'd14}; 
5'b11111:{ra1MxA,ra2MxA,ra3MxA,ra4MxA,ra1MxBinv,ra2MxBinv,ra3MxBinv,ra4MxBinv}={4'd12,4'd13,4'd14,4'd15,4'd3,4'd7,4'd11,4'd15}; 
	default: {ra1MxA,ra2MxA,ra3MxA,ra4MxA,ra1MxBinv,ra2MxBinv,ra3MxBinv,ra4MxBinv} = 32'hz;
endcase 
end
		
	assign doneMulmx = (state==5'b11111) ? 1'b1 : 1'b0; 
	assign enMulmx = OK ? 1'b1 : 1'b0;
	assign addrMxR = OK ? state[3:0] : 4'hz; 
	
endmodule 