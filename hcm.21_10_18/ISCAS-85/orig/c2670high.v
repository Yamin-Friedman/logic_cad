/****************************************************************************
 *                                                                          *
 *  VERILOG HIGH-LEVEL DESCRIPTION OF THE ISCAS-85 BENCHMARK CIRCUIT c2670  *
 *                                                                          *  
 *                                                                          *
 *  Written by   : Hakan Yalcin (hyalcin@cadence.com)			    *
 *  Verified by  : Jonathan David Hauke (jhauke@eecs.umich.edu)             *
 *                                                                          *
 *  First created: Jan 14, 1997                                             *
 *  Last modified: Oct 20, 1998                                             *
 *                                                                          *
****************************************************************************/

module Circuit2670 (
        in81, in92, in91, in90, in89, in88, in87, 
        in86, in85, in93, in43, in54, in53, in52, in51, 
        in50, in49, in48, in47, in55, in56, in66, in65, 
        in64, in63, in62, in61, in60, in67, in68, in79, 
        in78, in77, in76, in75, in74, in73, in72, in80, 
        in131, in141, in140, in139, in138, in137, in136, in135, 
        in142, in95, in105, in104, in103, in102, in101, in100, 
        in99, in106, in119, in129, in128, in127, in126, in125, 
        in124, in123, in130, in107, in117, in116, in115, in114, 
        in113, in112, in111, in118, in1971, in1966, in1961, in1956, 
        in1348, in1341, in2090, in2084, in2078, in2072, in2067, in1996, 
        in1991, in1986, in1981, in1976, in2096, in2100, in2678, in2474, 
        in2427, in2430, in2451, in2454, in2443, in2446, in2435, in2438, 
        in24, in6, in23, in22, in21, in5, in20, in4, 
        in19, in28, in35, in34, in27, in33, in26, in32, 
        in25, in651, in543, in2105, in2104, in1384, in40, in16, 
        in29, in11, in8, in37, in14, in44, in132, in82, 
        in96, in69, in120, in57, in108, in2106, in567, in559, 
        in860, in868, in452, in2066, in1083, in94, in7, in661, 
        in1, in2, in3, in15, in36, in483, in169, in174, 
        in177, in178, in179, in180, in181, in182, in183, in184, 
        in185, in186, in189, in190, in191, in192, in193, in194, 
        in195, in196, in197, in198, in199, in200, in201, in202, 
        in203, in204, in205, in206, in207, in208, in209, in210, 
        in211, in212, in213, in214, in215, in239, in240, in241, 
        in242, in243, in244, in245, in246, in247, in248, in249, 
        in250, in251, in252, in253, in254, in255, in256, in257, 
        in262, in263, in264, in265, in266, in267, in268, in269, 
        in270, in271, in272, in273, in274, in275, in276, in277, 
        in278, in279,
        out329, out231, out311, out150, out308, out225, out395, 
        out397, out227, out229, out401, out319, out325, out261, out220, 
        out221, out219, out218, out235, out236, out237, out238, out335, 
        out350, out391, out409, out337, out384, out411, out367, out369, 
        out173, out295, out331, out145, out148, out282, out323, out284, 
        out321, out297, out280, out153, out290, out305, out288, out303, 
        out286, out301, out299, out166, out168, out171, out162, out160, 
        out164, out156, out223, out217, out234, out259, out176, out188, 
        out158, out169, out174, out177, out178, out179, out180, out181, 
        out182, out183, out184, out185, out186, out189, out190, out191, 
        out192, out193, out194, out195, out196, out197, out198, out199, 
        out200, out201, out202, out203, out204, out205, out206, out207, 
        out208, out209, out210, out211, out212, out213, out214, out215, 
        out239, out240, out241, out242, out243, out244, out245, out246, 
        out247, out248, out249, out250, out251, out252, out253, out254, 
        out255, out256, out257, out262, out263, out264, out265, out266, 
        out267, out268, out269, out270, out271, out272, out273, out274, 
        out275, out276, out277, out278, out279);
 
   input
        in81, in92, in91, in90, in89, in88, in87, 
        in86, in85, in93, in43, in54, in53, in52, in51, 
        in50, in49, in48, in47, in55, in56, in66, in65, 
        in64, in63, in62, in61, in60, in67, in68, in79, 
        in78, in77, in76, in75, in74, in73, in72, in80, 
        in131, in141, in140, in139, in138, in137, in136, in135, 
        in142, in95, in105, in104, in103, in102, in101, in100, 
        in99, in106, in119, in129, in128, in127, in126, in125, 
        in124, in123, in130, in107, in117, in116, in115, in114, 
        in113, in112, in111, in118, in1971, in1966, in1961, in1956, 
        in1348, in1341, in2090, in2084, in2078, in2072, in2067, in1996, 
        in1991, in1986, in1981, in1976, in2096, in2100, in2678, in2474, 
        in2427, in2430, in2451, in2454, in2443, in2446, in2435, in2438, 
        in24, in6, in23, in22, in21, in5, in20, in4, 
        in19, in28, in35, in34, in27, in33, in26, in32, 
        in25, in651, in543, in2105, in2104, in1384, in40, in16, 
        in29, in11, in8, in37, in14, in44, in132, in82, 
        in96, in69, in120, in57, in108, in2106, in567, in559, 
        in860, in868, in452, in2066, in1083, in94, in7, in661, 
        in1, in2, in3, in15, in36, in483, in169, in174, 
        in177, in178, in179, in180, in181, in182, in183, in184, 
        in185, in186, in189, in190, in191, in192, in193, in194, 
        in195, in196, in197, in198, in199, in200, in201, in202, 
        in203, in204, in205, in206, in207, in208, in209, in210, 
        in211, in212, in213, in214, in215, in239, in240, in241, 
        in242, in243, in244, in245, in246, in247, in248, in249, 
        in250, in251, in252, in253, in254, in255, in256, in257, 
        in262, in263, in264, in265, in266, in267, in268, in269, 
        in270, in271, in272, in273, in274, in275, in276, in277, 
        in278, in279;
 
   output
        out329, out231, out311, out150, out308, out225, out395, 
        out397, out227, out229, out401, out319, out325, out261, out220, 
        out221, out219, out218, out235, out236, out237, out238, out335, 
        out350, out391, out409, out337, out384, out411, out367, out369, 
        out173, out295, out331, out145, out148, out282, out323, out284, 
        out321, out297, out280, out153, out290, out305, out288, out303, 
        out286, out301, out299, out166, out168, out171, out162, out160, 
        out164, out156, out223, out217, out234, out259, out176, out188, 
        out158, out169, out174, out177, out178, out179, out180, out181, 
        out182, out183, out184, out185, out186, out189, out190, out191, 
        out192, out193, out194, out195, out196, out197, out198, out199, 
        out200, out201, out202, out203, out204, out205, out206, out207, 
        out208, out209, out210, out211, out212, out213, out214, out215, 
        out239, out240, out241, out242, out243, out244, out245, out246, 
        out247, out248, out249, out250, out251, out252, out253, out254, 
        out255, out256, out257, out262, out263, out264, out265, out266, 
        out267, out268, out269, out270, out271, out272, out273, out274, 
        out275, out276, out277, out278, out279;

/********************************************************/
   
   wire	VDD;
//   assign VDD = 1'b1;

