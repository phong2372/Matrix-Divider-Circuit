module matrix(
	input clk, start,
	output done,
	//--------checkimport-------
	output ck_enAB,
	//--------checkCalMxC-----------
	output ck_enCalMxC,
	//----------checkcaldetMxB-----------------
	output ck_encaldetMxB,
	//--------checktranspose----	
	output ck_enTS,
	//------------checkInverse--------------------
	output ck_eninvMxB,
	//-----------checkMulmx--------------
	output ck_enMulmx,
 	//-----------checkdatapath--------------------
	output out_detZero,
	output [31:0] out_MxAwd,out_MxBwd,
	output [31:0] out_MxCwd,out_Regwd,out_MxtmpBwd,out_MxBinvwd,
	output [31:0] out_MxRwd
);
   //---------------c-o-n-t-r-o-l-e-r-----------------------------------------------
	//--------import----------------
	wire enAB;
	wire doneimport;
	wire [3:0] addrAB;
	control_import import(
	.clk(clk), .start(start),
	.done(doneimport),
	.enAB(enAB),
	.addrAB(addrAB)
);
	assign ck_enAB = enAB;
	//-------CalMatrixC-----------------------
	wire enCalMxC,donecalMxC;
	wire [3:0] addrMxC_calMxC;
	wire [3:0] ra1MxB,ra2MxB,ra3MxB,ra4MxB;
	wire [3:0] ra5MxB_calMxC,ra6MxB_calMxC;
	wire [3:0] ra7MxB_calMxC,ra8MxB_calMxC,ra9MxB_calMxC;
	control_calMatrixC calMxC(
	.clk(clk), .start(doneimport),
      .encalMxC(enCalMxC),.donecalMxC(donecalMxC),
	.addrMxC(addrMxC_calMxC),
	.rd1MxB(ra1MxB),.rd2MxB(ra2MxB),.rd3MxB(ra3MxB),.rd4MxB(ra4MxB),
	.rd5MxB(ra5MxB_calMxC),.rd6MxB(ra6MxB_calMxC),
	.rd7MxB(ra7MxB_calMxC),.rd8MxB(ra8MxB_calMxC),
	.rd9MxB(ra9MxB_calMxC)
);
	assign ck_enCalMxC = enCalMxC;
	//-----------------caldetMxB------------------------------
	wire encaldetMxB,donecaldetMxB;
	wire [3:0] ra1MxC_caldetMxB,ra2MxC_caldetMxB,ra3MxC_caldetMxB,ra4MxC_caldetMxB;
	control_caldetMxB caldetB(
	.clk(clk), .start(donecalMxC),
	.encaldetMxB(encaldetMxB),.donecaldetMxB(donecaldetMxB),
	.ra1MxB(ra1MxB),.ra2MxB(ra2MxB),
	.ra3MxB(ra3MxB),.ra4MxB(ra4MxB),
	.ra1MxC(ra1MxC_caldetMxB),.ra2MxC(ra2MxC_caldetMxB),
	.ra3MxC(ra3MxC_caldetMxB),.ra4MxC(ra4MxC_caldetMxB)
);
	assign ck_encaldetMxB = encaldetMxB;
	//-------transpose------------------
	wire enTS;
	wire doneTS;
	wire [3:0] addrtmpMxB_TS;
	control_transpose transpose(
	.clk(clk), .start(donecaldetMxB),
	.done(doneTS),.en(enTS),
	.addrtmpMxB(addrtmpMxB_TS),.addrMxC(ra1MxC_caldetMxB)
);
	assign ck_enTS = enTS;
	//--------------------invMxB------------------------------------
	wire eninvMxB,sign,reReg,doneinvMxB;
	wire [3:0] addrMxBinv,addrtmpMxB;
	control_Inverse invMxB(
	.clk(clk), .start(doneTS),
	.eninvMxB(eninvMxB),.doneinvMxB(doneinvMxB),
	.reReg(reReg),.sign(sign),
	.addrMxBinv(addrMxBinv),.addrtmpMxB(addrtmpMxB),
);
	assign ck_eninvMxB = eninvMxB;
	//--------------------Mulmatrix----------------------------
	wire enMulmx;
	wire [3:0] addrMxR,ra1MxA,ra2MxA,ra3MxA,ra4MxA;
	wire [3:0] ra1MxBinv,ra2MxBinv,ra3MxBinv,ra4MxBinv;
	control_Mulmx Mulmx(
	.clk(clk), .start(doneinvMxB),
	.enMulmx(enMulmx),.doneMulmx(done),
	.addrMxR(addrMxR),
	.ra1MxA(ra1MxA),.ra2MxA(ra2MxA),
	.ra3MxA(ra3MxA),.ra4MxA(ra4MxA),
	.ra1MxBinv(ra1MxBinv),.ra2MxBinv(ra2MxBinv),
	.ra3MxBinv(ra3MxBinv),.ra4MxBinv(ra4MxBinv)
);
	assign ck_enMulmx = enMulmx;
	//--------------------------------END------------------------
   //---------------------------datapath------------------------------------------------
   MatrixDatapath datapath(	
	.clk(clk),
	//-----------------------------Import----------------------------------
	.InputMatrixA_en(enAB),.InputMatrixB_en(enAB),
	.InputMatrixA_addr(addrAB),.InputMatrixB_addr(addrAB),
	//-----------------------------MatrixA---------------------------------
	.MatrixA_RegWrite(enAB), 
	.MatrixA_wa(addrAB),
	.MatrixA_ra1(ra1MxA),.MatrixA_ra2(ra2MxA),
	.MatrixA_ra3(ra3MxA),.MatrixA_ra4(ra4MxA), 
	//-------------------------------MatrixB--------------------------------
	.MatrixB_RegWrite(enAB),.MatrixB_wa(addrAB),
	.MatrixB_ra1(ra1MxB),.MatrixB_ra2(ra2MxB),.MatrixB_ra3(ra3MxB),.MatrixB_ra4(ra4MxB),
	.MatrixB_ra5(ra5MxB_calMxC),.MatrixB_ra6(ra6MxB_calMxC),
	.MatrixB_ra7(ra7MxB_calMxC),.MatrixB_ra8(ra8MxB_calMxC),.MatrixB_ra9(ra9MxB_calMxC), 
	//-------------------------------MatrixC--------------------------------
	.MatrixC_RegWrite(enCalMxC),.MatrixC_wa(addrMxC_calMxC), 
	.MatrixC_ra1(ra1MxC_caldetMxB),.MatrixC_ra2(ra2MxC_caldetMxB),
	.MatrixC_ra3(ra3MxC_caldetMxB),.MatrixC_ra4(ra4MxC_caldetMxB), 
	//------------------------------tmpMxB---------------------------------
	.tmpMxB_RegWrite(enTS),
	.tmpMxB_wa(addrtmpMxB_TS),.tmpMxB_ra1(addrtmpMxB),
	//------------------------------MxBinv-----------------------------------
	.MxBinv_RegWrite(eninvMxB),.MxBinv_wa(addrMxBinv),
	.MxBinv_ra1(ra1MxBinv),.MxBinv_ra2(ra2MxBinv),
	.MxBinv_ra3(ra3MxBinv),.MxBinv_ra4(ra4MxBinv),
	//-------------------------------MatrixR---------------------------------
	.MatrixR_RegWrite(enMulmx),.MatrixR_wa(addrMxR),
	.MatrixR_ra1(),.MatrixR_ra2(),.MatrixR_ra3(),.MatrixR_ra4(),
	//--------------------------------detB----------------------------------
	.detB_RegWrite(encaldetMxB),.detB_re(reReg), 
	//-------------------------------------i0------------------------------
	.i0_sign(sign),
	//-----------------------------Outputcheck---------------------------------
	.o_detZero(out_detZero),
	.o_MxAwd(out_MxAwd),.o_MxBwd(out_MxBwd),
	.o_MxCwd(out_MxCwd),.o_Regwd(out_Regwd),.o_MxtmpBwd(out_MxtmpBwd),.o_MxBinvwd(out_MxBinvwd),
	.o_MxRwd(out_MxRwd)
	//---------------------------------END------------------------------------- 
);
endmodule 
	