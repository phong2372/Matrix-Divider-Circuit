module rfB(
	clk,
	RegWrite,wa,wd,
	ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,
	rd1,rd2,rd3,rd4,rd5,rd6,rd7,rd8,rd9
);
	input clk;
	input RegWrite;
	input [3:0] wa,ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9;		
	input [31:0] wd; 	
	output [31:0] rd1,rd2,rd3,rd4,rd5,rd6,rd7,rd8,rd9; 	

	reg [31:0] memory [15:0]; 	

	assign rd1 = memory[ra1];
	assign rd2 = memory[ra2];
	assign rd3 = memory[ra3];
	assign rd4 = memory[ra4];
	assign rd5 = memory[ra5];
	assign rd6 = memory[ra6];
	assign rd7 = memory[ra7];
	assign rd8 = memory[ra8];
	assign rd9 = memory[ra9];

	always@(posedge clk)begin
		if(RegWrite==1'b1)begin
			memory[wa]<=wd;
		end
	end
	
endmodule