// Inputs/Outputs to TopLevel2670
   
   wire [9:0]	A1bus, A2bus, A3bus, A4bus;
   wire [9:0]	B1bus, B2bus, B3bus, B4bus;
   wire [5:0]	Y1bus, Y2bus;
   wire [3:0]	Y3bus;
   wire [8:0]	Z1bus;
   wire [7:0]	Z2bus;
   wire [11:0]	ParTreeIns;
   wire		ContA0, ContA1, ContB0, ContB1;
   wire		ContMask0, ContMask1, ContMask2;
   wire		ContZ0, ContZ1, ContEq;
   wire		ContPar0, ContPar1, ContPar2, ContPar3;
   wire		OutYgreaterX, OutYgreaterX_Equal, OutZequalW, OutNot_ZequalW;
   wire		OutParCheck, OutNot_ParCheck;
   wire [7:0]	ParChkOuts;
   wire [7:0]	InTbus, OutTbus;
   wire		MiscMuxIn, MiscMuxCont0, MiscMuxCont1;
   wire [10:0]	MiscMuxOuts;
   wire [12:0]	MiscBusOuts;
   wire [11:0]	MiscRandomIns;
   wire [17:0]	MiscRandomOuts;
   
/********************************************************/
// inputs

   assign 
      A1bus[9:0] = { in93, in85, in86, in87, in88,
		     in89, in90, in91, in92, in81 },
      A2bus[9:0] = { in55, in47, in48, in49, in50,
		     in51, in52, in53, in54, in43 },
      A3bus[9:0] = { in67, in60, in61, VDD, in62,
		     in63, in64, in65, in66, in56 },
      A4bus[9:0] = { in80, in72, in73, in74, in75,
		     in76, in77, in78, in79, in68 };
   assign 
      B1bus[9:0] = { VDD, in142, in135, in136, in137,
		     in138, in139, in140, in141, in131 },
      B2bus[9:0] = { VDD, in106, in99, in100, in101,
		     in102, in103, in104, in105, in95 },
      B3bus[9:0] = {VDD, in130, in123, in124, in125,
		    in126, in127, in128, in129, in119 },
      B4bus[9:0] = { VDD, in118, in111, in112, in113,
		     in114, in115, in116, in117, in107 };
   assign
      Y1bus[5:0] = { in1971, in1966, in1961, in1956, in1348, in1341 },
      Y2bus[5:0] = { in2090, in2084, in2078, in2072, in2067, in1996 },
      Y3bus[3:0] = { in1991, in1986, in1981, in1976 };
   
   assign
      Z1bus[8:0] = { in24, in6, in23, in22, in21, in5, in20, in4, in19 },
      Z2bus[7:0] = { in28, in35, in34, in27, in33, in26, in32, in25 };

   assign
      ParTreeIns[11:0] = { in2096, in2100, in2678, in2454, in2451, in2446,
			   in2443, in2438, in2435, in2430, in2427, in2474 };

   assign
      InTbus[7:0] = { in108, in57, in120, in69, in96, in82, in132, in44 };

   assign
      MiscRandomIns[11:0] = { in3, in1, in483, in36, in15, in2,
			      in661, in7, in94, in1083, in2066, in452 };
   assign
      ContA0 = in651,  ContA1 = in543,
      ContB0 = in2105, ContB1 = in2104,
      ContMask0 = in8, ContMask1 = in1384, ContMask2 = in40,
      ContZ0  = in16,  ContZ1 = in29,
      ContEq  = in11,
      ContPar0 = in14,   ContPar1 = in37,
      ContPar2 = in2106, ContPar3 = in567;

   assign
       MiscMuxIn = in559, MiscMuxCont0 = in868, MiscMuxCont1 = in860;

// outputs

   assign
      out329 = OutYgreaterX, out231 = OutYgreaterX_Equal,
      out150 = OutZequalW, out311 = OutNot_ZequalW,
      out308 = OutParCheck, out225 = OutNot_ParCheck;
   
   assign
      { out261, out325, out319, out401, out229, out227, out397, out395 } = ParChkOuts[7:0];

   assign
      { out238, out237, out236, out235,	out221, out220, out219, out218 } = OutTbus[7:0];
   
   assign
      { out280, out321, out323, out331, out153, out148,
	out145, out297, out284, out282, out295 } = MiscMuxOuts[10:0],
      { out164, out160, out162, out171, out168, out166,
	out299, out301, out286, out303, out288, out305,
	out290 } = MiscBusOuts[12:0],
      { out158, out188, out176, out259, out234, out217,
	out223, out156, out173, out369, out367, out411,
	out384, out337, out409, out391, out350, out335 } =  MiscRandomOuts[17:0];

/* instantiate top level circuit */
   
   TopLevel2670 Ckt2670(A1bus, A2bus, A3bus, A4bus, B1bus, B2bus, B3bus, B4bus,
			Y1bus, Y2bus, Y3bus, Z1bus, Z2bus, ParTreeIns,
			InTbus, ContA0, ContA1, ContB0, ContB1,
			ContMask0, ContMask1, ContMask2, ContZ0, ContZ1, ContEq,
			ContPar0, ContPar1, ContPar2, ContPar3,
			MiscMuxIn, MiscMuxCont0, MiscMuxCont1, MiscRandomIns,

			OutYgreaterX, OutYgreaterX_Equal, OutZequalW,
			OutNot_ZequalW, OutParCheck, OutNot_ParCheck,
			ParChkOuts, OutTbus,	MiscMuxOuts, MiscBusOuts, MiscRandomOuts);   


/* these 76 lines go straigh through the circuit */
   
   assign
      out169 = in169, out174 = in174, out177 = in177, out178 = in178,
      out179 = in179, out180 = in180, out181 = in181, out182 = in182,
      out183 = in183, out184 = in184, out185 = in185, out186 = in186,
      out189 = in189, out190 = in190, out191 = in191, out192 = in192,
      out193 = in193, out194 = in194, out195 = in195, out196 = in196,
      out197 = in197, out198 = in198, out199 = in199, out200 = in200,
      out201 = in201, out202 = in202, out203 = in203, out204 = in204,
      out205 = in205, out206 = in206, out207 = in207, out208 = in208,
      out209 = in209, out210 = in210, out211 = in211, out212 = in212,
      out213 = in213, out214 = in214, out215 = in215, out239 = in239,
      out240 = in240, out241 = in241, out242 = in242, out243 = in243,
      out244 = in244, out245 = in245, out246 = in246, out247 = in247,
      out248 = in248, out249 = in249, out250 = in250, out251 = in251,
      out252 = in252, out253 = in253, out254 = in254, out255 = in255,
      out256 = in256, out257 = in257, out262 = in262, out263 = in263,
      out264 = in264, out265 = in265, out266 = in266, out267 = in267,
      out268 = in268, out269 = in269, out270 = in270, out271 = in271,
      out272 = in272, out273 = in273, out274 = in274, out275 = in275,
      out276 = in276, out277 = in277, out278 = in278, out279 = in279;


endmodule // Circuit2670

/***************************************************************************/
/***************************************************************************/

