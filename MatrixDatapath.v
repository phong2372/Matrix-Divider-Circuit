module MatrixDatapath(	
	clk,
	//-----------------------------Import----------------------------------
	InputMatrixA_en,InputMatrixB_en,//2
	InputMatrixA_addr,InputMatrixB_addr,// 2*4
	//-----------------------------MatrixA---------------------------------
	MatrixA_RegWrite, //1
	MatrixA_wa,MatrixA_ra1,MatrixA_ra2,MatrixA_ra3,MatrixA_ra4, //5*4
	//-------------------------------MatrixB--------------------------------
	MatrixB_RegWrite, //1
	MatrixB_wa,MatrixB_ra1,MatrixB_ra2,MatrixB_ra3,MatrixB_ra4, // 5*4
	MatrixB_ra5,MatrixB_ra6,MatrixB_ra7,MatrixB_ra8,MatrixB_ra9, // 5*4
	//-------------------------------MatrixC--------------------------------
	MatrixC_RegWrite,MatrixC_wa, //1
	MatrixC_ra1,MatrixC_ra2,MatrixC_ra3,MatrixC_ra4, //4*4
	//------------------------------tmpMxB---------------------------------
	tmpMxB_RegWrite,//1
	tmpMxB_wa,tmpMxB_ra1,//2*4
	//------------------------------MxBinv-----------------------------------
	MxBinv_RegWrite,MxBinv_wa,
	MxBinv_ra1,MxBinv_ra2,MxBinv_ra3,MxBinv_ra4,
	//-------------------------------MatrixR---------------------------------
	MatrixR_RegWrite,MatrixR_wa,
	MatrixR_ra1,MatrixR_ra2,MatrixR_ra3,MatrixR_ra4,
	//--------------------------------detB----------------------------------
	detB_RegWrite,detB_re, //2
	//-------------------------------------i0------------------------------
	i0_sign,
	//-----------------------------Outputcheck---------------------------------
	o_detZero,
	o_MxAwd,o_MxBwd,
	o_MxCwd,o_Regwd,o_MxtmpBwd,o_MxBinvwd
	,o_MxRwd
	//---------------------------------END------------------------------------- 
);
	//*****************------------Outputcheck-------------*****************
	output o_detZero;
	output [31:0] o_MxAwd,o_MxBwd;
	output [31:0] o_MxCwd,o_Regwd,o_MxtmpBwd,o_MxBinvwd,o_MxRwd;
	//******************---------------------------------******************
	input clk; 
	//---------------------------ControlInput------------------------------
	//-----------------------------Import----------------------------------
	input InputMatrixA_en,InputMatrixB_en;
	input [3:0] InputMatrixA_addr,InputMatrixB_addr;
	//-----------------------------MatrixA---------------------------------
	input MatrixA_RegWrite;
	input [3:0] MatrixA_wa,MatrixA_ra1,MatrixA_ra2,MatrixA_ra3,MatrixA_ra4; 
	//------------------------------tmpMxB---------------------------------
	input tmpMxB_RegWrite;
	input [3:0] tmpMxB_wa,tmpMxB_ra1;
   //-------------------------------MatrixB--------------------------------
	input MatrixB_RegWrite;
	input [3:0] MatrixB_wa,MatrixB_ra1,MatrixB_ra2,MatrixB_ra3,MatrixB_ra4;
	input [3:0] MatrixB_ra5,MatrixB_ra6,MatrixB_ra7,MatrixB_ra8,MatrixB_ra9;
	//------------------------------MxBinv-----------------------------------
	input MxBinv_RegWrite;
	input [3:0] MxBinv_wa;
	input [3:0] MxBinv_ra1,MxBinv_ra2,MxBinv_ra3,MxBinv_ra4;
	//-------------------------------MatrixC--------------------------------
	input MatrixC_RegWrite;
	input [3:0] MatrixC_wa;
	input [3:0] MatrixC_ra1,MatrixC_ra2,MatrixC_ra3,MatrixC_ra4;
	//-------------------------------MatrixR--------------------------------
	input MatrixR_RegWrite;
	input [3:0] MatrixR_wa,MatrixR_ra1,MatrixR_ra2,MatrixR_ra3,MatrixR_ra4;
	//--------------------------------detB----------------------------------
	input detB_RegWrite,detB_re;
	//-------------------------------------i0------------------------------
	input i0_sign;
	//---------------------------------END-------------------------------------
	//------------------------------ConnectWire------------------------
	wire [31:0] InputMatrixA_outq,InputMatrixB_outq;
	wire [31:0] rd1tmpMxB_wdMatrixB;
	wire [31:0] rd1MatrixB_in1det1ANDa11det2,rd2MatrixB_in2det1ANDa12det2;
	wire [31:0] rd3MatrixB_in3det1ANDa13det2,rd4MatrixB_in4det1ANDa14det2;
	wire [31:0] rd5MatrixB_in5det1,rd6MatrixB_in6det1,rd7MatrixB_in7det1;
	wire [31:0] rd8MatrixB_in8det1,rd9MatrixB_in9det1;
	wire [31:0] rd1MatrixC_d11det2ANDMxtmpBwd;
	wire [31:0] rd2MatrixC_d12det2,rd3MatrixC_d13det2,rd4MatrixC_d14det2;
	wire [31:0] resultdet1_wdMatrixC;
	wire [31:0] rd1tmpMxB_diji0; 
	wire [31:0] resultdet2_wddetB;
	wire [31:0] rddetB_deti0;
	wire [31:0] resulti0_wdMxBinv;
	wire [31:0] rd1MatrixA_a1m0,rd2MatrixA_a2m0,rd3MatrixA_a3m0,rd4MatrixA_a4m0;
	wire [31:0] rd1MxBinv_b1m0,rd2MxBinv_b2m0,rd3MxBinv_b3m0,rd4MxBinv_b4m0;
	wire [31:0] resultm0_wdMatrixR;
 	//------------------------------END---------------------------
	
	
	//--------------------Datapath-----------------------------------------
   //---------------------Module---------------------------------------------	
	Data_MatrixA InputMatrixA (InputMatrixA_addr,InputMatrixA_en,InputMatrixA_outq);
	Data_MatrixB InputMatrixB (InputMatrixB_addr,InputMatrixB_en,InputMatrixB_outq);
	 
	rf MatrixA(clk,MatrixA_RegWrite,MatrixA_wa,InputMatrixA_outq,
				  MatrixA_ra1,MatrixA_ra2,MatrixA_ra3,MatrixA_ra4,
				  rd1MatrixA_a1m0,rd2MatrixA_a2m0,
				  rd3MatrixA_a3m0,rd4MatrixA_a4m0);
				  
	rfB MatrixB(clk,MatrixB_RegWrite,MatrixB_wa,InputMatrixB_outq,
					MatrixB_ra1,MatrixB_ra2,MatrixB_ra3,MatrixB_ra4,
					MatrixB_ra5,MatrixB_ra6,MatrixB_ra7,MatrixB_ra8,MatrixB_ra9,
					rd1MatrixB_in1det1ANDa11det2,rd2MatrixB_in2det1ANDa12det2,
					rd3MatrixB_in3det1ANDa13det2,rd4MatrixB_in4det1ANDa14det2,
					rd5MatrixB_in5det1,rd6MatrixB_in6det1,rd7MatrixB_in7det1,
					rd8MatrixB_in8det1,rd9MatrixB_in9det1);
					
	rf MatrixC(clk,MatrixC_RegWrite,MatrixC_wa,resultdet1_wdMatrixC,
				  MatrixC_ra1,MatrixC_ra2,MatrixC_ra3,MatrixC_ra4,
				  rd1MatrixC_d11det2ANDMxtmpBwd,
				  rd2MatrixC_d12det2,rd3MatrixC_d13det2,rd4MatrixC_d14det2);
					
	rf tmpMxB (.clk(clk),.RegWrite(tmpMxB_RegWrite),.wa(tmpMxB_wa),.wd(rd1MatrixC_d11det2ANDMxtmpBwd),
				  .ra1(tmpMxB_ra1),.ra2(),.ra3(),.ra4(),
				  .rd1(rd1tmpMxB_diji0),.rd2(),.rd3(),.rd4());
	rf MxBinv (clk,MxBinv_RegWrite,MxBinv_wa,resulti0_wdMxBinv,
				  MxBinv_ra1,MxBinv_ra2,MxBinv_ra3,MxBinv_ra4,
				  rd1MxBinv_b1m0,rd2MxBinv_b2m0,rd3MxBinv_b3m0,rd4MxBinv_b4m0);
				  
	Register detB(clk,detB_RegWrite,resultdet2_wddetB,detB_re,rddetB_deti0);
	
	rf MatrixR(.clk(clk),.RegWrite(MatrixR_RegWrite),.wa(MatrixR_wa),
				  .wd(resultm0_wdMatrixR),
				  .ra1(MatrixR_ra1),.ra2(),.ra3(),.ra4(),
				  .rd1(MatrixR_rd1),.rd2(),.rd3(),.rd4());
	
	detMatrix_33 det1(rd1MatrixB_in1det1ANDa11det2,rd2MatrixB_in2det1ANDa12det2,
							rd3MatrixB_in3det1ANDa13det2,rd4MatrixB_in4det1ANDa14det2,
							rd5MatrixB_in5det1,rd6MatrixB_in6det1,rd7MatrixB_in7det1,
							rd8MatrixB_in8det1,rd9MatrixB_in9det1,
							resultdet1_wdMatrixC);
	
	detMatrix_44 det2(rd1MatrixB_in1det1ANDa11det2,rd2MatrixB_in2det1ANDa12det2,
							rd3MatrixB_in3det1ANDa13det2,rd4MatrixB_in4det1ANDa14det2,
							rd1MatrixC_d11det2ANDMxtmpBwd,
							rd2MatrixC_d12det2,rd3MatrixC_d13det2,rd4MatrixC_d14det2,
							resultdet2_wddetB,o_detZero);

	Inverse i0(i0_sign,rd1tmpMxB_diji0,rddetB_deti0,resulti0_wdMxBinv);
	
	Mulmatrix_44 m0(rd1MatrixA_a1m0,rd2MatrixA_a2m0,rd3MatrixA_a3m0,rd4MatrixA_a4m0,
						 rd1MxBinv_b1m0,rd2MxBinv_b2m0,rd3MxBinv_b3m0,rd4MxBinv_b4m0,
						 resultm0_wdMatrixR);
						
	//-----------------------------END---------------------------------------
	//-------------------------Output_check---------------------------------
	assign {o_MxAwd,o_MxBwd} = {InputMatrixA_outq,InputMatrixB_outq};
	assign o_MxCwd = resultdet1_wdMatrixC;
	assign o_Regwd = resultdet2_wddetB;
	assign o_MxBinvwd = resulti0_wdMxBinv;
	assign o_MxRwd = resultm0_wdMatrixR;
	assign o_MxtmpBwd = rd1MatrixC_d11det2ANDMxtmpBwd;
	assign o_MxRwd = resultm0_wdMatrixR;
	 
endmodule