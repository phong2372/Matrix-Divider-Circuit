module Data_MatrixB(
	input [3:0] addr,
	input en,
	output reg [31:0] q
);

	reg [31:0] rom[15:0];

	initial begin
		$readmemb("matrixB.txt", rom);
	end

	always @(addr) begin
	if (en)
		q = rom[addr];
	else 
		q = 32'hz;
	end

endmodule