module TopLevel2670(A1bus, A2bus, A3bus, A4bus, B1bus, B2bus, B3bus, B4bus,
		    Y1bus, Y2bus, Y3bus, Z1bus, Z2bus, ParTreeIns,
		    InTbus, ContA0, ContA1, ContB0, ContB1,
		    ContMask0, ContMask1, ContMask2, ContZ0, ContZ1, ContEq,
		    ContPar0, ContPar1, ContPar2, ContPar3,
		    MiscMuxIn, MiscMuxCont0, MiscMuxCont1, MiscRandomIns,

		    OutYgreaterX, OutYgreaterX_Equal, OutZequalW,
		    OutNot_ZequalW, OutParCheck, OutNot_ParCheck,
		    ParChkOuts, OutTbus, MiscMuxOuts, MiscBusOuts, MiscRandomOuts);   

   input [9:0]	 A1bus, A2bus, A3bus, A4bus;
   input [9:0]	 B1bus, B2bus, B3bus, B4bus;
   input [5:0]	 Y1bus, Y2bus;
   input [3:0]	 Y3bus;
   input [8:0]	 Z1bus;
   input [7:0]	 Z2bus;
   input [11:0]	 ParTreeIns;
   input [7:0]	 InTbus;
   input	 ContA0, ContA1, ContB0, ContB1, ContMask0, ContMask1, ContMask2;
   input	 ContZ0, ContZ1, ContEq;
   input	 ContPar0, ContPar1, ContPar2, ContPar3;

   input	 MiscMuxIn, MiscMuxCont0, MiscMuxCont1;
   input [11:0]	 MiscRandomIns;
   
   output	 OutYgreaterX, OutYgreaterX_Equal, OutZequalW, OutNot_ZequalW;
   output	 OutParCheck, OutNot_ParCheck;
   output [7:0]	 ParChkOuts;
   output [7:0]	 OutTbus;

   output [10:0] MiscMuxOuts;
   output [12:0] MiscBusOuts;
   output [17:0] MiscRandomOuts;

   wire [9:0]	 Abus, Bbus, Qbus, Rbus, Sbus;
   wire [11:0]	 Xbus, Ybus;
   wire [16:0]	 Wbus, Zbus;
   wire [8:0]	 V1bus;
   wire [7:0]	 V2bus;
   wire		 CompCLAs;
   
   
   Mux10bit_4_1 M1( A1bus, A2bus, A3bus, A4bus, ContA0, ContA1, Abus ),
                M2( B1bus, B2bus, B3bus, B4bus, ContB0, ContB1, Bbus );

   assign Xbus[8:0]  = Abus[8:0],
          Xbus[11:9] = Bbus[2:0];
   
   ContSignalGen M3( Bbus[4], Bbus[5], ContMask1, ContMask2, ContAlpha, ContBeta );
   
   CompareXY M4( Xbus, Ybus, ContAlpha, ContBeta, ContMask0,
		 OutYgreaterX, OutYgreaterX_Equal, CompCLAs );

   MuxSpecY M5( Y1bus, Y2bus, Y3bus, ContAlpha, ParTreeIns,
		Ybus, Wbus, Qbus, Rbus, Sbus );

   assign
      V1bus[8:0] = Abus[8:0],
      V2bus[7:0] = Bbus[7:0];
   
   MuxSpecZ M6( Z1bus, Z2bus, V1bus, V2bus, ContZ0, ContZ1, Zbus );

   EqualZ_W M7( Zbus, Wbus, ContEq, OutZequalW, OutNot_ZequalW );

   ParityChecker M8( Abus, Bbus, Qbus, Rbus, Sbus, CompCLAs,
		     ContPar0, ContPar1, ContPar2, ContPar3, InTbus,
		     OutParCheck, OutNot_ParCheck, ParChkOuts, OutTbus );

   MiscLogic M9( Abus, Bbus, Y2bus, ParTreeIns, MiscRandomIns, ContPar2, ContPar3,
		 MiscMuxIn, MiscMuxCont0, MiscMuxCont1, ParChkOuts[5],
		 MiscMuxOuts, MiscBusOuts, MiscRandomOuts );
   
endmodule // TopLevel2670


/***************************************************************************
 * module: Mux10bit_4_1
 * 
 * Function: 10 bit 4:1 muxes
 * 
***************************************************************************/

module   Mux10bit_4_1( In1bus, In2bus, In3bus, In4bus, Cont0, Cont1, Outbus );

   input [9:0]	In1bus, In2bus, In3bus, In4bus;
   input		Cont0, Cont1;
   output [9:0] Outbus;

   Mux4_1 Mux0(  In1bus[0], In2bus[0], In3bus[0], In4bus[0], Cont0, Cont1, Outbus[0] ),
          Mux1(  In1bus[1], In2bus[1], In3bus[1], In4bus[1], Cont0, Cont1, Outbus[1] ),
          Mux2(  In1bus[2], In2bus[2], In3bus[2], In4bus[2], Cont0, Cont1, Outbus[2] ),
          Mux3(  In1bus[3], In2bus[3], In3bus[3], In4bus[3], Cont0, Cont1, Outbus[3] ),
          Mux4(  In1bus[4], In2bus[4], In3bus[4], In4bus[4], Cont0, Cont1, Outbus[4] ),
          Mux5(  In1bus[5], In2bus[5], In3bus[5], In4bus[5], Cont0, Cont1, Outbus[5] ),
          Mux6(  In1bus[6], In2bus[6], In3bus[6], In4bus[6], Cont0, Cont1, Outbus[6] ),
          Mux7(  In1bus[7], In2bus[7], In3bus[7], In4bus[7], Cont0, Cont1, Outbus[7] ),
          Mux8(  In1bus[8], In2bus[8], In3bus[8], In4bus[8], Cont0, Cont1, Outbus[8] ),
          Mux9(  In1bus[9], In2bus[9], In3bus[9], In4bus[9], Cont0, Cont1, Outbus[9] );

endmodule // Mux10bit_4_1

/******************************************************/

module   Mux4_1( In1, In2, In3, In4, Cont0, Cont1, Out );

   input In1, In2, In3, In4;
   input Cont0, Cont1;
   output Out;

   inv Mux0( .A(Cont0), .Y(Not_Cont0) ),
       Mux1( .A(Cont1), .Y(Not_Cont1) );
   and3 Mux2( .A(In1), .B(Not_Cont0), .C(Not_Cont1), .Y(line2) ),
       Mux3( .A(In2), .B(Not_Cont0), .C(Cont1), .Y(line3) ),
       Mux4( .A(In3), .B(Cont0), .C(Not_Cont1), .Y(line4) ),
       Mux5( .A(In4), .B(Cont0), .C(Cont1), .Y(line5) );
   or4 Mux6( .A(line2), .B(line3), .C(line4), .D(line5), .Y(Out) );

endmodule // Mux4_1

/***************************************************************************
 * module: ContSignalGen
 * 
 * Function: generate control signals ContAlpha and ContBeta
 * 
***************************************************************************/

module ContSignalGen ( Bbus4, Bbus5, ContMask1, ContMask2, ContAlpha, ContBeta);

   input	Bbus4, Bbus5, ContMask1, ContMask2;
   output	ContAlpha, ContBeta;
   
   inv UM3_0( .A(Bbus5), .Y(NotB5) ),
       UM3_1( .A(ContMask1), .Y(NotMask1) );
   and2 UM3_2( .A(Bbus4), .B(NotMask1), .Y(line2) );
   and3 UM3_3( .A(NotB5), .B(line2), .C(ContMask2), .Y(ContAlpha) );
   inv UM3_4( .A(line2), .Y(line4) );
   and3 UM3_5( .A(ContMask2), .B(line4), .C(NotB5), .Y(ContBeta) );

endmodule // ContSignalGen


/***************************************************************************
 * module: CompareXY
 * 
 * Function: compute OutYgreaterX = Ybus > Xbus
 * using a CLA. 
 * There are actually two CLAs with identical inputs. The outputs
 * of the CLAs are are exored (for comparison)  the output OutYgreaterX_Equal.
 * The complement of this signal, CompCLAs, is fed to ParityChecker.
 * 
 * The upper 8 bits of Xbus and Ybus can be masked out in groups of 4,6,8.
 * which gives the ability to compare buses of size 4,6,8 and 12.
 * 
 * RedundantInv is an inverter with redundancy in it, which causes
 * the longest path going through it to be false.
 * 
***************************************************************************/

module CompareXY( Xbus, Ybus, ContAlpha, ContBeta, ContMask0,
		  OutYgreaterX, OutYgreaterX_Equal, CompCLAs );

   input [11:0] Xbus, Ybus;
   input 	ContAlpha, ContBeta, ContMask0;
   output 	OutYgreaterX, OutYgreaterX_Equal, CompCLAs;

   wire [11:0]	 XMbus, YMbus, Not_XMbus;
   wire		 YgX1, YgX2, Not_CompCLAs;


   MaskBus UM4_0( Xbus, ContAlpha, ContBeta, ContMask0, XMbus ),
           UM4_1( Ybus, ContAlpha, ContBeta, ContMask0, YMbus );
   
   Invert12 UM4_2( XMbus, Not_XMbus );

   CLA12_XY  UM4_3( Not_XMbus, YMbus, YgX1 ),
             UM4_4( Not_XMbus, YMbus, YgX2 );

   assign OutYgreaterX = YgX1;

   XOR2b UM4_5( .A(YgX1), .B(YgX2), .Y(Not_CompCLAs) );

   RedundantInv UM4_6( .A(Not_CompCLAs), .Y(CompCLAs) );
   
   inv UM4_7( .A(CompCLAs), .Y(OutYgreaterX_Equal) );

