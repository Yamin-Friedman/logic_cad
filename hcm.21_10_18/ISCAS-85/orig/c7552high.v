/****************************************************************************
 *                                                                          *
 *  VERILOG HIGH-LEVEL DESCRIPTION OF THE ISCAS-85 BENCHMARK CIRCUIT c7552  *
 *                                                                          *  
 *                                                                          *
 *  Written by   : Hakan Yalcin (hyalcin@cadence.com)                       *
 *  Verified by  : Jonathan David Hauke (jhauke@eecs.umich.edu)             *
 *                                                                          *
 *  First created: Jan 21, 1997                                             *
 *  Last modified: Oct 20, 1998                                             *
 *                                                                          *
****************************************************************************/

module Circuit7552(
        in213, in214, in215, in216, in209, in153, in154, 
        in155, in156, in157, in158, in159, in160, in151, in219, 
        in220, in221, in222, in223, in224, in225, in226, in217, 
        in231, in232, in233, in234, in235, in236, in237, in238, 
        in135, in144, in138, in147, in66, in50, in32, in35, 
        in47, in121, in94, in97, in118, in100, in124, in127, 
        in130, in103, in23, in26, in29, in41, in1486, in1480, 
        in106, in1469, in1462, in2256, in2253, in2247, in2239, in2236, 
        in2230, in2224, in2218, in2211, in4437, in4432, in4427, in4420, 
        in4415, in4410, in4405, in4400, in4394, in3749, in3743, in3737, 
        in3729, in3723, in3717, in3711, in3705, in88, in112, in87, 
        in111, in113, in110, in109, in86, in63, in64, in85, 
        in84, in83, in65, in62, in61, in60, in79, in80, 
        in81, in59, in78, in77, in56, in55, in54, in53, 
        in73, in75, in76, in74, in166, in167, in168, in169, 
        in173, in174, in175, in176, in177, in178, in179, in180, 
        in171, in189, in190, in191, in192, in193, in194, in195, 
        in196, in187, in200, in201, in202, in203, in204, in205, 
        in206, in207, in18, in12, in9, in4526, in89, in38, 
        in4528, in211, in212, in161, in227, in239, in229, in141, 
        in115, in44, in1459, in1496, in1492, in2208, in4393, in3701, 
        in3698, in114, in2204, in1455, in82, in58, in70, in69, 
        in170, in164, in165, in181, in197, in208, in198, in199, 
        in188, in172, in162, in186, in185, in182, in183, in230, 
        in218, in152, in210, in240, in228, in184, in150, in1, 
        in163, in15, in1197, in134, in133, in5, in57, in339,
        out469, out471, out327, out330, out333, out336, out324, 
        out298, out301, out304, out307, out310, out313, out316, out319, 
        out295, out347, out350, out353, out356, out359, out362, out365, 
        out368, out344, out376, out379, out382, out385, out388, out391, 
        out394, out397, out373, out419, out422, out270, out246, out273, 
        out276, out258, out264, out249, out252, out338, out321, out370, 
        out399, out416, out414, out412, out418, out410, out408, out406, 
        out404, out440, out438, out442, out444, out446, out448, out436, 
        out480, out482, out484, out486, out488, out490, out492, out494, 
        out478, out524, out526, out528, out530, out532, out534, out536, 
        out538, out522, out544, out546, out548, out550, out552, out554, 
        out556, out558, out542, out450, out496, out540, out560, out402, 
        out289, out292, out279, out278, out2, out3, out432, out453, 
        out286, out341, out281, out284, out339);
 
   input
        in213, in214, in215, in216, in209, in153, in154, 
        in155, in156, in157, in158, in159, in160, in151, in219, 
        in220, in221, in222, in223, in224, in225, in226, in217, 
        in231, in232, in233, in234, in235, in236, in237, in238, 
        in135, in144, in138, in147, in66, in50, in32, in35, 
        in47, in121, in94, in97, in118, in100, in124, in127, 
        in130, in103, in23, in26, in29, in41, in1486, in1480, 
        in106, in1469, in1462, in2256, in2253, in2247, in2239, in2236, 
        in2230, in2224, in2218, in2211, in4437, in4432, in4427, in4420, 
        in4415, in4410, in4405, in4400, in4394, in3749, in3743, in3737, 
        in3729, in3723, in3717, in3711, in3705, in88, in112, in87, 
        in111, in113, in110, in109, in86, in63, in64, in85, 
        in84, in83, in65, in62, in61, in60, in79, in80, 
        in81, in59, in78, in77, in56, in55, in54, in53, 
        in73, in75, in76, in74, in166, in167, in168, in169, 
        in173, in174, in175, in176, in177, in178, in179, in180, 
        in171, in189, in190, in191, in192, in193, in194, in195, 
        in196, in187, in200, in201, in202, in203, in204, in205, 
        in206, in207, in18, in12, in9, in4526, in89, in38, 
        in4528, in211, in212, in161, in227, in239, in229, in141, 
        in115, in44, in1459, in1496, in1492, in2208, in4393, in3701, 
        in3698, in114, in2204, in1455, in82, in58, in70, in69, 
        in170, in164, in165, in181, in197, in208, in198, in199, 
        in188, in172, in162, in186, in185, in182, in183, in230, 
        in218, in152, in210, in240, in228, in184, in150, in1, 
        in163, in15, in1197, in134, in133, in5, in57, in339;
 
   output
        out469, out471, out327, out330, out333, out336, out324, 
        out298, out301, out304, out307, out310, out313, out316, out319, 
        out295, out347, out350, out353, out356, out359, out362, out365, 
        out368, out344, out376, out379, out382, out385, out388, out391, 
        out394, out397, out373, out419, out422, out270, out246, out273, 
        out276, out258, out264, out249, out252, out338, out321, out370, 
        out399, out416, out414, out412, out418, out410, out408, out406, 
        out404, out440, out438, out442, out444, out446, out448, out436, 
        out480, out482, out484, out486, out488, out490, out492, out494, 
        out478, out524, out526, out528, out530, out532, out534, out536, 
        out538, out522, out544, out546, out548, out550, out552, out554, 
        out556, out558, out542, out450, out496, out540, out560, out402, 
        out289, out292, out279, out278, out2, out3, out432, out453, 
        out286, out341, out281, out284, out339;


   /*******************************/
   wire VDD, GND;
   assign
     VDD = 1'b1,
     GND = 1'b0;

   wire [31:0] XA0bus, XA1bus;
   wire [31:0] YA1bus;
   wire [33:0] XBbus, YB0bus;
   wire	       CinX, CinY;
   wire	       NotMuxSel, ContBusMask0, ContBusMask1;
   wire	       XYAext, XYBext;

   wire [33:0] SumXbus;
   wire [3:0]  NotSumParbus;
   wire	       CoutX1, CoutX2;
   wire	       CoutY1, CoutY2, CoutY_17;
   wire [6:0]  PCXA0bus, PCXA1bus, PCYA0bus, PCYA1bus, PCYB0bus;
   wire [3:0]  ParCheck;
   wire [33:0] XBbufbus;
   wire [3:0]  PCYA0bufbus;
   wire [15:0] StrobeInbus;
   wire [3:0]  Not_StrobeOutbus;
   wire [7:0]  MiscInbus;
   wire [5:0]  MiscOutbus;

   /*******************************/   

// in229 is a redundant input for XA0bus[0]
   assign
      XA0bus[31:0] = { in213, in214, in215, in216, in209, in153, in154,
		       in155, in156, in157, in158, in159, in160, in151,
		       in219, in220, in221, in222, in223, in224, in225,
		       in226, in217, in231, in232, in233, in234, in235,
		       in236, in237, in238, GND };
   assign
      XA1bus[31:0] = { VDD, VDD, VDD, VDD, VDD, VDD, VDD, VDD, VDD, VDD,
		       in135, in144, in138, in147, in66, in50,
		       in32, in35, in47, in121, in94, in97, in118, in100,
		       in124, in127, in130, in103, in23, in26, in29, in41};

// a mux will be placed at bit 0 in module InvertXB
   assign
      XBbus[33:0] = { in1496, in1492,
		      in1486, in1480, in106,  in1469, in1462, in2256, in2253,
		      in2247, in2239, in2236, in2230, in2224, in2218, in2211,
		      in4437, in4432, in4427, in4420, in4415, in4410, in4405,
		      in4400, in4394, in3749, in3743, in3737, in3729, in3723,
		      in3717, in3711, in3705, in3701 };
   assign
      YA1bus[31:0] = { in88, in112, in87, in111, in113, in110, in109, in86,
		       in63, in64, in85, in84, in83, in65, in62, in61, in60,
		       in79, in80, in81, in59, in78, in77, in56, in55, in54,
		       in53, in73, in75, in76, in74, in70};
   assign
      YB0bus[33:0] = { in2204, in1455,
		       in166, in167, in168, in169, VDD,  in173, in174, in175,
		       in176, in177, in178, in179, in180, in171, in189, in190,
		       in191, in192, in193, in194, in195, in196, in187, in200,
		       in201, in202, in203, in204, in205, in206, in207, GND};
   assign NotMuxSel = in18;

   assign
      ContBusMask0 = in12, ContBusMask1 = in9;
   
   assign
      CinX = in4526, CinY = in89;

   assign
      XYAext = in38, XYBext = in4528;

   assign
      PCXA0bus[6:0] = { VDD, in211, in212, in161, in227, in239, in229 },
      PCXA1bus[6:0] = { VDD, VDD, VDD, in141, in115, in44, in41 },
      PCYA0bus[6:0] = { in1459, in1496, in1492, in2208, in4393, in3701, in3698 },
      PCYA1bus[6:0] = { in114, in2204, in1455, in82, in58, in70, in69 },
      PCYB0bus[6:0] = { in170, in164, in165, in181, in197, in208, in198 };
   
   assign
      StrobeInbus[15:0] = { in199, in188, in172, in162, in186, in185,
			    in182, in183, in230, in218, in152, in210,
			    in240, in228, in184, in150 };
   assign
      MiscInbus[7:0] = { in57 , in5, in133, in134, in1197, in15, in163, in1 };


