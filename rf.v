module rf(
	clk,
	RegWrite,wa,wd,
	ra1,ra2,ra3,ra4,
	rd1,rd2,rd3,rd4
);

	input clk;
	input RegWrite;
	input [3:0] wa,ra1,ra2,ra3,ra4;		
	input [31:0] wd; 	
	output [31:0] rd1,rd2,rd3,rd4; 	

	reg [31:0] memory [15:0]; 	

	assign rd1 = memory[ra1];
	assign rd2 = memory[ra2];
	assign rd3 = memory[ra3];
	assign rd4 = memory[ra4];

	always@(posedge clk)begin
		if(RegWrite==1'b1)begin
			memory[wa]<=wd;
		end
	end
	
endmodule