endmodule // CompareXY

/********************************************/

module MaskBus( Inbus, ContAlpha, ContBeta, ContMask0, OutMbus );

   input [11:0]  Inbus;
   input 	 ContAlpha, ContBeta, ContMask0;
   output [11:0] OutMbus;

   assign OutMbus[3:0] = Inbus[3:0];

   and2 MB0( .A(Inbus[4]), .B(ContMask0), .Y(OutMbus[4]) ),
        MB1( .A(Inbus[5]), .B(ContMask0), .Y(OutMbus[5]) );

   inv MB2( .A(ContAlpha), .Y(NotAlpha) );
   
   and2 MB3( .A(Inbus[6]), .B(NotAlpha), .Y(line3) ),
       MB4( .A(line3), .B(ContMask0), .Y(OutMbus[6]) ),
       MB5( .A(Inbus[7]), .B(NotAlpha), .Y(line5) ),
       MB6( .A(line5), .B(ContMask0), .Y(OutMbus[7]) );
   
   // InBus[11:8] are ANDed with NotAlpha.ContBeta
   // note that NotAlpha.ContBeta = ContBeta
   // so there's some redundancy!!!
   
   and2 MB7( .A(Inbus[8]), .B(NotAlpha), .Y(line7) ),
       MB8( .A(line7), .B(ContBeta), .Y(OutMbus[8]) ),
       MB9( .A(Inbus[9]), .B(NotAlpha), .Y(line9) ),
       MB10( .A(line9), .B(ContBeta), .Y(OutMbus[9]) ),
       MB11( .A(Inbus[10]), .B(NotAlpha), .Y(line11) ),
       MB12( .A(line11), .B(ContBeta), .Y(OutMbus[10]) ),
       MB13( .A(Inbus[11]), .B(NotAlpha), .Y(line13) ),
       MB14( .A(line13), .B(ContBeta), .Y(OutMbus[11]) );

endmodule // MaskBus

/********************************************/

module Invert12( Inbus, Outbus );

   input [11:0]  Inbus;
   output [11:0] Outbus;
   
   inv Inv12_0( .A(Inbus[0]), .Y(Outbus[0]) ),
       Inv12_1( .A(Inbus[1]), .Y(Outbus[1]) ),
       Inv12_2( .A(Inbus[2]), .Y(Outbus[2]) ),
       Inv12_3( .A(Inbus[3]), .Y(Outbus[3]) ),
       Inv12_4( .A(Inbus[4]), .Y(Outbus[4]) ),
       Inv12_5( .A(Inbus[5]), .Y(Outbus[5]) ),
       Inv12_6( .A(Inbus[6]), .Y(Outbus[6]) ),
       Inv12_7( .A(Inbus[7]), .Y(Outbus[7]) ),
       Inv12_8( .A(Inbus[8]), .Y(Outbus[8]) ),
       Inv12_9( .A(Inbus[9]), .Y(Outbus[9]) ),
       Inv12_10( .A(Inbus[10]), .Y(Outbus[10]) ),
       Inv12_11( .A(Inbus[11]), .Y(Outbus[11]) );

endmodule // Invert12

/********************************************/

module CLA12_XY( In1bus, In2bus, OutCarry );

   input [11:0] In1bus, In2bus;
   output		 OutCarry;

   wire [11:0]	 Gbus, Pbus;

   CalcGP GP( In1bus, In2bus, Gbus, Pbus);

   CLACarry12_Cin0 CalcCy( Gbus, Pbus, OutCarry );

endmodule // Cla12XY

/********************************************/

module CalcGP( In1bus, In2bus, Gbus, Pbus);

   input [11:0]  In1bus, In2bus;
   output [11:0] Gbus, Pbus;

   and2 CalGP0( .A(In1bus[0]), .B(In2bus[0]), .Y(Gbus[0]) ),
       CalGP1( .A(In1bus[1]), .B(In2bus[1]), .Y(Gbus[1]) ),
       CalGP2( .A(In1bus[2]), .B(In2bus[2]), .Y(Gbus[2]) ),
       CalGP3( .A(In1bus[3]), .B(In2bus[3]), .Y(Gbus[3]) ),
       CalGP4( .A(In1bus[4]), .B(In2bus[4]), .Y(Gbus[4]) ),
       CalGP5( .A(In1bus[5]), .B(In2bus[5]), .Y(Gbus[5]) ),
       CalGP6( .A(In1bus[6]), .B(In2bus[6]), .Y(Gbus[6]) ),
       CalGP7( .A(In1bus[7]), .B(In2bus[7]), .Y(Gbus[7]) ),
       CalGP8( .A(In1bus[8]), .B(In2bus[8]), .Y(Gbus[8]) ),
       CalGP9( .A(In1bus[9]), .B(In2bus[9]), .Y(Gbus[9]) ),
       CalGP10( .A(In1bus[10]), .B(In2bus[10]), .Y(Gbus[10]) ),
       CalGP11( .A(In1bus[11]), .B(In2bus[11]), .Y(Gbus[11]) );

   XOR2a CalGP12( .A(In1bus[0]), .B(In2bus[0]), .Y(Pbus[0]) ),
         CalGP13( .A(In1bus[1]), .B(In2bus[1]), .Y(Pbus[1]) ),
         CalGP14( .A(In1bus[2]), .B(In2bus[2]), .Y(Pbus[2]) ),
         CalGP15( .A(In1bus[3]), .B(In2bus[3]), .Y(Pbus[3]) ),
         CalGP16( .A(In1bus[4]), .B(In2bus[4]), .Y(Pbus[4]) ),
         CalGP17( .A(In1bus[5]), .B(In2bus[5]), .Y(Pbus[5]) ),
         CalGP18( .A(In1bus[6]), .B(In2bus[6]), .Y(Pbus[6]) ),
         CalGP19( .A(In1bus[7]), .B(In2bus[7]), .Y(Pbus[7]) ),
         CalGP20( .A(In1bus[8]), .B(In2bus[8]), .Y(Pbus[8]) ),
         CalGP21( .A(In1bus[9]), .B(In2bus[9]), .Y(Pbus[9]) ),
         CalGP22( .A(In1bus[10]), .B(In2bus[10]), .Y(Pbus[10]) ),
         CalGP23( .A(In1bus[11]), .B(In2bus[11]), .Y(Pbus[11]) );

endmodule // CalcGP

/********************************************
 * 
 * This 12-bit CLA is made up of 3-, 4- and
 * 5-bit CLAs, whose outputs are appropriately
 * connected with the group propagate signals
 * Prop7_3 and Prop11_8 to generate the carry
 * output.
 * 
********************************************/

