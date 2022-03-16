module Register(clk,RegWrite,wd,re,rd);

	input clk;
	input RegWrite,re; 		
	input [31:0] wd; 	
	output [31:0] rd;

	reg [31:0] q; 	

	assign rd = (re) ? q : 32'hz;    

	always@(posedge clk)begin
		if(RegWrite==1'b1)begin
			q<=wd;
		end
	end
	
endmodule