// outputs

   assign
      { out469, out471, out327, out330, out333, out336,
	out324, out298, out301, out304, out307, out310,
	out313, out316, out319, out295, out347, out350,
	out353, out356, out359, out362, out365, out368,
	out344, out376, out379, out382, out385, out388,
	out391, out394, out397, out373} = SumXbus[33:0];

   assign out419 = SumXbus[32];    // identical to out471
   assign out422 = SumXbus[33];    // identical to out469

   assign out270 = CoutX1;
   assign out246 = CoutX1;         // identical to out270

   assign out273 = CoutX2;
   assign out276 = CoutX2;

   assign out258 = CoutY1;
   assign out264 = CoutY1;          // identical to out258

   assign out249 = CoutY2;
   assign out252 = CoutY_17;

   assign
      { out338, out321, out370, out399 } = NotSumParbus[3:0];

   assign
      { out416, out414, out412, out418 } = ParCheck[3:0];

   assign
      { out410, out408, out406, out404 } = Not_StrobeOutbus[3:0];

   assign
      { out438, out440, out442, out444, out446, out448,
	out436, out480, out482, out484, out486, out488,
	out490, out492, out494, out478, out524, out526,
	out528, out530, out532, out534, out536, out538,
	out522, out544, out546, out548, out550, out552,
	out554, out556, out558, out542 } = XBbufbus[33:0];
   assign
      { out450, out496, out540, out560 } = PCYA0bufbus[3:0];

   assign
      { out402, out289, out292, out279, out278, out2 } = MiscOutbus[5:0];

   // equivalents of MiscOutbus lines
   assign
      out3 = MiscOutbus[0],
      out432 = MiscOutbus[0],
      out453 = MiscOutbus[0],
      out286 = MiscOutbus[2],
      out341 = MiscOutbus[2],
      out281 = MiscOutbus[3],
      out284 = MiscOutbus[4];

   assign out339 = in339;    // this line goes straight through

   /* instantiate top level circuit */
   
   TopLevel7552 Ckt7552( XA0bus, XA1bus, XBbus, YA1bus, YB0bus,
			 NotMuxSel, ContBusMask0, ContBusMask1,
			 XYAext, XYBext, CinX, CinY, StrobeInbus,
			 PCXA0bus, PCXA1bus, PCYA0bus, PCYA1bus, PCYB0bus,

			 SumXbus, NotSumParbus, CoutX1, CoutX2,
			 CoutY1, CoutY2, CoutY_17, ParCheck, Not_StrobeOutbus,
			 XBbufbus, PCYA0bufbus, MiscInbus, MiscOutbus );
   
endmodule // Circuit7552


/***************************************************************************/
/***************************************************************************/

module TopLevel7552( XA0bus, XA1bus, XBbus, YA1bus, YB0bus,
		     NotMuxSel, ContBusMask0, ContBusMask1,
		     XYAext, XYBext, CinX, CinY, StrobeInbus,
		     PCXA0bus, PCXA1bus, PCYA0bus, PCYA1bus, PCYB0bus,
		     
		     SumXbus, NotSumParbus, CoutX1, CoutX2,
		     CoutY1, CoutY2, CoutY_17, ParCheck, Not_StrobeOutbus,
		     XBbufbus, PCYA0bufbus, MiscInbus, MiscOutbus );

   input [31:0]	 XA0bus, XA1bus, YA1bus;
   input [33:0]	 XBbus, YB0bus;
   input	 NotMuxSel, ContBusMask0, ContBusMask1;
   input	 XYAext, XYBext;
   input	 CinX, CinY;
   input [6:0]	 PCXA0bus, PCXA1bus, PCYA0bus, PCYA1bus, PCYB0bus;
   input [15:0]	 StrobeInbus;
   input [7:0]	 MiscInbus;

   output [33:0] SumXbus;
   output [3:0]	 NotSumParbus;
   output	 CoutX1, CoutX2, CoutY1, CoutY2, CoutY_17;
   output [3:0]	 ParCheck;
   output [3:0]	 Not_StrobeOutbus;
   output [33:0] XBbufbus;
   output [3:0]	 PCYA0bufbus;
   output [5:0]	 MiscOutbus;

   wire		 MuxSel;
   wire [33:0]	 XAbus, YAbus, YBbus, Not_XBbus;
   wire [31:0]	 YA0bus, YB1bus;
   wire [33:0]	 PropXbus, CarryXbus;
   wire [33:0]	 LocalCarryXCin0, LocalCarryXCin1;
   wire [3:0]	 PCYA0select;
   
   assign YB1bus[31:0] = XA1bus[31:0];

   nand2 M0( .A(ContBusMask0), .B(ContBusMask1), .Y(ContBusMask) );
   inv   M00( .A(NotMuxSel), .Y(MuxSel) );

// first input buses
   MuxBusXA M1( XA0bus, XA1bus, MuxSel, ContBusMask, XYAext, XAbus);
   InvertXB M2( XBbus, MuxSel, XYBext, Not_XBbus);

   assign
      YA0bus[0]    = 1'b1,
      YA0bus[31:1] = Not_XBbus[31:1];

   MuxBusYA M3( YA0bus, YA1bus, MuxSel, XYAext, YAbus);
   MuxBusYB M4( YB0bus, YB1bus, MuxSel, ContBusMask, XYBext, YBbus);

   // adder with inputs XA & XB
   AdderX34bit M5( XAbus, Not_XBbus, CinX, PropXbus,
		   LocalCarryXCin0, LocalCarryXCin1, CarryXbus, CoutX1, CoutX2);
   GenerateSumX M6( PropXbus, CinX, LocalCarryXCin0, LocalCarryXCin1, CarryXbus,
		    SumXbus );
   GenerateSumParity M7( PropXbus, CinX, LocalCarryXCin0, LocalCarryXCin1, CarryXbus,
			 NotSumParbus);

   // adder with inputs YA & YB
   AdderY34bit M8( YAbus, YBbus, CinY, CoutY1, CoutY2, CoutY_17 );


   ParityModule M9( XAbus, YAbus, YBbus, MuxSel, ContBusMask, StrobeInbus,
		    PCXA0bus, PCXA1bus, PCYA0bus, PCYA1bus, PCYB0bus,
		    ParCheck, Not_StrobeOutbus );   

   Buffer34 M10( XBbus, XBbufbus );

   assign PCYA0select[3:0] = { PCYA0bus[6],PCYA0bus[3],PCYA0bus[2],PCYA0bus[0] };
   Buffer4  M11( PCYA0select, PCYA0bufbus );


   // Misc. logic -- just a few gates
   MiscLogic M12( MiscInbus, MiscOutbus	);


endmodule // TopLevel7552

/***************************************************************************
 * Module: MuxBusXA
 * 
 * Function: generate (34-bit) XAbus from (32-bit) XA0bus and XA1bus
 *           - XAbus[31:21] can be masked via ContBusMask.
 *           - XAbus[33:32] are connected to XYAext.
 * 
 ***************************************************************************/

module MuxBusXA( XA0bus, XA1bus, MuxSel, ContBusMask, XYAext, XAbus);

   input [31:0]	 XA0bus, XA1bus;
   input	 MuxSel, ContBusMask, XYAext;
   output [33:0] XAbus;
   

   Mux_and_Mask32 UM1_0( XA0bus, XA1bus, MuxSel, ContBusMask, XAbus[31:0]);
   
   assign
      XAbus[32] = XYAext,
   XAbus[33] = XYAext;
   
endmodule // MuxBusXA

/******************************************************/

module Mux_and_Mask32( In1bus, In2bus, MuxSel, ContBusMask, Outbus);

   input [31:0]	 In1bus, In2bus;
   input	 MuxSel, ContBusMask;
   output [31:0] Outbus;

   wire [31:0]	 MuxOutbus;

   Mux32 MM0( In1bus, In2bus, MuxSel, MuxOutbus);
   
   assign Outbus[21:0] = MuxOutbus[21:0];

   and2 MM1( .A(MuxOutbus[22]), .B(ContBusMask), .Y(Outbus[22]) ),
        MM2( .A(MuxOutbus[23]), .B(ContBusMask), .Y(Outbus[23]) ),
        MM3( .A(MuxOutbus[24]), .B(ContBusMask), .Y(Outbus[24]) ),
        MM4( .A(MuxOutbus[25]), .B(ContBusMask), .Y(Outbus[25]) ),
        MM5( .A(MuxOutbus[26]), .B(ContBusMask), .Y(Outbus[26]) ),
        MM6( .A(MuxOutbus[27]), .B(ContBusMask), .Y(Outbus[27]) ),
        MM7( .A(MuxOutbus[28]), .B(ContBusMask), .Y(Outbus[28]) ),
        MM8( .A(MuxOutbus[29]), .B(ContBusMask), .Y(Outbus[29]) ),
        MM9( .A(MuxOutbus[30]), .B(ContBusMask), .Y(Outbus[30]) ),
        MM10( .A(MuxOutbus[31]), .B(ContBusMask), .Y(Outbus[31]) );

endmodule // Mux_and_Mask

/******************************************************/