module CLACarry12_Cin0( Gbus, Pbus, OutCarry11_0 );

   input [11:0] Gbus, Pbus;
   output 	OutCarry11_0;

   CLACarry3_Cin0 Cla12_0( Gbus[2:0], Pbus[2:0], OutCarry2_0 );
   CLACarry5_Cin0 Cla12_1( Gbus[7:3], Pbus[7:3], OutCarry7_3 );
   CLACarry4_Cin0 Cla12_2( Gbus[11:8], Pbus[11:8], OutCarry11_8 );

   and5 Cla12_3( .A(Pbus[3]), .B(Pbus[4]), .C(Pbus[5]),
		 .D(Pbus[6]), .E(Pbus[7]), .Y(Prop7_3) );
   and4 Cla12_4( .A(Pbus[8]), .B(Pbus[9]), .C(Pbus[10]),
		 .D(Pbus[11]), .Y(Prop11_8) );   

   and2 Cla12_5( .A(Prop7_3), .B(OutCarry2_0), .Y(line5) );
   or2 Cla12_6( .A(OutCarry7_3), .B(line5), .Y(OutCarry7_0) );
   inv Cla12_7( .A(OutCarry7_0), .Y(NotOutCarry7_0) );
   or2 Cla12_8( .A(OutCarry11_8), .B(Prop11_8), .Y(line8) );
   and2 Cla12_9( .A(NotOutCarry7_0), .B(OutCarry11_8), .Y(line9) ),
       Cla12_10( .A(line8), .B(OutCarry7_0), .Y(line10) );
   or2 Cla12_11( .A(line9), .B(line10), .Y(OutCarry11_0) );
   
endmodule // CLACarry12_Cin0

/********************************************/

module CLACarry3_Cin0( Gbus, Pbus, OutCarry );

   input [2:0] Gbus, Pbus;
   output		 OutCarry;

   and2 Cla3_0( .A(Pbus[2]), .B(Gbus[1]), .Y(line0) );
   and3 Cla3_1( .A(Pbus[2]), .B(Pbus[1]), .C(Gbus[0]), .Y(line1) );
   or3 Cla3_2( .A(Gbus[2]), .B(line0), .C(line1), .Y(OutCarry) );

endmodule // CLACarry3_Cin0

/********************************************/

module CLACarry4_Cin0( Gbus, Pbus, OutCarry );

   input [3:0] Gbus, Pbus;
   output		 OutCarry;

   and2 Cla4_0( .A(Pbus[3]), .B(Gbus[2]), .Y(line0) );
   and3 Cla4_1( .A(Pbus[3]), .B(Pbus[2]), .C(Gbus[1]), .Y(line1) );
   and4 Cla4_2( .A(Pbus[3]), .B(Pbus[2]), .C(Pbus[1]), .D(Gbus[0]), .Y(line2) );
   or4 Cla4_3( .A(Gbus[3]), .B(line0), .C(line1), .D(line2), .Y(OutCarry) );

endmodule // CLACarry4_Cin0

/********************************************/

module CLACarry5_Cin0( Gbus, Pbus, OutCarry );

   input [4:0] Gbus, Pbus;
   output      OutCarry;

   and2 Cla5_0( .A(Pbus[4]), .B(Gbus[3]), .Y(line0) );
   and3 Cla5_1( .A(Pbus[4]), .B(Pbus[3]), .C(Gbus[2]), .Y(line1) );
   and4 Cla5_2( .A(Pbus[4]), .B(Pbus[3]), .C(Pbus[2]), .D(Gbus[1]), .Y(line2) );
   and5 Cla5_3( .A(Pbus[4]), .B(Pbus[3]), .C(Pbus[2]), .D(Pbus[1]),
		.E(Gbus[0]), .Y(line3) );
   or5 Cla5_4( .A(Gbus[4]), .B(line0), .C(line1), .D(line2),
	       .E(line3), .Y(OutCarry) );

endmodule // CLACarry5_Cin0



/***************************************************************************
 * module: MuxSpecY
 * 
 * Function: generate buses Ybus, Wbus, Qbus, Rbus and Sbus.
 * There are 2:1 muxes to generate Ybus from Y1bus, Y2bus and Y3bus.
 * The other output buses are fanouts of Y1bus, Y2bus, Y3bus and ParTreeIns.
 * (Note: The parities of Qbus, Rbus and Sbus are computed in
 * ParityChecker.)
 * 
***************************************************************************/

module MuxSpecY( Y1bus, Y2bus, Y3bus, ContAlpha, ParTreeIns,
		 Ybus, Wbus, Qbus, Rbus, Sbus);

   input [5:0]	  Y1bus, Y2bus;
   input [3:0]	  Y3bus;
   input		  ContAlpha;
   input [11:0]  ParTreeIns;
   output [11:0] Ybus;
   output [16:0] Wbus;
   output [9:0]  Qbus, Rbus, Sbus;

   wire [5:0]	  Not_Y1bus, Not_Y2bus;
   wire [3:0]	  Not_Y3bus;

   Invert6 UM5_0( Y1bus, Not_Y1bus ),
           UM5_1( Y2bus, Not_Y2bus );

   Mux6bit_2_1 UM5_2( Not_Y1bus, Not_Y2bus, ContAlpha, Ybus[5:0] );
   
   Invert4 UM5_3( Y3bus, Not_Y3bus );

   assign
      Ybus[9:6]    = Not_Y3bus[3:0],
      Ybus[11:10]  = Not_Y2bus[1:0];

   assign
      Wbus[5:0]   = Y1bus[5:0],
      Wbus[9:6]   = Y3bus[3:0],
      Wbus[15:10] = Y2bus[5:0],
      Wbus[16]    = 1'b0;

   assign
      Qbus[3:0] = Y1bus[5:2],
      Qbus[7:4] = Y3bus[3:0],
      Qbus[8]   = Y2bus[0],
      Qbus[9]   = ParTreeIns[0];

   assign
      Rbus[1:0] = Y1bus[1:0],
      Rbus[9:2] = ParTreeIns[8:1];

   assign
      Sbus[4:0] = Y2bus[5:1],
      Sbus[7:5] = ParTreeIns[11:9],
      Sbus[8]   = 1'b0,
      Sbus[9]   = 1'b0;

endmodule // MuxSpecY

/******************************************************/

module Invert6( Inbus, Outbus );

   input [5:0]	 Inbus;
   output [5:0] Outbus;

   inv Inv6_0( .A(Inbus[0]), .Y(Outbus[0]) ),
       Inv6_1( .A(Inbus[1]), .Y(Outbus[1]) ),
       Inv6_2( .A(Inbus[2]), .Y(Outbus[2]) ),
       Inv6_3( .A(Inbus[3]), .Y(Outbus[3]) ),
       Inv6_4( .A(Inbus[4]), .Y(Outbus[4]) ),
       Inv6_5( .A(Inbus[5]), .Y(Outbus[5]) );
   
endmodule // Invert6

/******************************************************/

module Invert4( Inbus, Outbus );

   input [3:0]	 Inbus;
   output [3:0] Outbus;

   inv Inv4_0( .A(Inbus[0]), .Y(Outbus[0]) ),
       Inv4_1( .A(Inbus[1]), .Y(Outbus[1]) ),
       Inv4_2( .A(Inbus[2]), .Y(Outbus[2]) ),
       Inv4_3( .A(Inbus[3]), .Y(Outbus[3]) );
   
endmodule // Invert4

/******************************************************/

module Mux2_1( In1, In2, ContIn, Out );

   input	In1, In2, ContIn;
   output	Out;

   inv Mux0( .A(ContIn), .Y(Not_ContIn) );
   and2 Mux1( .A(In1), .B(Not_ContIn), .Y(line1) ),
       Mux2( .A(In2), .B(ContIn), .Y(line2) );
   or2 Mux3( .A(line1), .B(line2), .Y(Out) );
   
endmodule

/******************************************************/

module Mux6bit_2_1( In1bus, In2bus, ContIn, Outbus );

   input [5:0]	 In1bus, In2bus;
   input		 ContIn;
   output [5:0] Outbus;

   Mux2_1 Mux6_0( In1bus[0], In2bus[0], ContIn, Outbus[0] ),
          Mux6_1( In1bus[1], In2bus[1], ContIn, Outbus[1] ),
          Mux6_2( In1bus[2], In2bus[2], ContIn, Outbus[2] ),
          Mux6_3( In1bus[3], In2bus[3], ContIn, Outbus[3] ),
          Mux6_4( In1bus[4], In2bus[4], ContIn, Outbus[4] ),
          Mux6_5( In1bus[5], In2bus[5], ContIn, Outbus[5] );
   
