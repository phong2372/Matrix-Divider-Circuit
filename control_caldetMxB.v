module control_caldetMxB(
	input clk, start,
	output encaldetMxB,donecaldetMxB,
	output [3:0] ra1MxB,ra2MxB,ra3MxB,ra4MxB,ra1MxC,ra2MxC,ra3MxC,ra4MxC
);
	reg  state;
	
	always @(posedge clk) begin
		if (start) begin
			state <= 1'b1;
		end
		else
			state <= 1'b0;
	end 
	
	assign {encaldetMxB,donecaldetMxB} = (state==1'b1) ? {1'b1,1'b1} : {1'b0,1'b0};
	assign {ra1MxB,ra2MxB,ra3MxB,ra4MxB} = (state==1'b1) ? {4'd0,4'd1,4'd2,4'd3} : 4'hz;
	assign {ra1MxC,ra2MxC,ra3MxC,ra4MxC} = (state==1'b1) ? {4'd0,4'd1,4'd2,4'd3} : 4'hz;
	
endmodule