module Mux32( In1bus, In2bus, MuxSel, Outbus);

   input [31:0]	 In1bus, In2bus;
   input	 MuxSel;
   output [31:0] Outbus;

   Mux8 Mux32_0( In1bus[7:0],   In2bus[7:0],   MuxSel, Outbus[7:0]   ),
        Mux32_1( In1bus[15:8],  In2bus[15:8],  MuxSel, Outbus[15:8]  ),
        Mux32_2( In1bus[23:16], In2bus[23:16], MuxSel, Outbus[23:16] ),
        Mux32_3( In1bus[31:24], In2bus[31:24], MuxSel, Outbus[31:24] );
   
endmodule // Mux32

/******************************************************/

module Mux8( In1bus, In2bus, MuxSel, Outbus);

   input [7:0]	In1bus, In2bus;
   input	MuxSel;
   output [7:0]	Outbus;

   Mux2_1 Mux8_0 ( In1bus[0], In2bus[0], MuxSel, Outbus[0]),
          Mux8_1 ( In1bus[1], In2bus[1], MuxSel, Outbus[1]),
          Mux8_2 ( In1bus[2], In2bus[2], MuxSel, Outbus[2]),
          Mux8_3 ( In1bus[3], In2bus[3], MuxSel, Outbus[3]),
          Mux8_4 ( In1bus[4], In2bus[4], MuxSel, Outbus[4]),
          Mux8_5 ( In1bus[5], In2bus[5], MuxSel, Outbus[5]),
          Mux8_6 ( In1bus[6], In2bus[6], MuxSel, Outbus[6]),
          Mux8_7 ( In1bus[7], In2bus[7], MuxSel, Outbus[7]);

endmodule // Mux8

/***************************************************************************
 * Module: InvertXB
 * 
 * Function: invert the 34-bit input bus XBbus. Output: Not_XBbus
 *           - Not_XBbus[0] is a mux with inputs XBbus[0] and logic 1.
 *           - Not_XBbus[33:32] can be masked via XYBext.
 * 
 ***************************************************************************/