endmodule // Mux6bit_2_1


/***************************************************************************
 * module: MuxSpecZ
 * 
 * Function: generate Zbus from (Z1bus,V1bus) and (Z2bus,V2bus).
 * (Note: V1bus is essentially Abus, and V2bus is Bbus.)
 * 
***************************************************************************/

module MuxSpecZ( Z1bus, Z2bus, V1bus, V2bus, ContZ0, ContZ1, Zbus);

   input [8:0]	  Z1bus, V1bus;
   input [7:0]	  Z2bus, V2bus;
   input		  ContZ0, ContZ1;
   output [16:0] Zbus;

   Mux9bit_2_1 UM6_0( Z1bus, V1bus, ContZ0, Zbus[8:0] );

   Mux8bit_2_1 UM6_1( Z2bus, V2bus, ContZ1, Zbus[16:9] );
   
endmodule // MuxSpecZ

/******************************************************/

module Mux9bit_2_1( In1bus, In2bus, ContIn, Outbus );

   input [8:0]	 In1bus, In2bus;
   input		 ContIn;
   output [8:0] Outbus;

   Mux2_1 Mux9_0( In1bus[0], In2bus[0], ContIn, Outbus[0] ),
          Mux9_1( In1bus[1], In2bus[1], ContIn, Outbus[1] ),
          Mux9_2( In1bus[2], In2bus[2], ContIn, Outbus[2] ),
          Mux9_3( In1bus[3], In2bus[3], ContIn, Outbus[3] ),
          Mux9_4( In1bus[4], In2bus[4], ContIn, Outbus[4] ),
          Mux9_5( In1bus[5], In2bus[5], ContIn, Outbus[5] ),
          Mux9_6( In1bus[6], In2bus[6], ContIn, Outbus[6] ),
          Mux9_7( In1bus[7], In2bus[7], ContIn, Outbus[7] ),
          Mux9_8( In1bus[8], In2bus[8], ContIn, Outbus[8] );
   
endmodule // Mux9bit_2_1

/******************************************************/

module Mux8bit_2_1( In1bus, In2bus, ContIn, Outbus );

   input [7:0]	 In1bus, In2bus;
   input		 ContIn;
   output [7:0] Outbus;

   Mux2_1 Mux8_0( In1bus[0], In2bus[0], ContIn, Outbus[0] ),
          Mux8_1( In1bus[1], In2bus[1], ContIn, Outbus[1] ),
          Mux8_2( In1bus[2], In2bus[2], ContIn, Outbus[2] ),
          Mux8_3( In1bus[3], In2bus[3], ContIn, Outbus[3] ),
          Mux8_4( In1bus[4], In2bus[4], ContIn, Outbus[4] ),
          Mux8_5( In1bus[5], In2bus[5], ContIn, Outbus[5] ),
          Mux8_6( In1bus[6], In2bus[6], ContIn, Outbus[6] ),
          Mux8_7( In1bus[7], In2bus[7], ContIn, Outbus[7] );

endmodule // Mux8bit_2_1

/***************************************************************************
 * module: EqualZ_W
 * 
 * Function: compute OutZequalW = (Zbus=Wbus)
 * 
***************************************************************************/

module EqualZ_W( Zbus, Wbus, ContEq, OutZequalW, OutNot_ZequalW );

   input [16:0] Zbus, Wbus;
   input		 ContEq;
   output		 OutZequalW, OutNot_ZequalW;

   wire [16:0]	 XorZW;

   Xor17bit UM7_0( Zbus, Wbus, XorZW );

   AN18     UM7_1( XorZW, ContEq, OutNot_ZequalW );
   inv      UM7_2( .A(OutNot_ZequalW), .Y(OutZequalW) );

endmodule

/********************************************/

module Xor17bit( Zbus, Wbus, XorZW );

   input [16:0]  Zbus, Wbus;
   output [16:0] XorZW;

   XOR2a Xr0( .A(Zbus[0]), .B(Wbus[0]), .Y(XorZW[0]) ),
         Xr1( .A(Zbus[1]), .B(Wbus[1]), .Y(XorZW[1]) ),
         Xr2( .A(Zbus[2]), .B(Wbus[2]), .Y(XorZW[2]) ),
         Xr3( .A(Zbus[3]), .B(Wbus[3]), .Y(XorZW[3]) ),
         Xr4( .A(Zbus[4]), .B(Wbus[4]), .Y(XorZW[4]) ),
         Xr5( .A(Zbus[5]), .B(Wbus[5]), .Y(XorZW[5]) ),
         Xr6( .A(Zbus[6]), .B(Wbus[6]), .Y(XorZW[6]) ),
         Xr7( .A(Zbus[7]), .B(Wbus[7]), .Y(XorZW[7]) ),
         Xr8( .A(Zbus[8]), .B(Wbus[8]), .Y(XorZW[8]) ),
         Xr9( .A(Zbus[9]), .B(Wbus[9]), .Y(XorZW[9]) ),
         Xr10( .A(Zbus[10]), .B(Wbus[10]), .Y(XorZW[10]) ),
         Xr11( .A(Zbus[11]), .B(Wbus[11]), .Y(XorZW[11]) ),
         Xr12( .A(Zbus[12]), .B(Wbus[12]), .Y(XorZW[12]) ),
         Xr13( .A(Zbus[13]), .B(Wbus[13]), .Y(XorZW[13]) ),
         Xr14( .A(Zbus[14]), .B(Wbus[14]), .Y(XorZW[14]) ),
         Xr15( .A(Zbus[15]), .B(Wbus[15]), .Y(XorZW[15]) ),
         Xr16( .A(Zbus[16]), .B(Wbus[16]), .Y(XorZW[16]) );

endmodule // Xor17bit


/***************************************************************************
 * module: ParityChecker
 * 
 * Function: This module ANDs various bus parities and control signals
 * including the output of xor of the CLAs (CompCLAs).
 * The buses whose parities are ANDed are Abus, Bbus, Qbus, Rbus and Sbus.
 * Another control signal called Lambda is computed by SmallCircuitLambda.
 * 
***************************************************************************/

module ParityChecker( Abus, Bbus, Qbus, Rbus, Sbus, CompCLAs,
		      ContPar0, ContPar1, ContPar2, ContPar3, InTbus,
		      OutParCheck, OutNot_ParCheck, ParChkOuts, OutTbus );

   input [9:0]	 Abus, Bbus;
   input [9:0]	 Qbus, Rbus, Sbus;
   input		 CompCLAs, ContPar0, ContPar1, ContPar2, ContPar3;
   input [7:0]	 InTbus;
   output	 OutParCheck, OutNot_ParCheck;
   output [7:0] ParChkOuts;
   output [7:0] OutTbus;
   wire		 ParA, ParB, ParP, ParQ, ParR;
   wire Lambda;


   SmallCircuitLambda UM8_0( InTbus, ContPar2, ContPar3, OutTbus, ParChkOuts[7:5] );
   assign Lambda = ParChkOuts[5];

   ParityTree10bit UM8_1( Abus, ParA ),
                   UM8_2( Bbus, ParB ),
                   UM8_3( Qbus, ParQ ),
                   UM8_4( Rbus, ParR ),
                   UM8_5( Sbus, ParS );

   inv UM8_6( .A(ContPar0), .Y(NotPar0) );
   or2 UM8_7( .A(ParA), .B(ContPar1), .Y(line7) ),
       UM8_8( .A(ParB), .B(ContPar1), .Y(line8) ),
       UM8_9( .A(ParR), .B(NotPar0), .Y(line9) );

   and3 UM8_10( .A(line8),  .B(line7),  .C(ParS),     .Y(line10) ),
       UM8_11( .A(ParQ),   .B(line9),  .C(CompCLAs), .Y(line11) ),
       UM8_12( .A(line10), .B(line11), .C(Lambda),   .Y(OutParCheck) );
   
   inv UM8_13( .A(OutParCheck), .Y(OutNot_ParCheck) ),
       UM8_14( .A(line8), .Y(ParChkOuts[0]) ),
       UM8_15( .A(line7), .Y(ParChkOuts[1]) ),
       UM8_16( .A(ParS), .Y(ParChkOuts[2]) ),
       UM8_17( .A(ParQ), .Y(ParChkOuts[3]) ),
       UM8_18( .A(line9), .Y(ParChkOuts[4]) );

