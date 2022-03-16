module control_import(
	input clk, start,
	output enAB,done,
	output [3:0] addrAB
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
	
	
	assign addrAB = OK ? state[3:0] : 4'hz; 
	assign done = (state==5'b11111) ? 1'b1 : 1'b0; 
	assign enAB = OK ? 1'b1 : 1'b0;

endmodule 
	
	