module InvertXB( XBbus, MuxSel, XYBext, Not_XBbus);

   input [33:0]	 XBbus;
   input	 MuxSel, XYBext;
   output [33:0] Not_XBbus;

   wire [33:0]	 AuxXBbus;

   Mux2_1 UM2_0( 1'b0, XBbus[0], MuxSel, AuxXBbus[0] );

   assign AuxXBbus[31:1] = XBbus[31:1];

   and2 UM2_1( .A(XBbus[32]), .B(XYBext), .Y(AuxXBbus[32]) );
   and2 UM2_2( .A(XBbus[33]), .B(XYBext), .Y(AuxXBbus[33]) );
   
   Invert34 UM2_3( AuxXBbus, Not_XBbus);

endmodule // InvertXB

/******************************************************/

module Invert34( Inbus, Outbus );

   input [33:0]	 Inbus;
   output [33:0] Outbus;

   Invert8 Inv34_0( Inbus[7:0],   Outbus[7:0] ),
           Inv34_1( Inbus[15:8],  Outbus[15:8] ),
           Inv34_2( Inbus[23:16], Outbus[23:16] ),
           Inv34_3( Inbus[31:24], Outbus[31:24] );
   inv     Inv34_4( .A(Inbus[32]), .Y(Outbus[32]) ),
           Inv34_5( .A(Inbus[33]), .Y(Outbus[33]) );

endmodule // Invert34

/******************************************************/

module Invert8( Inbus, Outbus );

   input [7:0]	Inbus;
   output [7:0]	Outbus;

   inv Inv8_0( .A(Inbus[0]), .Y(Outbus[0]) ),
   Inv8_1( .A(Inbus[1]), .Y(Outbus[1]) ),
   Inv8_2( .A(Inbus[2]), .Y(Outbus[2]) ),
   Inv8_3( .A(Inbus[3]), .Y(Outbus[3]) ),
   Inv8_4( .A(Inbus[4]), .Y(Outbus[4]) ),
   Inv8_5( .A(Inbus[5]), .Y(Outbus[5]) ),
   Inv8_6( .A(Inbus[6]), .Y(Outbus[6]) ),
   Inv8_7( .A(Inbus[7]), .Y(Outbus[7]) );
   
endmodule // Invert8


/***************************************************************************
 * Module: MuxBusYA
 * 
 * Function: generate (34-bit) YAbus from (32-bit) YA0bus and YA1bus.
 *           - YAbus[33:32] are connected to XYAext.
 * 
 ***************************************************************************/

module MuxBusYA( YA0bus, YA1bus, MuxSel, XYAext, YAbus);

   input [31:0]	 YA0bus, YA1bus;
   input	 MuxSel, XYAext;
   output [33:0] YAbus;
   
   Mux32 UM3_0( YA0bus, YA1bus, MuxSel, YAbus[31:0]);
   
   assign
      YAbus[32] = XYAext,
      YAbus[33] = XYAext;
   
endmodule // MuxBusYA

/***************************************************************************
 * Module: MuxBusYB
 * 
 * Function: generate (34-bit) YBbus from (34-bit) YB0bus and (32-bit) YB1bus.
 *           - Like XAbus, YBbus[31:21] can be masked via ContBusMask.
 *           - YBbus[33:32] can also be masked with XYBext.
 * 
 ***************************************************************************/

module MuxBusYB( YB0bus, YB1bus, MuxSel, ContBusMask, XYBext, YBbus);

   input [33:0]	 YB0bus;
   input [31:0]	 YB1bus;
   input	 MuxSel, ContBusMask, XYBext;
   output [33:0] YBbus;
   
   Mux_and_Mask32 UM4_0( YB0bus[31:0], YB1bus, MuxSel, ContBusMask, YBbus[31:0]);
   
   inv     UM4_1( .A(XYBext), .Y(NotXYBext) );
   or2     UM4_2( .A(NotXYBext), .B(YB0bus[32]), .Y(YBbus[32]) ),
           UM4_3( .A(NotXYBext), .B(YB0bus[33]), .Y(YBbus[33]) );

endmodule // MuxBusYB

/***************************************************************************
 * Module: AdderX34bit
 * 
 * Function: calculate CarryOutXbus from the sum of XAbus and XBbus.
 *           - LocalCarryXCin0 and LocalCarryXCin1 are carries within 5-, 4- and
 *             2-bit groups with an assumed carry input of 0 and 1, respectively.
 *           - Notice: carry bits 5,6,7,14,15,16,23,24,25 and 32 do NOT EXIST!
 *             The pivot and local carries are used to compute the sum and
 *             sum-parity outputs for these bit positions.
 *           - CoutX1 is tied to CarryOutXbus[33], whereas CoutX2 is functionally
 *             identical, but calculated differently.
 * 
 ***************************************************************************/

module AdderX34bit( XAbus, XBbus, CinX, PropXbus, LocalCarryXCin0, LocalCarryXCin1,
		    CarryOutXbus, CoutX1, CoutX2);

   input [33:0]	 XAbus, XBbus;
   input	 CinX;
   output [33:0] PropXbus;
   output [33:0] LocalCarryXCin0, LocalCarryXCin1;
   output [33:0] CarryOutXbus;
   output	 CoutX1, CoutX2;
   
   wire [33:0]	 GenXbus;

   GenProp34 UM5_0( XAbus, XBbus, GenXbus, PropXbus);

   CLA_CSA34 UM5_1( GenXbus, PropXbus, CinX,
		    LocalCarryXCin0, LocalCarryXCin1, CarryOutXbus, CoutX1, CoutX2);

endmodule // AdderX34bit

/******************************************************/

module GenProp34( InAbus, InBbus, Gbus, Pbus);

   input [33:0]	 InAbus, InBbus;
   output [33:0] Gbus, Pbus;

   GenProp8 GP34_0( InAbus[7:0],   InBbus[7:0],   Gbus[7:0],   Pbus[7:0]),
   GP34_1( InAbus[15:8],  InBbus[15:8],  Gbus[15:8],  Pbus[15:8]),
   GP34_2( InAbus[23:16], InBbus[23:16], Gbus[23:16], Pbus[23:16]),
   GP34_3( InAbus[31:24], InBbus[31:24], Gbus[31:24], Pbus[31:24]);

   and2    GP34_4( .A(InAbus[32]), .B(InBbus[32]), .Y(Gbus[32]) ),
   GP34_5( .A(InAbus[33]), .B(InBbus[33]), .Y(Gbus[33]) );
   
   XOR2a  GP34_6( .A(InAbus[32]), .B(InBbus[32]), .Y(Pbus[32]) ),
   GP34_7( .A(InAbus[33]), .B(InBbus[33]), .Y(Pbus[33]) );

endmodule // GenProp34bit

/******************************************************/

module GenProp8( InAbus, InBbus, Gbus, Pbus);

   input [7:0]	InAbus, InBbus;
   output [7:0]	Gbus, Pbus;

   and2 GenProp8_0( .A(InAbus[0]), .B(InBbus[0]), .Y(Gbus[0]) ),
   GenProp8_1( .A(InAbus[1]), .B(InBbus[1]), .Y(Gbus[1]) ),
   GenProp8_2( .A(InAbus[2]), .B(InBbus[2]), .Y(Gbus[2]) ),
   GenProp8_3( .A(InAbus[3]), .B(InBbus[3]), .Y(Gbus[3]) ),
   GenProp8_4( .A(InAbus[4]), .B(InBbus[4]), .Y(Gbus[4]) ),
   GenProp8_5( .A(InAbus[5]), .B(InBbus[5]), .Y(Gbus[5]) ),
   GenProp8_6( .A(InAbus[6]), .B(InBbus[6]), .Y(Gbus[6]) ),
   GenProp8_7( .A(InAbus[7]), .B(InBbus[7]), .Y(Gbus[7]) );

   XOR2a GenProp8_8( .A(InAbus[0]), .B(InBbus[0]), .Y(Pbus[0]) ),
   GenProp8_9( .A(InAbus[1]), .B(InBbus[1]), .Y(Pbus[1]) ),
   GenProp8_10( .A(InAbus[2]), .B(InBbus[2]), .Y(Pbus[2]) ),
   GenProp8_11( .A(InAbus[3]), .B(InBbus[3]), .Y(Pbus[3]) ),
   GenProp8_12( .A(InAbus[4]), .B(InBbus[4]), .Y(Pbus[4]) ),
   GenProp8_13( .A(InAbus[5]), .B(InBbus[5]), .Y(Pbus[5]) ),
   GenProp8_14( .A(InAbus[6]), .B(InBbus[6]), .Y(Pbus[6]) ),
   GenProp8_15( .A(InAbus[7]), .B(InBbus[7]), .Y(Pbus[7]) );

endmodule // GenProp8

/******************************************************
 * This 34-bit adder is used both by module AdderX34bit
 * and by module AdderY4bit.
 ******************************************************/

module CLA_CSA34( Genbus, Propbus, Cin,
		  LocalCarryCin0, LocalCarryCin1, CarryOutbus, Cout1, Cout2);

   input [33:0]	 Genbus, Propbus;
   input	 Cin;
   output [33:0] LocalCarryCin0, LocalCarryCin1;
   output [33:0] CarryOutbus;
   output	 Cout1, Cout2;

   /* This 34-bit adder is partitioned into blocks of sizes 5, 4 and 2.
    * Block boundaries:
    *      block #0 (5): bits [4:0]
    *      block #1 (4): bits [8:5]
    *      block #2 (5): bits [13:9]
    *      block #3 (4): bits [17:14]
    *      block #4 (5): bits [22:18]
    *      block #5 (4): bits [26:23]
    *      block #6 (5): bits [31:27] 
    *      block #7 (2): bits [33:32]

    * first calculate carries local to each block
    - note: LocalCin0[j] means the carry OUT OF bit j (to bit j+1)
    assuming the carry into that block=0
    and LocalCin1[j] means the carry OUT OF bit j (to bit j+1)
    assuming the carry into that block=1
    */

   GenLocalCarry34 CC_0( Genbus, Propbus, LocalCarryCin0, LocalCarryCin1 );

   // then generate global carry lines
   //  ... but carries are not explicitly generated for 4-bit blocks.


   GenerateGlobalCarry34 CC_1( Genbus, Propbus, Cin, LocalCarryCin0, LocalCarryCin1,
			       CarryOutbus );

   assign Cout1 = CarryOutbus[33];

   Mux2_1 CC_2( LocalCarryCin0[33], LocalCarryCin1[33], CarryOutbus[31],
		Cout2 );


endmodule // CLA_CSA34

/******************************************************/
/******************************************************/

module GenLocalCarry34( Gbus, Pbus, LocalC0, LocalC1 );

   input [33:0]	 Gbus, Pbus;
   output [33:0] LocalC0, LocalC1;
   
   GenLocalCarry9 GLC34_0( Gbus[8:0], Pbus[8:0],
			   LocalC0[8:0], LocalC1[8:0] ),
   GLC34_1( Gbus[17:9], Pbus[17:9],
	    LocalC0[17:9], LocalC1[17:9] ),
   GLC34_2( Gbus[26:18], Pbus[26:18],
	    LocalC0[26:18], LocalC1[26:18] );
   GenLocalCarry5 GLC34_3( Gbus[31:27], Pbus[31:27],
			   LocalC0[31:27], LocalC1[31:27] );
   GenLocalCarry2 GLC34_4( Gbus[33:32], Pbus[33:32],
			   LocalC0[33:32], LocalC1[33:32] );

endmodule // GenLocalCarry34

/******************************************************/

module GenLocalCarry9( Gbus, Pbus, LocalC0, LocalC1 );

   input [8:0]	Gbus, Pbus;
   output [8:0]	LocalC0, LocalC1;

   GenLocalCarry5 GLC9_0( Gbus[4:0], Pbus[4:0],
			  LocalC0[4:0], LocalC1[4:0] );
   GenLocalCarry4 GLC9_4( Gbus[8:5], Pbus[8:5],
			  LocalC0[8:5], LocalC1[8:5] );

endmodule // GenLocalCarry9

/******************************************************/

module GenLocalCarry5( Gbus, Pbus, LocalC0, LocalC1 );

   input [4:0]	Gbus, Pbus;
   output [4:0]	LocalC0, LocalC1;
   
   GenLocalCarry4 GLC5_0( Gbus[3:0], Pbus[3:0],
			  LocalC0[3:0], LocalC1[3:0] );

   AND_OR5a GLC5_1( Gbus[4], Pbus[4], Gbus[3], Pbus[3], Gbus[2],
		    Pbus[2], Gbus[1], Pbus[1], Gbus[0],
		    LocalC0[4] );
   AND_OR6b GLC5_2( Gbus[4], Pbus[4], Gbus[3], Pbus[3], Gbus[2],
		    Pbus[2], Gbus[1], Pbus[1], Gbus[0], Pbus[0],
		    LocalC1[4] );
   
endmodule // GenLocalCarry5

/******************************************************/

module GenLocalCarry4( Gbus, Pbus, LocalC0, LocalC1 );

   input [3:0]	Gbus, Pbus;
   output [3:0]	LocalC0, LocalC1;
   
   assign LocalC0[0] = Gbus[0];
   or2 GLC4_0( .A(Gbus[0]), .B(Pbus[0]), .Y(LocalC1[0]) );

   AND_OR2  GLC4_1( Gbus[1], Pbus[1], Gbus[0], LocalC0[1] );
   AND_OR3b GLC4_2( Gbus[1], Pbus[1], Gbus[0], Pbus[0], LocalC1[1] );

   AND_OR3a GLC4_3( Gbus[2], Pbus[2], Gbus[1], Pbus[1], Gbus[0],
		    LocalC0[2] );
   AND_OR4b GLC4_4( Gbus[2], Pbus[2], Gbus[1], Pbus[1], Gbus[0],
		    Pbus[0], LocalC1[2] );

   AND_OR4a GLC4_5( Gbus[3], Pbus[3], Gbus[2], Pbus[2], Gbus[1],
		    Pbus[1], Gbus[0], LocalC0[3] );
   AND_OR5b GLC4_6( Gbus[3], Pbus[3], Gbus[2], Pbus[2], Gbus[1],
		    Pbus[1], Gbus[0], Pbus[0], LocalC1[3] );

endmodule // GenLocalCarry4

/******************************************************/

module GenLocalCarry2( Gbus, Pbus, LocalC0, LocalC1 );

   input [1:0]	Gbus, Pbus;
   output [1:0]	LocalC0, LocalC1;
   
   assign LocalC0[0] = Gbus[0];
   or2 GLC2_0( .A(Gbus[0]), .B(Pbus[0]), .Y(LocalC1[0]) );

   AND_OR2  GLC2_1( Gbus[1], Pbus[1], Gbus[0], LocalC0[1] );
   AND_OR3b GLC2_2( Gbus[1], Pbus[1], Gbus[0], Pbus[0], LocalC1[1] );

endmodule // GenLocalCarry2

/******************************************************/
/******************************************************/

module GenerateGlobalCarry34( Gbus, Pbus, Cin, LocalC0, LocalC1,
			      CarryOutbus );

   input [33:0]	 Gbus, Pbus;
   input	 Cin;
   input [33:0]	 LocalC0, LocalC1;
   output [33:0] CarryOutbus;

   // first calculate the global carry to each block called pivot carry.

   CalcPivotCarry CGC34_0( Pbus, Cin, LocalC0, LocalC1, CarryOutbus );

   /* Compute only the carries for the 5-bit blocks
    The pivot carries will be used to select the correct Sum bits
    for the 4-bit blocks */

   CalcBlockCLA5 CGC34_1( Pbus[3:0], Gbus[3:0], Cin,
			  CarryOutbus[3:0] );
   CalcBlockCLA5 CGC34_2( Pbus[12:9], Gbus[12:9], CarryOutbus[8],
			  CarryOutbus[12:9] );
   CalcBlockCLA5 CGC34_3( Pbus[21:18], Gbus[21:18], CarryOutbus[17],
			  CarryOutbus[21:18] );
   CalcBlockCLA5 CGC34_4( Pbus[30:27], Gbus[30:27], CarryOutbus[26],
			  CarryOutbus[30:27] );

endmodule // GenerateGlobalCarry34

/******************************************************/

module CalcPivotCarry( Pbus, Cin, LocalC0, LocalC1, CarryOutbus );
   
   input [33:0]	 Pbus;
   input	 Cin;
   input [33:0]	 LocalC0, LocalC1;
   output [33:0] CarryOutbus;


   and5 CBC0( .A(Pbus[0]), .B(Pbus[1]), .C(Pbus[2]), .D(Pbus[3]),
	     .E(Pbus[4]), .Y(Prop4_0) );
   and4 CBC1( .A(Pbus[5]), .B(Pbus[6]), .C(Pbus[7]), .D(Pbus[8]),
	     .Y(Prop8_5) );
   and5 CBC2( .A(Pbus[9]), .B(Pbus[10]), .C(Pbus[11]), .D(Pbus[12]),
	     .E(Pbus[13]), .Y(Prop13_9) );
   and4 CBC3( .A(Pbus[14]), .B(Pbus[15]), .C(Pbus[16]), .D(Pbus[17]),
	     .Y(Prop17_14) );
   and5 CBC4( .A(Pbus[18]), .B(Pbus[19]), .C(Pbus[20]), .D(Pbus[21]),
	     .E(Pbus[22]), .Y(Prop22_18) );
   and4 CBC5( .A(Pbus[23]), .B(Pbus[24]), .C(Pbus[25]), .D(Pbus[26]),
	     .Y(Prop26_23) );
   and5 CBC6( .A(Pbus[27]), .B(Pbus[28]), .C(Pbus[29]), .D(Pbus[30]),
	     .E(Pbus[31]), .Y(Prop31_27) );
   and2 CBC7( .A(Pbus[32]), .B(Pbus[33]), .Y(Prop33_32) );

   and2 CBC8( .A(Prop4_0), .B(Prop8_5), .Y(Prop8_0) );
   and2 CBC9( .A(Prop13_9), .B(Prop17_14), .Y(Prop17_9) );
   and2 CBC10( .A(Prop22_18), .B(Prop26_23), .Y(Prop26_18) );
   and2 CBC11( .A(Prop31_27), .B(Prop33_32), .Y(Prop33_27) );

   // CarryOutbus[4]
   AND_OR2 CBC12( LocalC0[4], Cin, Prop4_0, CarryOutbus[4]);

   // CarryOutbus[8]
   Mux2_1 CGC13( LocalC0[8],  LocalC1[8], CarryOutbus[4],
		 CarryOutbus[8] );

   // CarryOutbus[13]
   AND_OR2 GGC14( LocalC0[13], CarryOutbus[8], Prop13_9,
		  CarryOutbus[13] );

   // CarryOutbus[17]
   AND_OR2 CGC15( LocalC0[17], LocalC0[13], Prop17_14,
		  LocalCarry17_9 );
   AND_OR2 CGC16( LocalC0[8], LocalC0[4], Prop8_5, LocalCarry8_0 );

   AND_OR3a CGC17( LocalCarry17_9, Prop17_9, LocalCarry8_0,
		   Prop8_0, Cin, CarryOutbus[17] );

   // CarryOutbus[22]
   AND_OR2 CGC18( LocalC0[22], CarryOutbus[17], Prop22_18,
		  CarryOutbus[22]);

   // CarryOutbus[26]
   AND_OR2 CGC19( LocalC0[26], LocalC0[22], Prop26_23,
		  LocalCarry26_18 );

   AND_OR4a CGC20( LocalCarry26_18, Prop26_18, LocalCarry17_9,
		   Prop17_9, LocalCarry8_0, Prop8_0, Cin, CarryOutbus[26] );

   // CarryOutbus[31]
   AND_OR2 CGC21( LocalC0[31], CarryOutbus[26], Prop31_27,
		  CarryOutbus[31]);
   
   // CarryOutbus[33] = CarryOutX
   AND_OR2 CGC22( LocalC0[33], LocalC0[31], Prop33_32,
		  LocalCarry33_27 );

   AND_OR5a CGC23( LocalCarry33_27, Prop33_27, LocalCarry26_18, Prop26_18,
		   LocalCarry17_9,	Prop17_9, LocalCarry8_0, Prop8_0, Cin,
		   CarryOutbus[33] );

endmodule // CalcPivotCarry

/******************************************************/

module CalcBlockCLA5( Pbus, Gbus, Cin, Carrybus );

   input [3:0]	Pbus, Gbus;
   input	Cin;
   output [3:0]	Carrybus;

   AND_OR2  CB5_0( Gbus[0], Pbus[0], Cin, Carrybus[0] );
   AND_OR3a CB5_1( Gbus[1], Pbus[1], Gbus[0], Pbus[0], Cin, Carrybus[1] );
   AND_OR4a CB5_2( Gbus[2], Pbus[2], Gbus[1], Pbus[1],
		   Gbus[0], Pbus[0], Cin, Carrybus[2] );
   AND_OR5a CB5_3( Gbus[3], Pbus[3], Gbus[2], Pbus[2], Gbus[1], Pbus[1],
		   Gbus[0], Pbus[0], Cin, Carrybus[3] );

endmodule


/***************************************************************************
 * Module: GenerateSumX
 * 
 * Function: compute the SumX outputs using PropXbus and carry lines.
 *           - For 5-bit blocks, the sum[i] is simply computed by
 *             prop[i] XOR carry[i].
 *           - For 4-bit blocks, two sums are computed:
 *             prop[i] XOR LocalCarryCin0[i] and
 *             prop[i] XOR LocalCarryCin1[i].
 *             The pivot carry selects the correct sum.
 *             (This scheme is used to speed up the sum computation for
 *              such blocks, since the XOR delay is longer than the MUX delay.)
 *             
 ***************************************************************************/

module GenerateSumX( PropXbus, CinX, LocalCarryCin0, LocalCarryCin1, CarryXbus,
		     SumXbus );

   input [33:0]	 PropXbus;
   input	 CinX;
   input [33:0]	 LocalCarryCin0, LocalCarryCin1, CarryXbus;
   output [33:0] SumXbus;
   
   wire [5:0]	 Cry5_0;

   assign Cry5_0[0] = CinX,
   Cry5_0[5:1] = CarryXbus[4:0]; 

   CalcSumXor6 UM6_0( PropXbus[5:0], Cry5_0, SumXbus[5:0] );

   CalcSumMux3 UM6_1( PropXbus[8:6], CarryXbus[4], LocalCarryCin0[7:5],
		      LocalCarryCin1[7:5], SumXbus[8:6] );

   CalcSumXor6 UM6_2( PropXbus[14:9], CarryXbus[13:8], SumXbus[14:9] );

   CalcSumMux3 UM6_3( PropXbus[17:15], CarryXbus[13], LocalCarryCin0[16:14],
		      LocalCarryCin1[16:14], SumXbus[17:15] );

   CalcSumXor6 UM6_4( PropXbus[23:18], CarryXbus[22:17], SumXbus[23:18] );

   CalcSumMux3 UM6_5( PropXbus[26:24], CarryXbus[22], LocalCarryCin0[25:23],
		      LocalCarryCin1[25:23], SumXbus[26:24] );

   CalcSumXor6 UM6_6( PropXbus[32:27], CarryXbus[31:26], SumXbus[32:27] );

   XOR2a  UM6_7( .A(PropXbus[33]), .B(LocalCarryCin0[32]), .Y(Sum33_0) ),
   UM6_8( .A(PropXbus[33]), .B(LocalCarryCin1[32]), .Y(Sum33_1) );
   
   Mux2_1 UM6_9( Sum33_0, Sum33_1, CarryXbus[31], SumXbus[33] );


endmodule // GenerateSumX

/******************************************************/

module CalcSumXor6( Pbus, Carrybus, Sumbus );

   input [5:0]	Pbus;
   input [5:0]	Carrybus;
   output [5:0]	Sumbus;
   

   XOR2a CSX6_0( .A(Pbus[0]), .B(Carrybus[0]), .Y(Sumbus[0]) ),
   CSX6_1( .A(Pbus[1]), .B(Carrybus[1]), .Y(Sumbus[1]) ),
   CSX6_2( .A(Pbus[2]), .B(Carrybus[2]), .Y(Sumbus[2]) ),
   CSX6_3( .A(Pbus[3]), .B(Carrybus[3]), .Y(Sumbus[3]) ),
   CSX6_4( .A(Pbus[4]), .B(Carrybus[4]), .Y(Sumbus[4]) ),
   CSX6_5( .A(Pbus[5]), .B(Carrybus[5]), .Y(Sumbus[5]) );

endmodule // CalcSumXor6

/******************************************************/

module CalcSumMux3( Pbus, Cin, LocalCarryCin0, LocalCarryCin1, Sumbus );

   input [2:0]	Pbus;
   input	Cin;
   input [2:0]	LocalCarryCin0, LocalCarryCin1;
   output [2:0]	Sumbus;

   wire [2:0]	Sum0, Sum1;

   XOR2a CSM4_0( .A(Pbus[0]), .B(LocalCarryCin0[0]), .Y(Sum0[0]) ),
   CSM4_1( .A(Pbus[1]), .B(LocalCarryCin0[1]), .Y(Sum0[1]) ),
   CSM4_2( .A(Pbus[2]), .B(LocalCarryCin0[2]), .Y(Sum0[2]) ),
   CSM4_3( .A(Pbus[0]), .B(LocalCarryCin1[0]), .Y(Sum1[0]) ),
   CSM4_4( .A(Pbus[1]), .B(LocalCarryCin1[1]), .Y(Sum1[1]) ),
   CSM4_5( .A(Pbus[2]), .B(LocalCarryCin1[2]), .Y(Sum1[2]) );
   
   Mux2_1 CSM4_6( Sum0[0], Sum1[0], Cin, Sumbus[0] ),
   CSM4_7( Sum0[1], Sum1[1], Cin, Sumbus[1] ),
   CSM4_8( Sum0[2], Sum1[2], Cin, Sumbus[2] );
   
endmodule // CalcSumMux3


/***************************************************************************
 * Module: GenerateSumParity
 * 
 * Function: compute the following four parity outputs:
 *           - NotSumParbus[0]: parity for SumX[8:0]     (5+4)
 *           - NotSumParbus[1]: parity for SumX[17:9]    (5+4)
 *           - NotSumParbus[2]: parity for SumX[26:18]   (5+4)
 *           - NotSumParbus[3]: parity for SumX[33:27]   (5+2)
 * 
 *           - For each case, two parities are computed, and
 *             the pivot carries select the correct one.
 *             (again, a method intended for increased speed.)
 * 
 ***************************************************************************/

module GenerateSumParity( Pbus, CinX, LocalC0, LocalC1, CarryXbus,
			  NotSumParbus);

   input [33:0]	Pbus;
   input	CinX;
   input [33:0]	LocalC0, LocalC1, CarryXbus;
   output [3:0]	NotSumParbus;

   wire		ParCin0b33_32, ParCin1b33_32armut; 

   SerialPar9nc GSP0( {Pbus[4:0], LocalC0[3:0]}, ParCin0b4_0);
   SerialPar9c  GSP1( {Pbus[4:0], LocalC1[3:0]}, ParCin1b4_0);   

   SerialPar7nc GSP2( {Pbus[8:5], LocalC0[7:5]}, ParCin0b8_5);
   SerialPar7c  GSP3( {Pbus[8:5], LocalC1[7:5]}, ParCin1b8_5);

   SerialPar9nc GSP4( {Pbus[13:9], LocalC0[12:9]}, ParCin0b13_9);
   SerialPar9c  GSP5( {Pbus[13:9], LocalC1[12:9]}, ParCin1b13_9);

   SerialPar7nc GSP6( {Pbus[17:14], LocalC0[16:14]}, ParCin0b17_14);
   SerialPar7c  GSP7( {Pbus[17:14], LocalC1[16:14]}, ParCin1b17_14);

   SerialPar9nc GSP8( {Pbus[22:18], LocalC0[21:18]}, ParCin0b22_18);
   SerialPar9c  GSP9( {Pbus[22:18], LocalC1[21:18]}, ParCin1b22_18);

   SerialPar7nc GSP10( {Pbus[26:23], LocalC0[25:23]}, ParCin0b26_23);
   SerialPar7c  GSP11( {Pbus[26:23], LocalC1[25:23]}, ParCin1b26_23);

   SerialPar9nc GSP12( {Pbus[31:27], LocalC0[30:27]}, ParCin0b31_27);
   SerialPar9c  GSP13( {Pbus[31:27], LocalC1[30:27]}, ParCin1b31_27);

   SerialPar3nc GSP14( {Pbus[33:32], LocalC0[32]}, ParCin0b33_32);
   SerialPar3c  GSP15( {Pbus[33:32], LocalC1[32]}, ParCin1b33_32armut);

   SelectPar9 GSP16( ParCin0b4_0, ParCin1b4_0, ParCin0b8_5, ParCin1b8_5,
		     CinX, LocalC0[4], LocalC1[4],
		     NotSumParbus[0] );

   SelectPar9 GSP17( ParCin0b13_9, ParCin1b13_9, ParCin0b17_14, ParCin1b17_14,
		     CarryXbus[8], LocalC0[13], LocalC1[13],
		     NotSumParbus[1] );

   SelectPar9 GSP18( ParCin0b22_18, ParCin1b22_18, ParCin0b26_23, ParCin1b26_23,
		     CarryXbus[17], LocalC0[22], LocalC1[22],
		     NotSumParbus[2] );

   SelectPar9 GSP19( ParCin0b31_27, ParCin1b31_27, ParCin0b33_32, ParCin1b33_32armut,
		     CarryXbus[26], LocalC0[31], LocalC1[31],
		     NotSumParbus[3] );


endmodule // GenerateSumParity


/******************************************************/

module SerialPar9nc( Inbus, Out);

   input [8:0] Inbus;
   output      Out;
   
   SerialPar7nc SP9nc0( Inbus[6:0], line0 );
   XOR2a        SP9nc1( .A(Inbus[7]), .B(line0), .Y(line1) ),
   SP9nc2( .A(Inbus[8]), .B(line1), .Y(Out) );

endmodule // SerialPar9nc

/******************************************************/

module SerialPar9c( Inbus, Out);

   input [8:0] Inbus;
   output      Out;
   
   // Inbus[6] is inverted in SerialPar7c
   SerialPar7c SP9nc0( Inbus[6:0], line0 );
   XOR2a       SP9nc1( .A(Inbus[7]), .B(line0), .Y(line1) ),
   SP9nc2( .A(Inbus[8]), .B(line1), .Y(Out) );

endmodule // SerialPar9c

/******************************************************/

module SerialPar7nc( Inbus, Out);

   input [6:0] Inbus;
   output      Out;
   
   XOR2a SP7nc0( .A(Inbus[0]), .B(Inbus[1]), .Y(line0) ),
   SP7nc1( .A(Inbus[2]), .B(line0), .Y(line1) ),
   SP7nc2( .A(Inbus[3]), .B(line1), .Y(line2) ),
   SP7nc3( .A(Inbus[4]), .B(line2), .Y(line3) ),
   SP7nc4( .A(Inbus[5]), .B(line3), .Y(line4) ),
   SP7nc5( .A(Inbus[6]), .B(line4), .Y(Out) );

endmodule // SerialPar7nc

/******************************************************/

module SerialPar7c( Inbus, Out);

   input [6:0] Inbus;
   output      Out;
   
   wire [6:0]  NewInbus;

   // invert one bit to complement the output
   // -- Inbus[6] is chosen so the inverter is not on the longest path

   inv  SP7c0( .A(Inbus[6]), .Y(NewInbus[6]) );
   assign NewInbus[5:0] = Inbus[5:0];

   SerialPar7nc SP7c2( NewInbus, Out );

endmodule // SerialPar7c

/******************************************************/

module SerialPar3nc( Inbus, Out );

   input [2:0] Inbus;
   output      Out;
   
   XOR2a  SP3nc0( .A(Inbus[0]), .B(Inbus[1]), .Y(line0) ),
   SP3nc1( .A(Inbus[2]), .B(line0), .Y(Out) );

endmodule // CalcPar3nc

/******************************************************/

module SerialPar3c( Inbus, Out );

   input [2:0] Inbus;
   output      Out;
   
   inv     SP3c0( .A(Inbus[2]), .Y(NotIn2) );
   XOR2a  SP3c1( .A(Inbus[0]), .B(Inbus[1]), .Y(line1) ),
   SP3c2( .A(NotIn2), .B(line1), .Y(Out) );
   
endmodule // CalcPar3c

/******************************************************/

module SelectPar9( ParCin0Lo, ParCin1Lo, ParCin0Hi, ParCin1Hi,
		   Cin, LocalC0, LocalC1,
		   NotSumPar );

   input  ParCin0Lo, ParCin1Lo, ParCin0Hi, ParCin1Hi;
   input  Cin, LocalC0, LocalC1;
   output NotSumPar;


   Mux2_1 SPar0( ParCin0Lo, ParCin1Lo, Cin, line0),
   SPar1( ParCin0Hi, ParCin1Hi, LocalC0, line1),
   SPar2( ParCin0Hi, ParCin1Hi, LocalC1, line2),
   SPar3( line1, line2, Cin, line3);

   XOR2a  SPar4( .A(line0), .B(line3), .Y(line4) );
   inv     SPar5( .A(line4), .Y(NotSumPar) );


endmodule // SelectPar9

/***************************************************************************
 * Module: AdderY34bit
 * 
 * Function: compute the carry output (CoutY1, CoutY2) from the addition
 *           of YAbus and YBbus.
 *           Note that, with one of the input buses complemented,
 *           the carry output indicates whether the complemented input is
 *           less than the other than.
 *           - CoutY_17 is the carry output from the center position (17).
 * 
 ***************************************************************************/

module AdderY34bit( YAbus, YBbus, CinY, CoutY1, CoutY2, CoutY_17 );

   input [33:0]	YAbus, YBbus;
   input	CinY;
   output	CoutY1, CoutY2, CoutY_17;

   wire [33:0]	GenYbus, PropYbus;
   wire [33:0]	CarryOutYbus;
   wire [33:0]	dummy0, dummy1;

   GenProp34 UM8_0( YAbus, YBbus, GenYbus, PropYbus);

   CLA_CSA34 UM8_1( .Genbus(GenYbus), .Propbus(PropYbus), .Cin(CinY),
		    .LocalCarryCin0(dummy0), .LocalCarryCin1(dummy1),
		    .CarryOutbus(CarryOutYbus), .Cout1(CoutY1), .Cout2(CoutY2) );

   assign CoutY_17 = CarryOutYbus[17];

endmodule // AdderY34bit

/***************************************************************************
 * Module: ParityModule
 * 
 * Function: Check the parities of input buses XAbus, YAbus and YBbus.
 *           - These buses are augmented with PCXA0bus, PCXA1bus, PCYA0bus,
 *             and PCYA1bus, PCYB0bus.
 *           - StrobeK0_1 and StrobeK2_3 can mask the final AND (ParCheck[0]).
 *
 ***************************************************************************/

module ParityModule( XAbus, YAbus, YBbus, MuxSel, ContBusMask, StrobeInbus,
		     PCXA0bus, PCXA1bus, PCYA0bus, PCYA1bus, PCYB0bus,
		     ParCheck, Not_StrobeOutbus );
   
   input [33:0]	XAbus, YAbus, YBbus;
   input	MuxSel, ContBusMask;
   input [15:0]	StrobeInbus;
   input [6:0]	PCXA0bus, PCXA1bus, PCYA0bus, PCYA1bus, PCYB0bus;
   output [3:0]	ParCheck;
   output [3:0]	Not_StrobeOutbus;
   
   wire [6:0]	PCXAbus, PCYAbus, PCYBbus, PCYB1bus;
   wire		StrobeK0_1, StrobeK2_3;

   assign PCYB1bus[6:0] = PCXA1bus[6:0];

   ParityStrobe UM9_0( StrobeInbus, StrobeK0_1, StrobeK2_3, Not_StrobeOutbus );

   ParChkBuses UM9_1( PCXA0bus, PCXA1bus, PCYA0bus, PCYA1bus, PCYB0bus, PCYB1bus,
		      MuxSel, ContBusMask,
		      PCXAbus, PCYAbus, PCYBbus );

   ParityChecker UM9_2( XAbus, YAbus, YBbus, PCXAbus, PCYAbus, PCYBbus,
			StrobeK0_1, StrobeK2_3, ParCheck );

endmodule

/********************************************/
/********************************************/

module ParityStrobe( StrInbus, StrobeK0_1, StrobeK2_3,
		     Not_StrOutbus );

   input [15:0]	StrInbus;
   output	StrobeK0_1, StrobeK2_3;
   output [3:0]	Not_StrOutbus;

   wire		K0, K1, K2, K3;

   and4  GS0( .A(StrInbus[0]), .B(StrInbus[1]), .C(StrInbus[2]),
	     .D(StrInbus[3]), .Y(K0) ),
   GS1( .A(StrInbus[4]), .B(StrInbus[5]), .C(StrInbus[6]),
	.D(StrInbus[7]), .Y(K1) ),
   GS2( .A(StrInbus[8]), .B(StrInbus[9]), .C(StrInbus[10]),
	.D(StrInbus[11]), .Y(K2) ),
   GS3( .A(StrInbus[12]), .B(StrInbus[13]), .C(StrInbus[14]),
	.D(StrInbus[15]), .Y(K3) );
   and2 GS4( .A(K0), .B(K1), .Y(StrobeK0_1) ),
   GS5( .A(K2), .B(K3), .Y(StrobeK2_3) );
   inv  GS6( .A(K0), .Y(Not_StrOutbus[0]) ),
   GS7( .A(K1), .Y(Not_StrOutbus[1]) ),
   GS8( .A(K2), .Y(Not_StrOutbus[2]) ),
   GS9( .A(K3), .Y(Not_StrOutbus[3]) );

endmodule // ParityStrobe

/********************************************/
/********************************************/

module ParChkBuses( PCXA0bus, PCXA1bus, PCYA0bus, PCYA1bus, PCYB0bus, PCYB1bus,
		    MuxSel, ContBusMask,
		    PCXAbus, PCYAbus, PCYBbus );

   input [6:0]	PCXA0bus, PCXA1bus, PCYA0bus, PCYA1bus, PCYB0bus, PCYB1bus;
   input	MuxSel, ContBusMask;
   output [6:0]	PCXAbus, PCYAbus, PCYBbus;
   
   wire [6:0]	Not_PCYA0bus;
   wire [6:0]	PCXAtempbus, PCYBtempbus;

   Invert7 PCB0( PCYA0bus, Not_PCYA0bus );
   Mux7    PCB1( PCXA0bus, PCXA1bus, MuxSel, PCXAtempbus ),
   PCB2( Not_PCYA0bus, PCYA1bus, MuxSel, PCYAbus ),
   PCB3( PCYB0bus, PCYB1bus, MuxSel, PCYBtempbus );

   Mask3_Not1 PCB4( PCXAtempbus, ContBusMask, PCXAbus ),
   PCB5( PCYBtempbus, ContBusMask, PCYBbus );

endmodule // ParChkBuses

/********************************************/

module Mux7( In1bus, In2bus, MuxSel, Outbus);

   input [6:0]	In1bus, In2bus;
   input	MuxSel;
   output [6:0]	Outbus;

   Mux2_1 Mux7_0 ( In1bus[0], In2bus[0], MuxSel, Outbus[0]),
   Mux7_1 ( In1bus[1], In2bus[1], MuxSel, Outbus[1]),
   Mux7_2 ( In1bus[2], In2bus[2], MuxSel, Outbus[2]),
   Mux7_3 ( In1bus[3], In2bus[3], MuxSel, Outbus[3]),
   Mux7_4 ( In1bus[4], In2bus[4], MuxSel, Outbus[4]),
   Mux7_5 ( In1bus[5], In2bus[5], MuxSel, Outbus[5]),
   Mux7_6 ( In1bus[6], In2bus[6], MuxSel, Outbus[6]);

endmodule // Mux7

/********************************************/

module Invert7( Inbus, Outbus );

   input [6:0]	Inbus;
   output [6:0]	Outbus;

   inv Inv7_0( .A(Inbus[0]), .Y(Outbus[0]) ),
   Inv7_1( .A(Inbus[1]), .Y(Outbus[1]) ),
   Inv7_2( .A(Inbus[2]), .Y(Outbus[2]) ),
   Inv7_3( .A(Inbus[3]), .Y(Outbus[3]) ),
   Inv7_4( .A(Inbus[4]), .Y(Outbus[4]) ),
   Inv7_5( .A(Inbus[5]), .Y(Outbus[5]) ),
   Inv7_6( .A(Inbus[6]), .Y(Outbus[6]) );
   
endmodule // Invert7

/********************************************/

module Mask3_Not1( Inbus, ContBusMask, Outbus );

   input [6:0]	Inbus;
   input	ContBusMask;
   output [6:0]	Outbus;
   
   assign Outbus[3:0] = Inbus[3:0];
   and2 MN0( .A(Inbus[4]), .B(ContBusMask), .Y(Outbus[4]) ),
        MN1( .A(Inbus[5]), .B(ContBusMask), .Y(Outbus[5]) );
   and2 MN2( .A(Inbus[6]), .B(ContBusMask), .Y(line2) );
   inv  MN3( .A(line2), .Y(Outbus[6]) );

endmodule // Mask3_Not1

/********************************************/
/********************************************/

module ParityChecker( XAbus, YAbus, YBbus, PCXAbus, PCYAbus, PCYBbus,
		      StrobeK0_1, StrobeK2_3, ParCheck);

   input [33:0]	XAbus, YAbus, YBbus;
   input [6:0]	PCXAbus, PCYAbus, PCYBbus;
   input	StrobeK0_1, StrobeK2_3;
   output [3:0]	ParCheck;

   ParityTree10bit ParC0( { XAbus[8:1],PCXAbus[1:0] },   XaP0),
   ParC1( { XAbus[17:9],PCXAbus[2] },    XaP1),
   ParC2( { XAbus[26:18],PCXAbus[3] },   XaP2);
   ParityTree8bit  ParC3( { XAbus[31:27],PCXAbus[6:4] }, XaP3);
   
   ParityTree10bit ParC4( { YAbus[8:1],PCYAbus[1:0] },   YaP0),
   ParC5( { YAbus[17:9],PCYAbus[2] },    YaP1),
   ParC6( { YAbus[26:18],PCYAbus[3] },   YaP2);
   ParityTree8bit  ParC7( { YAbus[31:27],PCYAbus[6:4] }, YaP3);

   ParityTree10bit ParC8( { YBbus[8:1],PCYBbus[1:0] },   YbP0),
   ParC9( { YBbus[17:9],PCYBbus[2] },    YbP1),
   ParC10({ YBbus[26:18],PCYBbus[3] },   YbP2);
   ParityTree8bit  ParC11({ YBbus[31:27],PCYBbus[6:4] }, YbP3);

   and4 ParC12( .A(XaP0), .B(XaP1), .C(XaP2), .D(XaP3), .Y(XaP) ),
   ParC13( .A(YaP0), .B(YaP1), .C(YaP2), .D(YaP3), .Y(YaP) ),
   ParC14( .A(YbP0), .B(YbP1), .C(YbP2), .D(YbP3), .Y(YbP) );
   and3 ParC15( .A(XaP), .B(YaP), .C(YbP), .Y(XYabP) ),
   ParC16( .A(StrobeK0_1), .B(StrobeK2_3), .C(XYabP), .Y(NotPar0) );
   
   inv  ParC17( .A(NotPar0), .Y(ParCheck[0]) ),
   ParC18( .A(XaP), .Y(ParCheck[1]) ),
   ParC19( .A(YaP), .Y(ParCheck[2]) ),
   ParC20( .A(YbP), .Y(ParCheck[3]) );

endmodule // ParityChecker

/********************************************/

module ParityTree10bit( Inbus, ParOut );

   input [9:0] Inbus;
   output      ParOut;

   XOR2a PT0( .A(Inbus[6]), .B(Inbus[7]), .Y(line0) ),
         PT1( .A(Inbus[8]), .B(Inbus[9]), .Y(line1) ),
         PT2( .A(Inbus[2]), .B(Inbus[3]), .Y(line2) ),
         PT3( .A(Inbus[0]), .B(Inbus[1]), .Y(line3) ),
         PT4( .A(Inbus[4]), .B(Inbus[5]), .Y(line4) );
   XOR2a PT5( .A(line0), .B(line1), .Y(line5) );
   XOR3a PT6( .A(line2), .B(line3), .C(line4), .Y(line6) );
   XOR2a PT7( .A(line5), .B(line6), .Y(ParOut) );
   
endmodule // ParityTree10bit

/********************************************/

module ParityTree8bit( Inbus, ParOut );

   input [7:0] Inbus;
   output      ParOut;

   XOR2a PT0( .A(Inbus[0]), .B(Inbus[1]), .Y(line0) ),
         PT1( .A(Inbus[2]), .B(Inbus[3]), .Y(line1) ),
         PT2( .A(Inbus[4]), .B(Inbus[5]), .Y(line2) ),
         PT3( .A(Inbus[6]), .B(Inbus[7]), .Y(line3) );
   XOR3a PT4( .A(line1), .B(line2), .C(line3), .Y(line4) );
   XOR2a PT5( .A(line0), .B(line4), .Y(ParOut) );
   
endmodule // ParityTree8bit


/***************************************************************************
 * Module: Buffer34
 ***************************************************************************/

module Buffer34( Inbus, Outbus );

   input [33:0]	 Inbus;
   output [33:0] Outbus;

   Buffer8 Buf34_0( Inbus[7:0],   Outbus[7:0] ),
           Buf34_1( Inbus[15:8],  Outbus[15:8] ),
           Buf34_2( Inbus[23:16], Outbus[23:16] ),
           Buf34_3( Inbus[31:24], Outbus[31:24] );

   buffer   Buf34_4( .A(Inbus[32]), .Y(Outbus[32]) ),
   Buf34_5( .A(Inbus[33]), .Y(Outbus[33]) );

endmodule // Buffer34

/******************************************************/

module Buffer8( Inbus, Outbus );

   input [7:0]	Inbus;
   output [7:0]	Outbus;

   Buffer4  Buf8_0( Inbus[3:0], Outbus[3:0] ),
            Buf8_1( Inbus[7:4], Outbus[7:4] );

endmodule // Buffer8

/******************************************************/

module Buffer4( Inbus, Outbus );

   input [3:0]	Inbus;
   output [3:0]	Outbus;

   buffer Buf4_0( .A(Inbus[0]), .Y(Outbus[0]) ),
          Buf4_1( .A(Inbus[1]), .Y(Outbus[1]) ),
          Buf4_2( .A(Inbus[2]), .Y(Outbus[2]) ),
          Buf4_3( .A(Inbus[3]), .Y(Outbus[3]) );
   
endmodule // Buffer4


/***************************************************************************
 * Module: MiscLogic
 * 
 * Function: just a random collection of a few gates.
 *
 ***************************************************************************/

module MiscLogic( MiscInbus, MiscOutbus	);

   input [7:0]	MiscInbus;
   output [5:0]	MiscOutbus;

   buffer UM12_0( .A(MiscInbus[0]), .Y(MiscOutbus[0]) );
   and2   UM12_1( .A(MiscInbus[0]), .B(MiscInbus[1]), .Y(MiscOutbus[1]) );
   inv    UM12_2( .A(MiscInbus[2]), .Y(MiscOutbus[2]) );
   and2   UM12_3( .A(MiscInbus[4]), .B(MiscInbus[5]), .Y(line3) );
   inv    UM12_4( .A(MiscInbus[6]), .Y(line4) );
   nand2   UM12_5( .A(line3), .B(line4), .Y(MiscOutbus[3]) );
   nand2   UM12_6( .A(MiscInbus[3]), .B(line4), .Y(MiscOutbus[4]) );
   inv    UM12_7( .A(MiscInbus[7]), .Y(line7) );
   nand2   UM12_8( .A(line7), .B(line4), .Y(MiscOutbus[5]) );

endmodule // MiscLogic



/***************************************************************************
 * Description of some basic gates/modules
 ***************************************************************************/

module Mux2_1( In1, In2, ContIn, Out );

   input  In1, In2, ContIn;
   output Out;

   inv  Mux0( .A(ContIn), .Y(Not_ContIn) );
   and2 Mux1( .A(In1), .B(Not_ContIn), .Y(line1) ),
   Mux2( .A(In2), .B(ContIn), .Y(line2) );
   or2 Mux3( .A(line1), .B(line2), .Y(Out) );
   
endmodule // Mux2_1

/********************************************/

module AND_OR2( O, P, Q, YY);

   input  O, P, Q;
   output YY;
   
   and2 Ao2_0( .A(P), .B(Q), .Y(line0) );
   or2 Ao2_1( .A(O), .B(line0), .Y(YY) );

endmodule // AND_OR2

/******************************************************/

module AND_OR3a( O, P, Q, R, S, YY);

   input  O, P, Q, R, S;
   output YY;
   
   and2 Ao3a_0( .A(P), .B(Q), .Y(line0) );
   and3 Ao3a_1( .A(P), .B(R), .C(S), .Y(line1) );
   or3 Ao3a_2( .A(O), .B(line0), .C(line1), .Y(YY) );

endmodule // AND_OR3a

/******************************************************/

module AND_OR3b( O, P, Q, R, YY);

   input  O, P, Q, R;
   output YY;
   
   and2 Ao3a_0( .A(P), .B(Q), .Y(line0) );
   and2 Ao3a_1( .A(P), .B(R), .Y(line1) );
   or3 Ao3a_2( .A(O), .B(line0), .C(line1), .Y(YY) );

endmodule // AND_OR3b

/******************************************************/

module AND_OR4a( O, P, Q, R, S, T, U, YY);

   input  O, P, Q, R, S, T, U;
   output YY;
   
   and2 Ao4a_0( .A(P), .B(Q), .Y(line0) );
   and3 Ao4a_1( .A(P), .B(R), .C(S), .Y(line1) );
   and4 Ao4a_2( .A(P), .B(R), .C(T), .D(U), .Y(line2) );
   or4 Ao4a_3( .A(O), .B(line0), .C(line1), .D(line2), .Y(YY) );

endmodule // AND_OR4a

/******************************************************/

module AND_OR4b( O, P, Q, R, S, T, YY);

   input  O, P, Q, R, S, T;
   output YY;
   
   and2 Ao4a_0( .A(P), .B(Q), .Y(line0) );
   and3 Ao4a_1( .A(P), .B(R), .C(S), .Y(line1) );
   and3 Ao4a_2( .A(P), .B(R), .C(T), .Y(line2) );
   or4 Ao4a_3( .A(O), .B(line0), .C(line1), .D(line2), .Y(YY) );

endmodule // AND_OR4a

/******************************************************/

module AND_OR5a( O, P, Q, R, S, T, U, V, W, YY);

   input  O, P, Q, R, S, T, U, V, W;
   output YY;
   
   and2 Ao5a_0( .A(P), .B(Q), .Y(line0) );
   and3 Ao5a_1( .A(P), .B(R), .C(S), .Y(line1) );
   and4 Ao5a_2( .A(P), .B(R), .C(T), .D(U), .Y(line2) );
   and5 Ao5a_3( .A(P), .B(R), .C(T), .D(V), .E(W), .Y(line3) );
   or5 Ao5a_4( .A(O), .B(line0), .C(line1), .D(line2), .E(line3), .Y(YY) );

endmodule // AND_OR5a

/******************************************************/

module AND_OR5b( O, P, Q, R, S, T, U, V, YY);

   input  O, P, Q, R, S, T, U, V;
   output YY;
   
   and2 Ao5a_0( .A(P), .B(Q), .Y(line0) );
   and3 Ao5a_1( .A(P), .B(R), .C(S), .Y(line1) );
   and4 Ao5a_2( .A(P), .B(R), .C(T), .D(U), .Y(line2) );
   and4 Ao5a_3( .A(P), .B(R), .C(T), .D(V), .Y(line3) );
   or5 Ao5a_4( .A(O), .B(line0), .C(line1), .D(line2), .E(line3), .Y(YY) );

endmodule // AND_OR5b

/******************************************************/

module AND_OR6a( O, P, Q, R, S, T, U, V, W, X, Y, YY);

   input  O, P, Q, R, S, T, U, V, W, X, Y;
   output YY;
   
   and2 Ao6a_0( .A(P), .B(Q), .Y(line0) );
   and3 Ao6a_1( .A(P), .B(R), .C(S), .Y(line1) );
   and4 Ao6a_2( .A(P), .B(R), .C(T), .D(U), .Y(line2) );
   and5 Ao6a_3( .A(P), .B(R), .C(T), .D(V), .E(W), .Y(line3) );
   and6 Ao6a_4( .A(P), .B(R), .C(T), .D(V), .E(X), .F(Y), .Y(line4) );
   or6 Ao6a_5( .A(O), .B(line0), .C(line1), .D(line2), .E(line3),
	       .F(line4), .Y(YY) );

endmodule // AND_OR6a

/******************************************************/

module AND_OR6b( O, P, Q, R, S, T, U, V, W, X, YY);

   input  O, P, Q, R, S, T, U, V, W, X;
   output YY;
   
   and2 Ao6a_0( .A(P), .B(Q), .Y(line0) );
   and3 Ao6a_1( .A(P), .B(R), .C(S), .Y(line1) );
   and4 Ao6a_2( .A(P), .B(R), .C(T), .D(U), .Y(line2) );
   and5 Ao6a_3( .A(P), .B(R), .C(T), .D(V), .E(W), .Y(line3) );
   and5 Ao6a_4( .A(P), .B(R), .C(T), .D(V), .E(X), .Y(line4) );
   or6 Ao6a_5( .A(O), .B(line0), .C(line1), .D(line2), .E(line3),
	       .F(line4), .Y(YY) );

endmodule // AND_OR6b

/********************************************/

module XOR2a ( A, B, Y );

   input  A, B;
   output Y;

   inv  Xo0( .A(A), .Y(NotA) ),
   Xo1( .A(B), .Y(NotB) );
   
   nand2 Xo2( .A(NotA), .B(B), .Y(line2) ),
   Xo3( .A(NotB), .B(A), .Y(line3) ),
   Xo4( .A(line2), .B(line3), .Y(Y) );
   
endmodule // XOR2a

/********************************************/

module XOR3a( A, B, C, Y);

   input  A, B, C;
   output Y;
   
   inv  Xo3_0( .A(A), .Y(NotA) ),
   Xo3_1( .A(B), .Y(NotB) ),
   Xo3_2( .A(C), .Y(NotC) );
   and3 Xo3_3( .A(NotA), .B(NotB), .C(C), .Y(line3) ),
   Xo3_4( .A(NotA), .B(B), .C(NotC), .Y(line4) ),
   Xo3_5( .A(A), .B(NotB), .C(NotC), .Y(line5) ),
   Xo3_6( .A(A), .B(B), .C(C), .Y(line6) );
   nor2 Xo3_7( .A(line3), .B(line4), .Y(line7) ),
   Xo3_8( .A(line5), .B(line6), .Y(line8) );
   nand2 Xo3_9( .A(line7), .B(line8), .Y(Y) );

endmodule // XOR3a