endmodule // ParityChecker

/********************************************/

module SmallCircuitLambda( InTbus, ContPar2, ContPar3, OutTbus, ParChkOuts7_5 );

   input [7:0]	 InTbus;
   input		 ContPar2, ContPar3;
   output [7:0] OutTbus;
   output [2:0] ParChkOuts7_5;

   and4 SCL0( .A(InTbus[0]), .B(InTbus[1]), .C(InTbus[2]),
	      .D(InTbus[3]), .Y(line0) ),
       SCL1( .A(InTbus[4]), .B(InTbus[5]), .C(InTbus[6]),
	     .D(InTbus[7]), .Y(line1) );
   and2 SCL2( .A(line0), .B(line1), .Y(ParChkOuts7_5[1]) );
   inv SCL3( .A(ParChkOuts7_5[1]), .Y(ParChkOuts7_5[2]) );

   inv SCL4( .A(ContPar2), .Y(NotPar2) ),
       SCL5( .A(ContPar3), .Y(NotPar3) );
   or2 SCL6( .A(NotPar2), .B(line0), .Y(line6) ),
       SCL7( .A(NotPar3), .B(line1), .Y(line7) );
   and2 SCL8( .A(line6), .B(line7), .Y(ParChkOuts7_5[0]) );

   inv SCL9( .A(InTbus[0]), .Y(OutTbus[0]) ),
       SCL10( .A(InTbus[1]), .Y(OutTbus[1]) ),
       SCL11( .A(InTbus[2]), .Y(OutTbus[2]) ),
       SCL12( .A(InTbus[3]), .Y(OutTbus[3]) ),
       SCL13( .A(InTbus[4]), .Y(OutTbus[4]) ),
       SCL14( .A(InTbus[5]), .Y(OutTbus[5]) ),
       SCL15( .A(InTbus[6]), .Y(OutTbus[6]) ),
       SCL16( .A(InTbus[7]), .Y(OutTbus[7]) );

endmodule // SmallCircuitLambda

/********************************************/

module ParityTree10bit( Inbus, ParOut );

   input [9:0]	Inbus;
   output		ParOut;

   XOR2a PT0( .A(Inbus[0]), .B(Inbus[1]), .Y(line0) ),
         PT1( .A(Inbus[2]), .B(Inbus[3]), .Y(line1) ),
         PT2( .A(Inbus[4]), .B(Inbus[5]), .Y(line2) ),
         PT3( .A(Inbus[6]), .B(Inbus[7]), .Y(line3) ),
         PT4( .A(Inbus[8]), .B(Inbus[9]), .Y(line4) );

   XOR3a PT5( .A(line0), .B(line1), .C(line2), .Y(line5) );
   XOR2a PT6( .A(line3), .B(line4), .Y(line6) );
   XOR2a PT7( .A(line5), .B(line6), .Y(ParOut) );
   
endmodule // ParityTree10bit


/***************************************************************************
 * module: MiscLogic
 * 
 * Function: mostly a random circuit.
 * Three major parts are 1) muxes fed by Abus, 2) buses (with buf and inv)
 * 3) a few random gates.
 * 
****************************************************************************/

module MiscLogic( Abus, Bbus, Y2bus, ParTreeIns, MiscRandomIns, ContPar2, ContPar3,
		  MiscMuxIn, MiscMuxCont0, MiscMuxCont1, Lambda,
		  MiscMuxOuts, MiscBusOuts, MiscRandomOuts );

   input [9:0]	 Abus, Bbus;
   input [5:0]	 Y2bus;
   input [11:0]  ParTreeIns;
   input [11:0]	 MiscRandomIns;
   input	 ContPar2, ContPar3;
   input	 MiscMuxIn, MiscMuxCont0, MiscMuxCont1, Lambda;
   output [10:0] MiscMuxOuts;
   output [12:0] MiscBusOuts;
   output [17:0] MiscRandomOuts;

   MiscMuxCircuit UM9_0( Abus, MiscMuxIn, MiscMuxCont0, MiscMuxCont1, MiscMuxOuts);

   MiscBusCircuit UM9_1( Abus, Bbus, MiscBusOuts);

   MiscRandomCircuit UM9_2( Bbus, Y2bus, ParTreeIns, MiscRandomIns,
			    ContPar2, ContPar3, Lambda, MiscRandomOuts );
  
endmodule // MiscLogic

/********************************************/

module MiscMuxCircuit( Abus, MiscMuxIn, MiscMuxCont0, MiscMuxCont1, MiscMuxOuts);

   input [9:0]	  Abus;
   input		  MiscMuxIn, MiscMuxCont0, MiscMuxCont1;
   output [10:0] MiscMuxOuts;

   wire [9:0]	  NewAbus;
   wire		  ParNewA;

   assign
	 NewAbus[2:0] = Abus[2:0],
      NewAbus[7:3] = Abus[9:5],
      NewAbus[8] = 1'b0;

   or2 MMC0( .A(Abus[1]), .B(MiscMuxIn), .Y(NewAbus[9]) );
   
   ParityTree10bit PTMuxA( NewAbus, ParNewA );

   Mux2_1 MMC2( Abus[9], ParNewA, MiscMuxCont0, MiscMuxOuts[0] ),
          MMC3( Abus[0], NewAbus[9], MiscMuxCont0, MiscMuxOuts[1] ),
          MMC4( Abus[1], Abus[3], MiscMuxCont0, MiscMuxOuts[2] ),
          MMC5( Abus[2], Abus[4], MiscMuxCont0, MiscMuxOuts[3] );

   inv    MMC6( .A(NewAbus[9]), .Y(NotNewA9) );
   XOR2a  MMC7( .A(Abus[0]), .B(Abus[1]), .Y(line7) ),
          MMC8( .A(line7), .B(NotNewA9), .Y(line8) ),
          MMC9( .A(line8), .B(Abus[9]), .Y(line9) );
   
   Mux2_1 MMC10( line9, Abus[9], MiscMuxCont1, MiscMuxOuts[4] ),
          MMC11( NewAbus[9], Abus[1], MiscMuxCont1, MiscMuxOuts[5] ),
          MMC12( 1'b1, Abus[0], MiscMuxCont1, MiscMuxOuts[6] );

   assign
      MiscMuxOuts[7] =  MiscMuxOuts[0],
      MiscMuxOuts[8] =  MiscMuxOuts[1],
      MiscMuxOuts[9] =  MiscMuxOuts[2],
      MiscMuxOuts[10] = MiscMuxOuts[3];

endmodule // MiscMuxCircuit

/********************************************/

module MiscBusCircuit( Abus, Bbus, MiscBusOuts);

   input [9:0]	  Abus, Bbus;
   output [12:0] MiscBusOuts;

   buffer MBC0( .A(Abus[8]), .Y(MiscBusOuts[0]) ),
         MBC1( .A(Abus[7]), .Y(MiscBusOuts[1]) ),
         MBC2( .A(Abus[6]), .Y(MiscBusOuts[2]) ),
         MBC3( .A(Abus[5]), .Y(MiscBusOuts[3]) ),
         MBC4( .A(Abus[4]), .Y(MiscBusOuts[4]) ),
         MBC5( .A(Abus[3]), .Y(MiscBusOuts[5]) ),
         MBC6( .A(Abus[2]), .Y(MiscBusOuts[6]) );

   inv   MBC7( .A(Abus[5]), .Y(MiscBusOuts[7]) ),
         MBC8( .A(Abus[4]), .Y(MiscBusOuts[8]) ),
         MBC9( .A(Abus[3]), .Y(MiscBusOuts[9]) );

   inv   MBC10( .A(Bbus[6]), .Y(MiscBusOuts[10]) ),
         MBC11( .A(Bbus[5]), .Y(MiscBusOuts[11]) ),
         MBC12( .A(Bbus[4]), .Y(MiscBusOuts[12]) );
   
endmodule // MiscBusCircuit

/********************************************/

module MiscRandomCircuit( Bbus, Y2bus, ParTreeIns, MiscRandomIns,
			  ContPar2, ContPar3, Lambda, MiscRandomOuts );

   input [9:0]	 Bbus;
   input [5:0]	 Y2bus;
   input [11:0]  ParTreeIns;
   input [11:0]	 MiscRandomIns;
   input	 ContPar2, ContPar3;
   input	 Lambda;
   output [17:0] MiscRandomOuts;


   buffer MRC0( .A(MiscRandomIns[0]), .Y(MiscRandomOuts[0]) ),
          MRC1( .A(MiscRandomIns[0]), .Y(MiscRandomOuts[1]) ),
          MRC2( .A(MiscRandomIns[0]), .Y(MiscRandomOuts[2]) ),
          MRC3( .A(MiscRandomIns[0]), .Y(MiscRandomOuts[3]) ),
          MRC4( .A(MiscRandomIns[1]), .Y(MiscRandomOuts[4]) ),
          MRC5( .A(MiscRandomIns[1]), .Y(MiscRandomOuts[5]) ),
          MRC6( .A(MiscRandomIns[1]), .Y(MiscRandomOuts[6]) ),
          MRC7( .A(MiscRandomIns[2]), .Y(MiscRandomOuts[7]) ),
          MRC8( .A(MiscRandomIns[2]), .Y(MiscRandomOuts[8]) );
   and2   MRC9( .A(MiscRandomIns[0]), .B(MiscRandomIns[3]),
		.Y(MiscRandomOuts[9]) );

   inv          MRC10( .A(ParTreeIns[10]), .Y(NotPTIns10) ),
                MRC11( .A(ParTreeIns[11]), .Y(NotPTIns11) );
   XOR2b        MRC12( .A(Bbus[9]), .B(NotPTIns10), .Y(line12) ),
                MRC13( .A(Bbus[7]), .B(NotPTIns11), .Y(line13) );
   RedundantInv MRC14( .A(line12), .Y(line14) ),
                MRC15( .A(line13), .Y(line15) );
   nand2        MRC16( .A(line14), .B(line15), .Y(MiscRandomOuts[10]) );

   and2   MRC17( .A(MiscRandomIns[4]), .B(MiscRandomIns[5]), .Y(line17) );
   inv    MRC18( .A(line17), .Y(MiscRandomOuts[11]) );
   and2   MRC19( .A(ContPar2), .B(line17), .Y(line19) );
   inv    MRC20( .A(line19), .Y(MiscRandomOuts[12]) );
   nand2  MRC21( .A(ContPar3), .B(line17), .Y(MiscRandomOuts[13]) );
   and3   MRC22( .A(MiscRandomIns[6]), .B(MiscRandomIns[7]),
		 .C(MiscRandomIns[5]), .Y(line22) );
   inv    MRC23( .A(line22), .Y(MiscRandomOuts[14]) );
   and4   MRC24( .A(MiscRandomIns[5]), .B(MiscRandomIns[9]), .C(MiscRandomIns[8]),
		 .D(Lambda), .Y(line24) );
   inv    MRC25( .A(line24), .Y(MiscRandomOuts[15]) );
   and2   MRC26( .A(MiscRandomIns[10]), .B(MiscRandomIns[11]), .Y(line26) );
   inv    MRC27( .A(line26), .Y(line27) );
   and4   MRC28( .A(MiscRandomIns[5]), .B(MiscRandomIns[9]), .C(Lambda),
		 .D(line27), .Y(line28) );
   inv    MRC29( .A(line28), .Y(MiscRandomOuts[16]) );

   and4   MRC30( .A(Y2bus[2]), .B(Y2bus[3]), .C(Y2bus[4]), .D(Y2bus[5]),
		 .Y(line30) );
   inv    MRC31( .A(line30), .Y(MiscRandomOuts[17]) );

endmodule // MiscRandomCircuit


/***************************************************************************/
/***************************************************************************/

module AN18( Inbus, ContEq, Out );

   input [16:0]	Inbus;
   input	ContEq;
   output	Out;

   and5 A0( .A(Inbus[0]), .B(Inbus[1]), .C(Inbus[2]),
	    .D(Inbus[3]), .E(Inbus[4]), .Y(line0) ),
        A1( .A(Inbus[5]), .B(Inbus[6]), .C(Inbus[7]),
	    .D(Inbus[8]), .E(Inbus[9]), .Y(line1) );
   and2 A2( .A(line0), .B(line1) ,.Y(line2) ),
        A3( .A(Inbus[10]), .B(Inbus[11]), .Y(line3) );
   and5 A4( .A(Inbus[12]), .B(Inbus[13]), .C(Inbus[14]),
	    .D(Inbus[15]), .E(Inbus[16]), .Y(line4) );
   and2 A5( .A(line3), .B(line4), .Y(line5) );
   and3 A6( .A(line2), .B(line5), .C(ContEq), .Y(Out) );   
   
endmodule // AN18

/********************************************/

module XOR2a ( A, B, Y );

   input	A, B;
   output	Y;

   inv Xo0( .A(A), .Y(NotA) ),
       Xo1( .A(B), .Y(NotB) );
   
   nand2  Xo2( .A(NotA), .B(B), .Y(line2) ),
       Xo3( .A(NotB), .B(A), .Y(line3) ),
       Xo4( .A(line2), .B(line3), .Y(Y) );
   
endmodule // XOR2a


/********************************************/

module XOR2b ( A, B, Y );  

   input	A, B;
   output	Y;

   wire	NotAB;
   
   nand2  Xo1_0( .A(A), .B(B), .Y(NotAB) );
   
   and2 Xo1_1( .A(A), .B(NotAB), .Y(line1) ),
        Xo1_2( .A(NotAB), .B(B), .Y(line2) );
   or2  Xo1_3( .A(line1), .B(line2), .Y(Y) );
   
endmodule // XOR2b

/********************************************/

module XOR3a( A, B, C, Y);

   input	A, B, C;
   output	Y;
   
   inv Xo3_0( .A(A), .Y(NotA) ),
       Xo3_1( .A(B), .Y(NotB) ),
       Xo3_2( .A(C), .Y(NotC) );
   and3 Xo3_3( .A(NotA), .B(NotB), .C(C), .Y(line3) ),
	Xo3_4( .A(NotA), .B(B), .C(NotC), .Y(line4) ),
	Xo3_5( .A(A), .B(NotB), .C(NotC), .Y(line5) ),
        Xo3_6( .A(A), .B(B), .C(C), .Y(line6) );
   nor2 Xo3_7( .A(line3), .B(line4), .Y(line7) ),
        Xo3_8( .A(line5), .B(line6), .Y(line8) );
   nand2  Xo3_9( .A(line7), .B(line8), .Y(Y) );

endmodule // XOR3a

/********************************************/

module RedundantInv( A, Y );

   input	A;
   output	Y;
   
   inv RIV0( .A(A), .Y(NotA) );
   and2 RIV1( .A(A), .B(NotA), .Y(line1) );     // line1=logic 0
   or2 RIV2( .A(line1), .B(NotA), .Y(Y) );

endmodule // RedundantIV
