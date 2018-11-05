
/******************************************************/

module AND_OR4b( O, P, Q, R, S, T, YY);

   input  O, P, Q, R, S, T;
   output YY;
   
   and2 Ao4a_0( .A(P), .B(Q), .Y(line0) );
   and3 Ao4a_1( .A(P), .B(R), .C(S), .Y(line1) );
   and3 Ao4a_2( .A(P), .B(R), .C(T), .Y(line2) );
   or4  Ao4a_3( .A(O), .B(line0), .C(line1), .D(line2), .Y(YY) );

endmodule // AND_OR4a


/******************************************************/

module AND_OR3a( O, P, Q, R, S, YY);

   input  O, P, Q, R, S;
   output YY;
   
   and2 Ao3a_0( .A(P), .B(Q), .Y(line0) );
   and3 Ao3a_1( .A(P), .B(R), .C(S), .Y(line1) );
   or3  Ao3a_2( .A(O), .B(line0), .C(line1), .Y(YY) );

endmodule // AND_OR3a


/******************************************************/

module AND_OR2( O, P, Q, YY);

   input  O, P, Q;
   output YY;
   
   and2 Ao2_0( .A(P), .B(Q), .Y(line0) );
   or2  Ao2_1( .A(O), .B(line0), .Y(YY) );

endmodule // AND_OR2


/******************************************************/

module XOR2a ( A, B, Y );

   input  A, B;
   output Y;

   inv   Xo0( .A(A), .Y(NotA) ),
   Xo1( .A(B), .Y(NotB) );
   
   nand2 Xo2( .A(NotA), .B(B), .Y(line2) ),
   Xo3( .A(NotB), .B(A), .Y(line3) ),
   Xo4( .A(line2), .B(line3), .Y(Y) );
   
endmodule // XOR2a


/******************************************************/

module AND_OR3b( O, P, Q, R, YY);

   input  O, P, Q, R;
   output YY;
   
   and2 Ao3a_0( .A(P), .B(Q), .Y(line0) );
   and2 Ao3a_1( .A(P), .B(R), .Y(line1) );
   or3  Ao3a_2( .A(O), .B(line0), .C(line1), .Y(YY) );

endmodule // AND_OR3b


/******************************************************/

module AND_OR5b( O, P, Q, R, S, T, U, V, YY);

   input  O, P, Q, R, S, T, U, V;
   output YY;
   
   and2 Ao5a_0( .A(P), .B(Q), .Y(line0) );
   and3 Ao5a_1( .A(P), .B(R), .C(S), .Y(line1) );
   and4 Ao5a_2( .A(P), .B(R), .C(T), .D(U), .Y(line2) );
   and4 Ao5a_3( .A(P), .B(R), .C(T), .D(V), .Y(line3) );
   or5  Ao5a_4( .A(O), .B(line0), .C(line1), .D(line2), .E(line3), .Y(YY) );

endmodule // AND_OR5b


/******************************************************/

module GenLocalCarry3( Gbus, Pbus, LocalC0, LocalC1 );

   input [2:0]	Gbus, Pbus;
   output [2:0]	LocalC0, LocalC1;
   
   
// LocalC0[0] = Gbus[0]
   buffer addedBuf6 (.A(Gbus[0]), .Y(LocalC0[0]));

   or2 GLC4_0( .A(Gbus[0]), .B(Pbus[0]), .Y(LocalC1[0]) );

   AND_OR2  GLC4_1( Gbus[1], Pbus[1], Gbus[0], LocalC0[1] );
   AND_OR3b GLC4_2( Gbus[1], Pbus[1], Gbus[0], Pbus[0], LocalC1[1] );

   AND_OR3a GLC4_3( Gbus[2], Pbus[2], Gbus[1], Pbus[1], Gbus[0],
		    LocalC0[2] );
   AND_OR4b GLC4_4( Gbus[2], Pbus[2], Gbus[1], Pbus[1], Gbus[0],
		    Pbus[0], LocalC1[2] );

endmodule // GenLocalCarry3


/********************************************/

module Mux2_1( In0, In1, ContIn, Out );

   input  In0, In1, ContIn;
   output Out;

   inv  Mux2_0( .A(ContIn), .Y(Not_ContIn) );
   and2 Mux2_1( .A(In0), .B(Not_ContIn), .Y(line1) ),
   Mux2_2( .A(In1), .B(ContIn), .Y(line2) );
   or2 Mux2_3( .A(line1), .B(line2), .Y(Out) );
   
endmodule // Mux2_1


/******************************************************/

module SerialParity7nc( Inbus, Out);

   input [6:0] Inbus;
   output      Out;
   
   XOR2a SP7nc0( .A(Inbus[0]), .B(Inbus[1]), .Y(line0) ),
   SP7nc1( .A(Inbus[2]), .B(line0), .Y(line1) ),
   SP7nc2( .A(Inbus[3]), .B(line1), .Y(line2) ),
   SP7nc3( .A(Inbus[4]), .B(line2), .Y(line3) ),
   SP7nc4( .A(Inbus[5]), .B(line3), .Y(line4) ),
   SP7nc5( .A(Inbus[6]), .B(line4), .Y(Out) );

endmodule // SerialParity7nc


/******************************************************/

module AND_OR4a( O, P, Q, R, S, T, U, YY);

   input  O, P, Q, R, S, T, U;
   output YY;
   
   and2 Ao4a_0( .A(P), .B(Q), .Y(line0) );
   and3 Ao4a_1( .A(P), .B(R), .C(S), .Y(line1) );
   and4 Ao4a_2( .A(P), .B(R), .C(T), .D(U), .Y(line2) );
   or4  Ao4a_3( .A(O), .B(line0), .C(line1), .D(line2), .Y(YY) );

endmodule // AND_OR4a


/********************************************/

module Mux4_1( In0, In1, In2, In3, ContHi, ContLo, Out );

   input  In0, In1, In2, In3, ContHi, ContLo;
   output Out;

   inv  Mux4_0( .A(ContLo), .Y(Not_ContLo) ),
   Mux4_1( .A(ContHi), .Y(Not_ContHi) );
   and3 Mux4_2( .A(In0), .B(Not_ContHi), .C(Not_ContLo), .Y(line2) ),
   Mux4_3( .A(In1), .B(Not_ContHi), .C(ContLo), .Y(line3) ),
   Mux4_4( .A(In2), .B(ContHi), .C(Not_ContLo), .Y(line4) ),
   Mux4_5( .A(In3), .B(ContHi), .C(ContLo), .Y(line5) );
   or4 Mux4_6( .A(line2), .B(line3), .C(line4), .D(line5), .Y(Out) );
   
endmodule // Mux4_1


/********************************************/

module XOR3a( A, B, C, Y);

   input  A, B, C;
   output Y;
   
   inv   Xo3_0( .A(A), .Y(NotA) ),
   Xo3_1( .A(B), .Y(NotB) ),
   Xo3_2( .A(C), .Y(NotC) );
   and3  Xo3_3( .A(NotA), .B(NotB), .C(C), .Y(line3) ),
   Xo3_4( .A(NotA), .B(B), .C(NotC), .Y(line4) ),
   Xo3_5( .A(A), .B(NotB), .C(NotC), .Y(line5) ),
   Xo3_6( .A(A), .B(B), .C(C), .Y(line6) );
   nor2  Xo3_7( .A(line3), .B(line4), .Y(line7) ),
   Xo3_8( .A(line5), .B(line6), .Y(line8) );
   nand2 Xo3_9( .A(line7), .B(line8), .Y(Y) );

endmodule // XOR3a


/******************************************************/

module SerialParity7c( Inbus, Out);

   input [6:0] Inbus;
   output      Out;
   
   wire [6:0]  NewInbus;

   // invert one bit to complement the output
   // -- Inbus[6] is chosen so the inverter is not on the longest path

   inv  SP7c0( .A(Inbus[6]), .Y(NewInbus[6]) );
   
// NewInbus[5:0] = Inbus[5:0]
   buffer addedBuf0 (.A(Inbus[5]), .Y(NewInbus[5]));
   buffer addedBuf1 (.A(Inbus[4]), .Y(NewInbus[4]));
   buffer addedBuf2 (.A(Inbus[3]), .Y(NewInbus[3]));
   buffer addedBuf3 (.A(Inbus[2]), .Y(NewInbus[2]));
   buffer addedBuf4 (.A(Inbus[1]), .Y(NewInbus[1]));
   buffer addedBuf5 (.A(Inbus[0]), .Y(NewInbus[0]));


   SerialParity7nc SP7c2( NewInbus, Out );

endmodule // SerialParity7c


/******************************************************/

module AND_OR6b( O, P, Q, R, S, T, U, V, W, X, YY);

   input  O, P, Q, R, S, T, U, V, W, X;
   output YY;
   
   and2 Ao6a_0( .A(P), .B(Q), .Y(line0) );
   and3 Ao6a_1( .A(P), .B(R), .C(S), .Y(line1) );
   and4 Ao6a_2( .A(P), .B(R), .C(T), .D(U), .Y(line2) );
   and5 Ao6a_3( .A(P), .B(R), .C(T), .D(V), .E(W), .Y(line3) );
   and5 Ao6a_4( .A(P), .B(R), .C(T), .D(V), .E(X), .Y(line4) );
   or6  Ao6a_5( .A(O), .B(line0), .C(line1), .D(line2), .E(line3),
		.F(line4), .Y(YY) );

endmodule // AND_OR6b


/******************************************************/

module GenLocalCarry4( Gbus, Pbus, LocalC0, LocalC1 );

   input [3:0]	Gbus, Pbus;
   output [3:0]	LocalC0, LocalC1;
   
   GenLocalCarry3 GLC4_0( Gbus[2:0], Pbus[2:0],
			  LocalC0[2:0], LocalC1[2:0] );

   AND_OR4a GLC4_1( Gbus[3], Pbus[3], Gbus[2], Pbus[2], Gbus[1],
		    Pbus[1], Gbus[0], LocalC0[3] );
   AND_OR5b GLC4_2( Gbus[3], Pbus[3], Gbus[2], Pbus[2], Gbus[1],
		    Pbus[1], Gbus[0], Pbus[0], LocalC1[3] );

endmodule // GenLocalCarry4


/******************************************************/

module AND_OR5a( O, P, Q, R, S, T, U, V, W, YY);

   input  O, P, Q, R, S, T, U, V, W;
   output YY;
   
   and2 Ao5a_0( .A(P), .B(Q), .Y(line0) );
   and3 Ao5a_1( .A(P), .B(R), .C(S), .Y(line1) );
   and4 Ao5a_2( .A(P), .B(R), .C(T), .D(U), .Y(line2) );
   and5 Ao5a_3( .A(P), .B(R), .C(T), .D(V), .E(W), .Y(line3) );
   or5  Ao5a_4( .A(O), .B(line0), .C(line1), .D(line2), .E(line3), .Y(YY) );

endmodule // AND_OR5a


/********************************************
 * LogicBlock: implements all 16 functions of
 *  In1 and In2 as selected by the 4-bit
 *  ContLogic input.
 ********************************************/

module LogicBlock( In1, In2, ContLogic, Out );

   input       In1, In2;
   input [3:0] ContLogic;
   output      Out;

   Mux2_1 LB0( ContLogic[0], ContLogic[1], In1, line0),
   LB1( ContLogic[2], ContLogic[3], In1, line1);
   or2    LB2( .A(In2), .B(line0), .Y(line2) );
   nand2    LB3( .A(In2), .B(line1), .Y(line3) );
   and2    LB4( .A(line2), .B(line3), .Y(Out) );

endmodule // LogicBlock


/******************************************************/

module SerialParity9nc( Inbus, Out);

   input [8:0] Inbus;
   output      Out;
   
   SerialParity7nc SP9nc0( Inbus[6:0], line0 );
   XOR2a           SP9nc1( .A(Inbus[7]), .B(line0), .Y(line1) ),
   SP9nc2( .A(Inbus[8]), .B(line1), .Y(Out) );

endmodule // SerialParity9nc


/********************************************/

module Muxes4( InM1, InM2, In1, In2, In3, In4, MuxSelbus,
	       Out1, Out2, Out3, Out4 );

   input       InM1, InM2, In1, In2, In3, In4;
   input [8:0] MuxSelbus;
   output      Out1, Out2, Out3, Out4;

   Mux4_1 MXS0( InM1, InM2, In1, In2, MuxSelbus[1], MuxSelbus[0], tempOut1 ),
   MXS1( InM1, InM2, In1, In2, MuxSelbus[3], MuxSelbus[2], tempOut2 ),
   MXS2( InM1, InM2, In3, In4, MuxSelbus[5], MuxSelbus[4], Out3 ),
   MXS3( InM1, InM2, In3, In4, MuxSelbus[7], MuxSelbus[6], Out4 );

   and2   MXS4( .A(tempOut1), .B(MuxSelbus[8]), .Y(Out1) ),
   MXS5( .A(tempOut2), .B(MuxSelbus[8]), .Y(Out2) );

endmodule // Muxes4


/********************************************/

module ParityTree9bit( Inbus, ParOut );

   input [8:0] Inbus;
   output      ParOut;

   XOR2a PT1( .A(Inbus[5]), .B(Inbus[6]), .Y(line1) ),
   PT2( .A(Inbus[7]), .B(Inbus[8]), .Y(line2) ),
   PT3( .A(Inbus[1]), .B(Inbus[2]), .Y(line3) ),
   PT4( .A(Inbus[3]), .B(Inbus[4]), .Y(line4) );
   XOR2a PT5( .A(line1), .B(line2), .Y(line5) );
   XOR3a PT6( .A(line3), .B(Inbus[0]), .C(line4), .Y(line6) );
   XOR2a PT7( .A(line5), .B(line6), .Y(ParOut) );
   
endmodule // ParityTree9bit


/********************************************/

module XOR2a6bit( In1bus, In2bus, Outbus );
   
   input [5:0]	In1bus, In2bus;
   output [5:0]	Outbus;
   
   XOR2a X2a6_0( .A(In1bus[0]), .B(In2bus[0]), .Y(Outbus[0]) ),
   X2a6_1( .A(In1bus[1]), .B(In2bus[1]), .Y(Outbus[1]) ),
   X2a6_2( .A(In1bus[2]), .B(In2bus[2]), .Y(Outbus[2]) ),
   X2a6_3( .A(In1bus[3]), .B(In2bus[3]), .Y(Outbus[3]) ),
   X2a6_4( .A(In1bus[4]), .B(In2bus[4]), .Y(Outbus[4]) ),
   X2a6_5( .A(In1bus[5]), .B(In2bus[5]), .Y(Outbus[5]) );
   
endmodule // XOR2a6bit


/******************************************************/

module SerialParity9c( Inbus, Out);

   input [8:0] Inbus;
   output      Out;
   
   // Inbus[6] is inverted in SerialParity7c
   SerialParity7c SP9nc0( Inbus[6:0], line0 );
   XOR2a          SP9nc1( .A(Inbus[7]), .B(line0), .Y(line1) ),
   SP9nc2( .A(Inbus[8]), .B(line1), .Y(Out) );

endmodule // SerialParity9c


/******************************************************/

module XOR2b ( A, B, Y );

   input  A, B;
   output Y;

   nand2 Xo0( .A(A), .B(B), .Y(NotAB) );
   and2  Xo1( .A(A), .B(NotAB), .Y(line1) ),
   Xo2( .A(NotAB), .B(B), .Y(line2) );
   or2   Xo3( .A(line1), .B(line2), .Y(Y) );
   
endmodule // XOR2b


/********************************************/

module Invert4( Inbus, Outbus );

   input [3:0]	Inbus;
   output [3:0]	Outbus;

   inv Inv4_0( .A(Inbus[0]), .Y(Outbus[0]) ),
   Inv4_1( .A(Inbus[1]), .Y(Outbus[1]) ),
   Inv4_2( .A(Inbus[2]), .Y(Outbus[2]) ),
   Inv4_3( .A(Inbus[3]), .Y(Outbus[3]) );
   
endmodule // Invert4


/********************************************/

module ComputeLogic( In1bus, In2bus, ContLogicIn, Outbus );

   input [8:0]	In1bus, In2bus;
   input [35:0]	ContLogicIn;
   output [8:0]	Outbus;

   LogicBlock CL0( In1bus[0], In2bus[0], ContLogicIn[3:0],   Outbus[0] ),
   CL1( In1bus[1], In2bus[1], ContLogicIn[7:4],   Outbus[1] ),
   CL2( In1bus[2], In2bus[2], ContLogicIn[11:8],  Outbus[2] ),
   CL3( In1bus[3], In2bus[3], ContLogicIn[15:12], Outbus[3] ),
   CL4( In1bus[4], In2bus[4], ContLogicIn[19:16], Outbus[4] ),
   CL5( In1bus[5], In2bus[5], ContLogicIn[23:20], Outbus[5] ),
   CL6( In1bus[6], In2bus[6], ContLogicIn[27:24], Outbus[6] ),
   CL7( In1bus[7], In2bus[7], ContLogicIn[31:28], Outbus[7] ),
   CL8( In1bus[8], In2bus[8], ContLogicIn[35:32], Outbus[8] );
   
endmodule // ComputeLogic


/********************************************/

module Mux4bit_2_1( In0, In1, ContIn, Out );
   input [3:0]	In0, In1;
   input	ContIn;
   output [3:0]	Out;

   Mux2_1 Mux4_0( In0[0], In1[0], ContIn, Out[0] ),
   Mux4_1( In0[1], In1[1], ContIn, Out[1] ),
   Mux4_2( In0[2], In1[2], ContIn, Out[2] ),
   Mux4_3( In0[3], In1[3], ContIn, Out[3] );

endmodule // Mux4bit_2_1


/********************************************/

module GenProp9( In1bus, In2bus, Gbus, Pbus);

   input [8:0]	In1bus, In2bus;
   output [8:0]	Gbus, Pbus;

   and2  GP9_0( .A(In1bus[0]), .B(In2bus[0]), .Y(Gbus[0]) ),
   GP9_1( .A(In1bus[1]), .B(In2bus[1]), .Y(Gbus[1]) ),
   GP9_2( .A(In1bus[2]), .B(In2bus[2]), .Y(Gbus[2]) ),
   GP9_3( .A(In1bus[3]), .B(In2bus[3]), .Y(Gbus[3]) ),
   GP9_4( .A(In1bus[4]), .B(In2bus[4]), .Y(Gbus[4]) ),
   GP9_5( .A(In1bus[5]), .B(In2bus[5]), .Y(Gbus[5]) ),
   GP9_6( .A(In1bus[6]), .B(In2bus[6]), .Y(Gbus[6]) ),
   GP9_7( .A(In1bus[7]), .B(In2bus[7]), .Y(Gbus[7]) ),
   GP9_8( .A(In1bus[8]), .B(In2bus[8]), .Y(Gbus[8]) );
   
   XOR2a GP9_9( .A(In1bus[0]), .B(In2bus[0]), .Y(Pbus[0]) ),
   GP9_10( .A(In1bus[1]), .B(In2bus[1]), .Y(Pbus[1]) ),
   GP9_11( .A(In1bus[2]), .B(In2bus[2]), .Y(Pbus[2]) ),
   GP9_12( .A(In1bus[3]), .B(In2bus[3]), .Y(Pbus[3]) ),
   GP9_13( .A(In1bus[4]), .B(In2bus[4]), .Y(Pbus[4]) ),
   GP9_14( .A(In1bus[5]), .B(In2bus[5]), .Y(Pbus[5]) ),
   GP9_15( .A(In1bus[6]), .B(In2bus[6]), .Y(Pbus[6]) ),
   GP9_16( .A(In1bus[7]), .B(In2bus[7]), .Y(Pbus[7]) ),
   GP9_17( .A(In1bus[8]), .B(In2bus[8]), .Y(Pbus[8]) );   

endmodule // GenProp9


/********************************************/

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


/********************************************/

module CLAblock( Gbus, Pbus, Cin, Carry, Cout_in0, PropThru );

   input [8:0]	Gbus, Pbus;
   input	Cin;
   output [4:0]	Carry;
   output	Cout_in0, PropThru;
   
   wire		LocalC0_4;

   // actual carry lines #0-3
   AND_OR2  CB0( Gbus[0], Pbus[0], Cin, Carry[0] );
   AND_OR3a CB1( Gbus[1], Pbus[1], Gbus[0], Pbus[0], Cin, Carry[1] );
   AND_OR4a CB2( Gbus[2], Pbus[2], Gbus[1], Pbus[1], Gbus[0],
		 Pbus[0], Cin, Carry[2] );
   AND_OR5a CB3( Gbus[3], Pbus[3], Gbus[2], Pbus[2], Gbus[1], Pbus[1],
		 Gbus[0], Pbus[0], Cin, Carry[3] );

   // LocalC0_4 is the carry out of bit #4 with Cin=0
   AND_OR5a CB4( Gbus[4], Pbus[4], Gbus[3], Pbus[3], Gbus[2], Pbus[2],
		 Gbus[1], Pbus[1], Gbus[0], LocalC0_4 );

   and5      CB5( .A(Pbus[0]), .B(Pbus[1]), .C(Pbus[2]),
		  .D(Pbus[3]), .E(Pbus[4]), .Y(Prop4_0) );
   and2      CB6( .A(Cin), .B(Prop4_0), .Y(PropCin) );
   or2      CB7( .A(LocalC0_4), .B(PropCin), .Y(Carry[4]) );

   // now Cout_in0 (the carryout line for the entire operation with Cin=0)
   AND_OR5a CB8( Gbus[8], Pbus[8], Gbus[7], Pbus[7], Gbus[6], Pbus[6],
		 Gbus[5], Pbus[5], LocalC0_4, Cout_in0 );

   // Propthr: and of all propagate lines
   and4 CB9( .A(Pbus[5]), .B(Pbus[6]), .C(Pbus[7]), .D(Pbus[8]),
	     .Y(Prop8_5) );
   and2 CB10( .A(Prop4_0), .B(Prop8_5), .Y(PropThru) );

endmodule // CLAblock


/********************************************/

module Buffer7( Inbus, Outbus );

   input [6:0]	Inbus;
   output [6:0]	Outbus;
   
   buffer B7_0( .A(Inbus[0]), .Y(Outbus[0]) ),
   B7_1( .A(Inbus[1]), .Y(Outbus[1]) ),
   B7_2( .A(Inbus[2]), .Y(Outbus[2]) ),
   B7_3( .A(Inbus[3]), .Y(Outbus[3]) ),
   B7_4( .A(Inbus[4]), .Y(Outbus[4]) ),
   B7_5( .A(Inbus[5]), .Y(Outbus[5]) ),
   B7_6( .A(Inbus[6]), .Y(Outbus[6]) );
   
endmodule // Buffer7


/******************************************************/

module Mask_And4bit( Inbus, Mask, Outbus );

   input [3:0]	Inbus;
   input	Mask;
   output [3:0]	Outbus;

   and2 Ma0( .A(Inbus[0]), .B(Mask), .Y(Outbus[0]) ),
   Ma1( .A(Inbus[1]), .B(Mask), .Y(Outbus[1]) ),
   Ma2( .A(Inbus[2]), .B(Mask), .Y(Outbus[2]) ),
   Ma3( .A(Inbus[3]), .B(Mask), .Y(Outbus[3]) );
   
endmodule // AND4bit


/********************************************/

module Mux4bit_4_1( In1bus, In2bus, In3bus, In4bus,
		    ContHi, ContLo, Outbus );
   
   input [3:0]	In1bus, In2bus, In3bus, In4bus;
   input	ContHi, ContLo;
   output [3:0]	Outbus;
   
   Mux4_1 Mx4_0( In1bus[0], In2bus[0], In3bus[0], In4bus[0],
		 ContHi, ContLo, Outbus[0] ),
   Mx4_1( In1bus[1], In2bus[1], In3bus[1], In4bus[1],
	  ContHi, ContLo, Outbus[1] ),
   Mx4_2( In1bus[2], In2bus[2], In3bus[2], In4bus[2],
	  ContHi, ContLo, Outbus[2] ),
   Mx4_3( In1bus[3], In2bus[3], In3bus[3], In4bus[3],
	  ContHi, ContLo, Outbus[3] );

endmodule // Mux4bit_4_1


/***********************************************************************
 * Submodule: SumParity
 * 
 * Function: calculates the parity of the sum (In1bus + In2bus + Cin)
 * 
 *  The parity is calculated separately for the lower 5-bit block
 *  and the upper 4-bit block. In each case, two parities are calculated:
 *  one with an assumed carry of 0 to that block, and another with 1.
 *  For the 5-bit block, the correct parity is determined by Cin.
 *  For the 4-bit block, the carry input Cin as well as the carry from
 *  the (lower) 5-bit block to the (higher) 4-bit block determine
 *  the correct parity.
 * 
 ************************************************************************/

module SumParity( In1bus, In2bus, Cin, SumPar );

   input [8:0] In1bus, In2bus;
   input       Cin;
   output      SumPar;

   wire [8:0]  Genbus, Propbus;
   wire [8:0]  LocalC0, LocalC1;

   GenProp9       SP0( In1bus, In2bus, Genbus, Propbus );

   // first caculate the local carries
   //  (local carries in 8th position are not needed)

   GenLocalCarry5 SP1( Genbus[4:0], Propbus[4:0], LocalC0[4:0], LocalC1[4:0] );
   GenLocalCarry3 SP2( Genbus[7:5], Propbus[7:5], LocalC0[7:5], LocalC1[7:5] );   

   SerialParity9nc SP3( { Propbus[4:0], LocalC0[3:0] }, ParLo0 );
   SerialParity9c  SP4( { Propbus[4:0], LocalC1[3:0] }, ParLo1 );
   SerialParity7nc SP5( { Propbus[8:5], LocalC0[7:5] }, ParHi0 );
   SerialParity7c  SP6( { Propbus[8:5], LocalC1[7:5] }, ParHi1 );

   Mux2_1 SP7( ParLo0, ParLo1, Cin, ParLo),
   SP8( ParHi0, ParHi1, LocalC0[4], ParHiCin0),
   SP9( ParHi0, ParHi1, LocalC1[4], ParHiCin1),
   SP10( ParHiCin0, ParHiCin1, Cin, ParHi);

   XOR2a  SP11( .A(ParLo), .B(ParHi), .Y(SumPar) );

endmodule // SumParity


/********************************************/

module MiscRandomLogic( NewMiscbus, ContParChk, MiscContIn, ContBeta, MiscOutbus );

   input [15:0]	 NewMiscbus;
   input [5:0]	 ContParChk;
   input [7:0]	 MiscContIn;
   input	 ContBeta;
   output [25:0] MiscOutbus;

   // NewMiscbus: { X1bus3_0, X1bus_8, X0bus_8, MuxSelPF_8, MiscInbus }
   //                 15-12      11       10       9            8-0

   nand2   MRL0( .A(ContBeta), .B(NewMiscbus[0]), .Y(MiscOutbus[0]) );

   inv    MRL1( .A(NewMiscbus[1]), .Y(NotMisc1) );
   and2   MRL2( .A(NotMisc1), .B(MiscContIn[0]), .Y(line2) );
   inv    MRL3( .A(line2), .Y(MiscOutbus[1]) );

   and2   MRL4( .A(MiscContIn[3]), .B(NewMiscbus[2]), .Y(MiscOutbus[2]) );

   nand2   MRL5( .A(NewMiscbus[3]), .B(NewMiscbus[4]), .Y(line6) );
   inv    MRL6( .A(line6), .Y(MiscOutbus[3]) );

   inv    MRL7( .A(NewMiscbus[6]), .Y(NotMisc6) );
   and2   MRL8( .A(NewMiscbus[5]), .B(NotMisc6), .Y(MiscOutbus[4]) );

   and2   MRL9( .A(ContParChk[0]), .B(ContParChk[2]), .Y(line12) );
   inv    MRL10( .A(line12), .Y(MiscOutbus[5]) );

   and2   MRL11( .A(ContParChk[3]), .B(ContParChk[5]), .Y(MiscOutbus[6]) );

   Buffer7 MRL12( { NewMiscbus[11:9], NewMiscbus[7:6], NewMiscbus[4],
		    MiscContIn[3] }, MiscOutbus[13:7] );
   Invert4 MRL13( { ContParChk[5:3], ContParChk[1] }, MiscOutbus[17:14] );

   Invert4 MRL14( NewMiscbus[15:12], MiscOutbus[21:18] );

   Invert4 MRL15( { NewMiscbus[11], NewMiscbus[8:7], ContBeta },
		  MiscOutbus[25:22] );

endmodule // MiscRandomLogic


/********************************************/

module LogicParity( XYlogicbus, ABlogicbus, ContLogicPar, LogicPar );

   input [8:0] XYlogicbus, ABlogicbus;
   input [3:0] ContLogicPar;
   output      LogicPar;

   wire [35:0] ContLogicIn;
   wire [8:0]  LogicOut;
   
   
// ContLogicIn[35:0] = { ContLogicPar[3:0], ContLogicPar[3:0], ContLogicPar[3:0],
//			    ContLogicPar[3:0], ContLogicPar[3:0], ContLogicPar[3:0],
//			    ContLogicPar[3:0], ContLogicPar[3:0], ContLogicPar[3:0] }
   buffer addedBuf7 (.A(ContLogicPar[3]), .Y(ContLogicIn[35]));
   buffer addedBuf8 (.A(ContLogicPar[2]), .Y(ContLogicIn[34]));
   buffer addedBuf9 (.A(ContLogicPar[1]), .Y(ContLogicIn[33]));
   buffer addedBuf10 (.A(ContLogicPar[0]), .Y(ContLogicIn[32]));
   buffer addedBuf11 (.A(ContLogicPar[3]), .Y(ContLogicIn[31]));
   buffer addedBuf12 (.A(ContLogicPar[2]), .Y(ContLogicIn[30]));
   buffer addedBuf13 (.A(ContLogicPar[1]), .Y(ContLogicIn[29]));
   buffer addedBuf14 (.A(ContLogicPar[0]), .Y(ContLogicIn[28]));
   buffer addedBuf15 (.A(ContLogicPar[3]), .Y(ContLogicIn[27]));
   buffer addedBuf16 (.A(ContLogicPar[2]), .Y(ContLogicIn[26]));
   buffer addedBuf17 (.A(ContLogicPar[1]), .Y(ContLogicIn[25]));
   buffer addedBuf18 (.A(ContLogicPar[0]), .Y(ContLogicIn[24]));
   buffer addedBuf19 (.A(ContLogicPar[3]), .Y(ContLogicIn[23]));
   buffer addedBuf20 (.A(ContLogicPar[2]), .Y(ContLogicIn[22]));
   buffer addedBuf21 (.A(ContLogicPar[1]), .Y(ContLogicIn[21]));
   buffer addedBuf22 (.A(ContLogicPar[0]), .Y(ContLogicIn[20]));
   buffer addedBuf23 (.A(ContLogicPar[3]), .Y(ContLogicIn[19]));
   buffer addedBuf24 (.A(ContLogicPar[2]), .Y(ContLogicIn[18]));
   buffer addedBuf25 (.A(ContLogicPar[1]), .Y(ContLogicIn[17]));
   buffer addedBuf26 (.A(ContLogicPar[0]), .Y(ContLogicIn[16]));
   buffer addedBuf27 (.A(ContLogicPar[3]), .Y(ContLogicIn[15]));
   buffer addedBuf28 (.A(ContLogicPar[2]), .Y(ContLogicIn[14]));
   buffer addedBuf29 (.A(ContLogicPar[1]), .Y(ContLogicIn[13]));
   buffer addedBuf30 (.A(ContLogicPar[0]), .Y(ContLogicIn[12]));
   buffer addedBuf31 (.A(ContLogicPar[3]), .Y(ContLogicIn[11]));
   buffer addedBuf32 (.A(ContLogicPar[2]), .Y(ContLogicIn[10]));
   buffer addedBuf33 (.A(ContLogicPar[1]), .Y(ContLogicIn[9]));
   buffer addedBuf34 (.A(ContLogicPar[0]), .Y(ContLogicIn[8]));
   buffer addedBuf35 (.A(ContLogicPar[3]), .Y(ContLogicIn[7]));
   buffer addedBuf36 (.A(ContLogicPar[2]), .Y(ContLogicIn[6]));
   buffer addedBuf37 (.A(ContLogicPar[1]), .Y(ContLogicIn[5]));
   buffer addedBuf38 (.A(ContLogicPar[0]), .Y(ContLogicIn[4]));
   buffer addedBuf39 (.A(ContLogicPar[3]), .Y(ContLogicIn[3]));
   buffer addedBuf40 (.A(ContLogicPar[2]), .Y(ContLogicIn[2]));
   buffer addedBuf41 (.A(ContLogicPar[1]), .Y(ContLogicIn[1]));
   buffer addedBuf42 (.A(ContLogicPar[0]), .Y(ContLogicIn[0]));

   
   ComputeLogic   LP0( XYlogicbus, ABlogicbus, ContLogicIn, LogicOut );

   ParityTree9bit LP1( LogicOut, LogicPar );

endmodule // LogicParity


/********************************************/

module NOR9(In, Out);

   input [8:0] In;
   output      Out;

   nor9 n9(.A(In[0]), .B(In[1]), .C(In[2]), .D(In[3]), .E(In[4]), .F(In[5]),
	   .G(In[6]), .H(In[7]), .I(In[8]), .Y(Out) );

endmodule // NOR9


/********************************************/

module Mux9bit_4_1( In1bus, In2bus, In3bus, In4bus,
		    ContHi, ContLo, Outbus );
   
   input [8:0]	In1bus, In2bus, In3bus, In4bus;
   input	ContHi, ContLo;
   output [8:0]	Outbus;
   
   Mux4bit_4_1 Mx9_0( In1bus[3:0], In2bus[3:0], In3bus[3:0], In4bus[3:0],
		      ContHi, ContLo, Outbus[3:0] ),
   Mx9_1( In1bus[7:4], In2bus[7:4], In3bus[7:4], In4bus[7:4],
	  ContHi, ContLo, Outbus[7:4] );
   Mux4_1      Mx9_2( In1bus[8], In2bus[8], In3bus[8], In4bus[8],
		      ContHi, ContLo, Outbus[8] );

endmodule // Mux9bit_4_1


/********************************************/

module MuxesF4bit_4( FXbus, FYbus, QF1bus, QF2bus, QF3bus, QF4bus, MuxSelbus,
		     OF1bus, OF2bus, OF3bus, OF4bus );

   input [3:0]	FXbus, FYbus, QF1bus, QF2bus, QF3bus, QF4bus;
   input [8:0]	MuxSelbus;
   output [3:0]	OF1bus, OF2bus, OF3bus, OF4bus;

   Muxes4 MF4_0( FXbus[0], FYbus[0], QF1bus[0], QF2bus[0],
		 QF3bus[0], QF4bus[0], MuxSelbus[8:0],
		 OF1bus[0], OF2bus[0], OF3bus[0], OF4bus[0] ),
   MF4_1( FXbus[1], FYbus[1], QF1bus[1], QF2bus[1],
	  QF3bus[1], QF4bus[1], MuxSelbus[8:0],
	  OF1bus[1], OF2bus[1], OF3bus[1], OF4bus[1] ),
   MF4_2( FXbus[2], FYbus[2], QF1bus[2], QF2bus[2],
	  QF3bus[2], QF4bus[2], MuxSelbus[8:0],
	  OF1bus[2], OF2bus[2], OF3bus[2], OF4bus[2] ),
   MF8_3( FXbus[3], FYbus[3], QF1bus[3], QF2bus[3],
	  QF3bus[3], QF4bus[3], MuxSelbus[8:0],
	  OF1bus[3], OF2bus[3], OF3bus[3], OF4bus[3] );

endmodule // MuxesF4bit_4


/********************************************/

module  MiscMuxLogic( NewMuxIn, MiscContIn, ContBeta, MiscMuxOut );

   input [20:0]	 NewMuxIn;
   input [7:0]	 MiscContIn;
   output	 ContBeta;
   output [10:0] MiscMuxOut;

   wire [3:0]	 tempOut1, tempOut2, tempOut3;

   and2 MML0( .A(MiscContIn[0]), .B(MiscContIn[1]), .Y(ContBeta) );
   inv  MML1( .A(ContBeta), .Y(NotContBeta) ),
   MML2( .A(MiscContIn[2]), .Y(NotContIn2) );

   Mux4bit_2_1 MML3( NewMuxIn[3:0], NewMuxIn[7:4], NotContIn2,
		     tempOut1 );
   Mux4bit_4_1 MML4( NewMuxIn[11:8], NewMuxIn[15:12], { 4'b1111 },
		     { 4'b1111 }, NotContBeta, MiscContIn[2],
		     tempOut2 );

   // MiscMuxOut[3:0] and MiscMuxOut[7:4]
   Mask_And4bit MML5( tempOut1, ContBeta, tempOut3 );
   Invert4      MML6( tempOut3, MiscMuxOut[3:0] ); 
   Mask_And4bit MML7( tempOut2, MiscContIn[3], MiscMuxOut[7:4] );
   
   // MiscMuxOut[8] -- out818
   inv     MML8( .A(NewMuxIn[20]), .Y(NotMuxIn20) );
   XOR2b  MML9( .A(NotMuxIn20), .B(NewMuxIn[16]), .Y(tempMuxin) );
   Mux4_1 MML10( NewMuxIn[19], tempMuxin, NewMuxIn[17], NewMuxIn[18],
		 MiscContIn[5], MiscContIn[4], tempMuxout );
   nand2    MML11( .A(MiscContIn[6]), .B(MiscContIn[7]), .Y(tempMuxcont) );
   and2    MML12( .A(tempMuxcont), .B(tempMuxout), .Y(MiscMuxOut[8]) );

   // MiscMuxOut[9] -- out813
   XOR2b  MML13( .A(tempMuxin), .B(NewMuxIn[18]), .Y(MiscMuxOut[9]) );

   // MiscMuxOut[10]=not(SumXbus[8]) -- out623
   inv     MML14( .A(NewMuxIn[18]), .Y(MiscMuxOut[10]) );

endmodule // MiscMuxLogic



/***************************************************************************
 * Description of some basic gates/modules
 ***************************************************************************/

/********************************************/

module ParityTree10bit( Inbus, ParOut );

   input [9:0] Inbus;
   output      ParOut;

   XOR2a PT0( .A(Inbus[5]), .B(Inbus[6]), .Y(line0) ),
   PT1( .A(Inbus[7]), .B(Inbus[8]), .Y(line1) ),
   PT2( .A(Inbus[0]), .B(Inbus[9]), .Y(line2) ),
   PT3( .A(Inbus[1]), .B(Inbus[2]), .Y(line3) ),
   PT4( .A(Inbus[3]), .B(Inbus[4]), .Y(line4) );
   XOR2a PT5( .A(line0), .B(line1), .Y(line5) );
   XOR3a PT6( .A(line2), .B(line3), .C(line4), .Y(line6) );
   XOR2a PT7( .A(line5), .B(line6), .Y(ParOut) );
   
endmodule // ParityTree10bit


/********************************************************************
 * Submodule: Adder9
 * 
 * Function: calculates the sum (In1bus + In2bus + Cin).
 * 
 *  The structure of this adder is slightly different from the
 *  one that computes the parity of the result.
 *  A CLA is used to compute the sum outputs for the lower
 *  6 bits. Two sets of sum signals are computed for the upper
 *  3 bits: one assuming carry[4]=0, and another assuming carry[4]=1
 *  The actual carry[4] signal selects the correct sum bits.
 * 
 ********************************************************************/

module Adder9 ( In1bus, In2bus, Cin, Sumbus, Cout_in0, PropThru );

   input [8:0]	In1bus, In2bus;
   input	Cin;
   output [8:0]	Sumbus;
   output	Cout_in0, PropThru;

   wire [8:0]	Genbus, Propbus;
   wire [2:0]	LocalHC0, LocalHC1;       // for bits # 7-5
   wire [4:0]	Carry;
   wire [5:0]	SumH01bus;


   GenProp9 Add0( In1bus, In2bus, Genbus, Propbus );

   // generate actual carry lines #0-4
   // Cout_in0 is the carry for the entire operation with Cin=0

   CLAblock Add1( Genbus, Propbus, Cin, Carry, Cout_in0, PropThru );

   // generate local carries for bits #7-5
   GenLocalCarry3 Add2( Genbus[7:5], Propbus[7:5], LocalHC0, LocalHC1 );   

   // for bits # 0-5, generate sum directly : prop XOR carry
   XOR2a6bit Add3( Propbus[5:0], { Carry[4:0], Cin }, Sumbus[5:0] );

   // for bits #6-8, generate two sums, one assuming Carry[4]=0,
   //                                   the other assuming Carry[4]=1
   XOR2a6bit Add4( { Propbus[8:6], Propbus[8:6] },
		   { LocalHC1[2:0], LocalHC0[2:0] }, SumH01bus );

   // now choose the correct sums #6-8
   Mux2_1 Add5( SumH01bus[0], SumH01bus[3], Carry[4], Sumbus[6] ),
   Add6( SumH01bus[1], SumH01bus[4], Carry[4], Sumbus[7] ),
   Add7( SumH01bus[2], SumH01bus[5], Carry[4], Sumbus[8] );

endmodule // Adder9


/******************************************************/

module Muxes2_Mux4( LogicPar, SumPar, Wpar, MuxSel,
		    NotSumLogicPar, SumLogicParOut );

   input       LogicPar, SumPar;
   input [1:0] Wpar, MuxSel;
   output      NotSumLogicPar, SumLogicParOut;

   inv    M2M4_0( .A(LogicPar), .Y(NotLogicPar) ),
   M2M4_1( .A(SumPar), .Y(NotSumPar) );
   Mux2_1 M2M4_2( NotLogicPar, NotSumPar, MuxSel[1], line0 ),
   M2M4_3( line0, Wpar[0], MuxSel[0], NotSumLogicPar );

   Mux4_1 M2M4_4( LogicPar, Wpar[1], SumPar, 1'b1,
		  MuxSel[1], MuxSel[0], SumLogicParOut );
   
endmodule // Muxes2_Mux4



/***************************************************************************
 * Module: ZeroFlags
 * 
 * Function: generates the zero signal for four 9-bit buses:
 *   SumX, LogicX, SumY and LogicY.
 *   In each case, the zero signal is equal to the NOR of all the inputs.
 * 
 ***************************************************************************/

module ZeroFlags( SumX, LogicX, SumY, LogicY, ZeroFlagOut );

   input [8:0]	SumX, LogicX, SumY, LogicY;
   output [3:0]	ZeroFlagOut;
   
   NOR9 ZF0( SumX, ZeroFlagOut[3] ),
   ZF1( SumY, ZeroFlagOut[2] ),
   ZF2( LogicX, ZeroFlagOut[1] ),
   ZF3( LogicY, ZeroFlagOut[0] );

endmodule // ZeroFlags



/***************************************************************************
 * Module: CalcSumLogic
 * 
 * Function: calculates the sum (XYsumbus + ABsumbus + Cin), and
 * the logical operation (XYlogicbus OPR ABlogicbus), both of which
 * are 9 bits wide.
 * 
 * -Note that the OPR is not uniform for all bit positions; that's why
 *  it's 36 bits wide, 4 bits for each bit.
 * 
 * -Also computed by the Adder9 module are Cout_in0 and PropThru.
 *   Cout_in0: the carry-out bit assuming Cin=0
 *   PropThru: AND of all propagate bits, so it indicates whether
 *   Cin can propagate all the way through 9 bits.
 *  (The actual carry output can be calculated by Cout_in0+Cin.PropThru)
 * 
 ***************************************************************************/

module CalcSumLogic( XYlogicbus, ABlogicbus, XYsumbus, ABsumbus, Cin, WXYbus,
		     ContLogicIn, MuxSel,
		     Logicbus, Sumbus, FXYbus, Cout_in0, PropThru );

   input [8:0]	XYlogicbus, ABlogicbus;
   input [8:0]	XYsumbus, ABsumbus;
   input	Cin;
   input [8:0]	WXYbus;
   input [35:0]	ContLogicIn;
   input [1:0]	MuxSel;
   output [8:0]	Sumbus, Logicbus;
   output [8:0]	FXYbus;
   output	Cout_in0, PropThru;


   ComputeLogic CSL0( XYlogicbus, ABlogicbus, ContLogicIn, Logicbus );

   Adder9       CSL1( XYsumbus, ABsumbus, Cin, Sumbus, Cout_in0, PropThru );

   Mux9bit_4_1  CSL2( Logicbus, WXYbus, Sumbus, { 9'b000000000 },
		      MuxSel[1], MuxSel[0], FXYbus );

endmodule // CalcSumLogic


/********************************************/

module Invert9( Inbus, Outbus );

   input [8:0]	Inbus;
   output [8:0]	Outbus;

   Invert4 Inv9_0( Inbus[3:0], Outbus[3:0] ),
   Inv9_1( Inbus[7:4], Outbus[7:4] );
   inv     Inv9_2( .A(Inbus[8]), .Y(Outbus[8]) );
   
endmodule // Invert9


/***************************************************************************
 * Module: Mux9bit_2_1
 * 
 * Function: 9-bit 2:1 Muxes
***************************************************************************/

module Mux9bit_2_1( In0, In1, ContIn, Out );
   input [8:0]	 In0, In1;
   input		 ContIn;
   output [8:0] Out;

   Mux4bit_2_1 Mux9_0( In0[3:0], In1[3:0], ContIn, Out[3:0] ),
               Mux9_1( In0[7:4], In1[7:4], ContIn, Out[7:4] );
   Mux2_1      Mux9_2( In0[8], In1[8], ContIn, Out[8] );

endmodule // Mux9bit_2_1


/***************************************************************************
 * Module: BusParityChk
 * 
 * Function: computes the parity of four 10-bit buses:
 *  X0bus, Xbus, Y0bus and Ybus, each with an additional input.
 *  ParChkOut[0] is the AND of all the bus parities and can be masked
 *  by ContParChk inputs.
 * 
 ***************************************************************************/

module BusParityChk( X0bus, Xbus, Y0bus, Ybus, ParXin, ParYin,
		     MuxSelX, MuxSelY, ContParChk, ParChkOut );

   input [8:0]	X0bus, Xbus, Y0bus, Ybus;
   input [1:0]	ParXin, ParYin;
   input	MuxSelX, MuxSelY;
   input [5:0]	ContParChk;
   output [4:0]	ParChkOut;

   wire		ParX, ParY;
   wire [3:0]	NotParChk;

   Mux2_1 BPC0( ParXin[0], ParXin[1], MuxSelX, ParX ),
   BPC1( ParYin[0], ParYin[1], MuxSelY, ParY );

   ParityTree10bit BPC2( { ParX, Xbus[8:0] }, ParChkOut[4] ),
   BPC3( { ParXin[0], X0bus[8:0] }, ParChkOut[3] ),
   BPC4( { ParY, Ybus[8:0] }, ParChkOut[2] ),
   BPC5( { ParYin[0], Y0bus[8:0] }, ParChkOut[1] );

   Invert4  BPC6( ParChkOut[4:1], NotParChk );
   and5      BPC7( .A(NotParChk[3]), .B(NotParChk[2]), .C(NotParChk[1]),
		   .D(NotParChk[0]), .E(ContParChk[5]), .Y(line7) );
   and4      BPC8( .A(ContParChk[0]), .B(ContParChk[1]), .C(ContParChk[2]),
		   .D(ContParChk[3]), .Y(line8) );
   and3      BPC9( .A(line8), .B(line7), .C(ContParChk[4]),
		   .Y(ParChkOut[0]) );

endmodule // BusParityChk



/***************************************************************************
 * Module: MuxesPar_4
 * 
 * Function: includes a set of 4 muxes.
 *  The outputs of two of the muxes can be masked with an AND gate.
 * 
 ***************************************************************************/

module MuxesPar_4( ParX, ParY, QP1, QP2, QP3, QP4, MuxSelbus,
		   OP1, OP2, OP3, OP4 );

   input       ParX, ParY, QP1, QP2, QP3, QP4;
   input [8:0] MuxSelbus;
   output      OP1, OP2, OP3, OP4;

   Muxes4  MP0( ParX, ParY, QP1, QP2, QP3, QP4, MuxSelbus,
		NotOP1, NotOP2, OP3, OP4 );
   inv     MP1( .A(NotOP1), .Y(OP1) ),
   MP2( .A(NotOP2), .Y(OP2) );

endmodule // MuxesPar_4



/***************************************************************************
 * Module: MuxesF8bit_4
 * 
 * Function: includes four sets of 9-bit Muxes whose inputs are 
 *  FXbus and FYbus, the outputs of the CalcSumLogic modules, and 
 *  input buses QF1, QF2, QF3, QF4.
 * 
 ***************************************************************************/

module MuxesF8bit_4( FXbus, FYbus, QF1bus, QF2bus, QF3bus, QF4bus, MuxSelbus,
		     OF1bus, OF2bus, OF3bus, OF4bus );

   input [8:0]	FXbus, FYbus, QF1bus, QF2bus, QF3bus, QF4bus;
   input [8:0]	MuxSelbus;
   output [8:0]	OF1bus, OF2bus, OF3bus, OF4bus;

   MuxesF4bit_4 MF8_0( FXbus[3:0], FYbus[3:0], QF1bus[3:0], QF2bus[3:0],
		       QF3bus[3:0], QF4bus[3:0], MuxSelbus[8:0],
		       OF1bus[3:0], OF2bus[3:0], OF3bus[3:0], OF4bus[3:0] ),
   MF8_1( FXbus[7:4], FYbus[7:4], QF1bus[7:4], QF2bus[7:4],
	  QF3bus[7:4], QF4bus[7:4], MuxSelbus[8:0],
	  OF1bus[7:4], OF2bus[7:4], OF3bus[7:4], OF4bus[7:4] );
   Muxes4       MF8_2( FXbus[8], FYbus[8], QF1bus[8], QF2bus[8],
		       QF3bus[8], QF4bus[8], MuxSelbus[8:0],
		       OF1bus[8], OF2bus[8], OF3bus[8], OF4bus[8] ); 

endmodule // MuxesF8bit_4



/***************************************************************************
 * Module: CalcParity
 * 
 * Function: calculates the parity of the result (XYsumbus+ABsumbus+CinPar),
 *  and of (XYlogicbus OPR ABlogicbus), where OPR is a logical operator
 *  specified by ContLogicPar.
 * 
 *  - ContLogicPar is 4 bits wide, so the parity of 16 different logical
 *    functions can be calculated.
 * 
 ***************************************************************************/

module CalcParity( XYlogicbus, ABlogicbus, XYsumbus, ABsumbus, Wpar,
		   MuxSel, ContLogicPar, CinPar,
		   NotSumLogicPar, SumLogicParOut );

   input [8:0] XYlogicbus, ABlogicbus;
   input [8:0] XYsumbus, ABsumbus;
   input [1:0] Wpar;
   input [1:0] MuxSel;
   input [3:0] ContLogicPar;
   input       CinPar;
   output      NotSumLogicPar, SumLogicParOut;

   LogicParity CalP0( XYlogicbus, ABlogicbus, ContLogicPar, LogicPar );
   SumParity   CalP1( XYsumbus, ABsumbus, CinPar, SumPar );

   Muxes2_Mux4 CalP2( LogicPar, SumPar, Wpar, MuxSel,
		      NotSumLogicPar, SumLogicParOut );

endmodule // CalcParity


/***************************************************************************
 * Module: MiscLogic
 * 
 * Function: contains muxes and gates that are mostly unstructured 
 *  and unrelated to the rest of the circuit.
 * 
 *  - The MiscMuxLogic block includes four 2:1 and 4:1 muxes with
 *    independent inputs.
 *  - The MiscRandomLogic block contains mostly inverters and buffers.
 * 
 ***************************************************************************/

module MiscLogic( MiscMuxIn, MiscContIn, MiscInbus, ContParChk,
		  Xbus_8, LogicXbus_8, SumXbus_8, WXbus_8,
		  X1bus3_0, X1bus_8, X0bus_8, MuxSelPF_8,
		  MiscMuxOut, MiscOutbus );
   
   input [16:0]	 MiscMuxIn;
   input [7:0]	 MiscContIn;
   input [8:0]	 MiscInbus;
   input [5:0]	 ContParChk;
   input	 Xbus_8, LogicXbus_8, SumXbus_8, WXbus_8;
   input	 X1bus_8, X0bus_8, MuxSelPF_8;
   input [3:0]	 X1bus3_0;
   output [10:0] MiscMuxOut;
   output [25:0] MiscOutbus;
   
   wire		 ContBeta;

   MiscMuxLogic UM13_0( { Xbus_8, LogicXbus_8, SumXbus_8, WXbus_8, MiscMuxIn },
			MiscContIn, ContBeta, MiscMuxOut );

   MiscRandomLogic UM13_1( { X1bus3_0, X1bus_8, X0bus_8, MuxSelPF_8, MiscInbus },
			   ContParChk, MiscContIn, ContBeta, MiscOutbus );

endmodule // MiscLogic



/***************************************************************************/
/***************************************************************************/

module TopLevel5315( X0bus, X1bus, Abus, Y0bus, Y1bus, Bbus, CinFX, CinFY,
		     CinParX, CinParY, MuxSelX, MuxSelY, MuxSelPF,
		     QF1bus, QF2bus, QF3bus, QF4bus, QP1, QP2, QP3, QP4,
		     WXbus, WYbus, ContLogic, ParXin, ParYin, ContParChk,
		     MiscMuxIn, MiscContIn, MiscInbus, WparX, WparY,

		     OF1bus, OF2bus, OF3bus, OF4bus, OP1, OP2, OP3, OP4,
		     SumLogicParXout, SumLogicParYout, CoutFX_in0, CoutFY_in0,
		     PropThruX, PropThruY, NotFXbus, NotFYbus, ZeroFlagOut,
		     ParChkOut, MiscMuxOut, MiscOutbus	);

   input [8:0]	 X0bus, X1bus, Abus;
   input [8:0]	 Y0bus, Y1bus, Bbus;
   input	 CinFX, CinFY;
   input	 CinParX, CinParY;
   input	 MuxSelX, MuxSelY;
   input [10:0]	 MuxSelPF;
   input [8:0]	 QF1bus, QF2bus, QF3bus, QF4bus;
   input	 QP1, QP2, QP3, QP4;
   input [8:0]	 WXbus, WYbus;
   input [1:0]	 WparX, WparY;
   input [7:0]	 ContLogic;
   input [1:0]	 ParXin, ParYin;
   input [5:0]	 ContParChk;
   input [16:0]	 MiscMuxIn;
   input [7:0]	 MiscContIn;
   input [8:0]	 MiscInbus;

   output [8:0]	 OF1bus, OF2bus, OF3bus, OF4bus;
   output	 OP1, OP2, OP3, OP4;
   output	 SumLogicParXout, SumLogicParYout;
   output	 CoutFX_in0, CoutFY_in0;
   output	 PropThruX, PropThruY;
   output [8:0]	 NotFXbus, NotFYbus;
   output [3:0]	 ZeroFlagOut;
   output [4:0]	 ParChkOut;
   output [10:0] MiscMuxOut;
   output [25:0] MiscOutbus;


   wire [8:0]	 Xbus, Ybus;
   wire [8:0]	 FXbus, FYbus;
   wire [8:0]	 SumXbus, LogicXbus, SumYbus, LogicYbus;
   wire [3:0]	 ContLogicPar, NotContLogic3_0;
   wire [35:0]	 ContLogicInX, ContLogicInY;
   wire		 Not_SumLogicParX, Not_SumLogicParY;

   wire GND;
   
// GND = 1'b0
   buffer addedBuf119 (.A(1'b0), .Y(GND));


   Mux9bit_2_1 M1( X0bus, X1bus, MuxSelX, Xbus );
   Mux9bit_2_1 M2( Y0bus, Y1bus, MuxSelY, Ybus );

   
// ContLogicPar[3:0] = ContLogic[7:4]
   buffer addedBuf115 (.A(ContLogic[7]), .Y(ContLogicPar[3]));
   buffer addedBuf116 (.A(ContLogic[6]), .Y(ContLogicPar[2]));
   buffer addedBuf117 (.A(ContLogic[5]), .Y(ContLogicPar[1]));
   buffer addedBuf118 (.A(ContLogic[4]), .Y(ContLogicPar[0]));

   
// parity blocks

   CalcParity  M3( X0bus, { GND, Abus[7:0] }, Xbus, Abus, WparX,
		   MuxSelPF[10:9], ContLogicPar, CinParX,
		   Not_SumLogicParX, SumLogicParXout );
   CalcParity  M4( Y0bus, Bbus, Ybus, Bbus, WparY,
		   MuxSelPF[10:9], ContLogicPar, CinParY,
		   Not_SumLogicParY, SumLogicParYout );
 
   MuxesPar_4  M5( Not_SumLogicParX, Not_SumLogicParY, QP1, QP2, QP3, QP4,
		   MuxSelPF[8:0], OP1, OP2, OP3, OP4 );
   
// sum-logic blocks

   Invert4 M0( ContLogic[3:0], NotContLogic3_0 );
   
// ContLogicInX[35:0] = { ContLogicPar[3:0], ContLogicPar[3:0], ContLogicPar[3:0],
//			     ContLogicPar[3:0], NotContLogic3_0[3:0], NotContLogic3_0[3:0],
//			     NotContLogic3_0[3:0], NotContLogic3_0[3:0], ContLogicPar[3:0] }
   buffer addedBuf43 (.A(ContLogicPar[3]), .Y(ContLogicInX[35]));
   buffer addedBuf44 (.A(ContLogicPar[2]), .Y(ContLogicInX[34]));
   buffer addedBuf45 (.A(ContLogicPar[1]), .Y(ContLogicInX[33]));
   buffer addedBuf46 (.A(ContLogicPar[0]), .Y(ContLogicInX[32]));
   buffer addedBuf47 (.A(ContLogicPar[3]), .Y(ContLogicInX[31]));
   buffer addedBuf48 (.A(ContLogicPar[2]), .Y(ContLogicInX[30]));
   buffer addedBuf49 (.A(ContLogicPar[1]), .Y(ContLogicInX[29]));
   buffer addedBuf50 (.A(ContLogicPar[0]), .Y(ContLogicInX[28]));
   buffer addedBuf51 (.A(ContLogicPar[3]), .Y(ContLogicInX[27]));
   buffer addedBuf52 (.A(ContLogicPar[2]), .Y(ContLogicInX[26]));
   buffer addedBuf53 (.A(ContLogicPar[1]), .Y(ContLogicInX[25]));
   buffer addedBuf54 (.A(ContLogicPar[0]), .Y(ContLogicInX[24]));
   buffer addedBuf55 (.A(ContLogicPar[3]), .Y(ContLogicInX[23]));
   buffer addedBuf56 (.A(ContLogicPar[2]), .Y(ContLogicInX[22]));
   buffer addedBuf57 (.A(ContLogicPar[1]), .Y(ContLogicInX[21]));
   buffer addedBuf58 (.A(ContLogicPar[0]), .Y(ContLogicInX[20]));
   buffer addedBuf59 (.A(NotContLogic3_0[3]), .Y(ContLogicInX[19]));
   buffer addedBuf60 (.A(NotContLogic3_0[2]), .Y(ContLogicInX[18]));
   buffer addedBuf61 (.A(NotContLogic3_0[1]), .Y(ContLogicInX[17]));
   buffer addedBuf62 (.A(NotContLogic3_0[0]), .Y(ContLogicInX[16]));
   buffer addedBuf63 (.A(NotContLogic3_0[3]), .Y(ContLogicInX[15]));
   buffer addedBuf64 (.A(NotContLogic3_0[2]), .Y(ContLogicInX[14]));
   buffer addedBuf65 (.A(NotContLogic3_0[1]), .Y(ContLogicInX[13]));
   buffer addedBuf66 (.A(NotContLogic3_0[0]), .Y(ContLogicInX[12]));
   buffer addedBuf67 (.A(NotContLogic3_0[3]), .Y(ContLogicInX[11]));
   buffer addedBuf68 (.A(NotContLogic3_0[2]), .Y(ContLogicInX[10]));
   buffer addedBuf69 (.A(NotContLogic3_0[1]), .Y(ContLogicInX[9]));
   buffer addedBuf70 (.A(NotContLogic3_0[0]), .Y(ContLogicInX[8]));
   buffer addedBuf71 (.A(NotContLogic3_0[3]), .Y(ContLogicInX[7]));
   buffer addedBuf72 (.A(NotContLogic3_0[2]), .Y(ContLogicInX[6]));
   buffer addedBuf73 (.A(NotContLogic3_0[1]), .Y(ContLogicInX[5]));
   buffer addedBuf74 (.A(NotContLogic3_0[0]), .Y(ContLogicInX[4]));
   buffer addedBuf75 (.A(ContLogicPar[3]), .Y(ContLogicInX[3]));
   buffer addedBuf76 (.A(ContLogicPar[2]), .Y(ContLogicInX[2]));
   buffer addedBuf77 (.A(ContLogicPar[1]), .Y(ContLogicInX[1]));
   buffer addedBuf78 (.A(ContLogicPar[0]), .Y(ContLogicInX[0]));

// ContLogicInY[35:0] = { ContLogicPar[3:0], NotContLogic3_0[3:0], NotContLogic3_0[3:0],
//			     NotContLogic3_0[3:0], NotContLogic3_0[3:0], NotContLogic3_0[3:0],
//			     NotContLogic3_0[3:0], NotContLogic3_0[3:0], NotContLogic3_0[3:0] }
   buffer addedBuf79 (.A(ContLogicPar[3]), .Y(ContLogicInY[35]));
   buffer addedBuf80 (.A(ContLogicPar[2]), .Y(ContLogicInY[34]));
   buffer addedBuf81 (.A(ContLogicPar[1]), .Y(ContLogicInY[33]));
   buffer addedBuf82 (.A(ContLogicPar[0]), .Y(ContLogicInY[32]));
   buffer addedBuf83 (.A(NotContLogic3_0[3]), .Y(ContLogicInY[31]));
   buffer addedBuf84 (.A(NotContLogic3_0[2]), .Y(ContLogicInY[30]));
   buffer addedBuf85 (.A(NotContLogic3_0[1]), .Y(ContLogicInY[29]));
   buffer addedBuf86 (.A(NotContLogic3_0[0]), .Y(ContLogicInY[28]));
   buffer addedBuf87 (.A(NotContLogic3_0[3]), .Y(ContLogicInY[27]));
   buffer addedBuf88 (.A(NotContLogic3_0[2]), .Y(ContLogicInY[26]));
   buffer addedBuf89 (.A(NotContLogic3_0[1]), .Y(ContLogicInY[25]));
   buffer addedBuf90 (.A(NotContLogic3_0[0]), .Y(ContLogicInY[24]));
   buffer addedBuf91 (.A(NotContLogic3_0[3]), .Y(ContLogicInY[23]));
   buffer addedBuf92 (.A(NotContLogic3_0[2]), .Y(ContLogicInY[22]));
   buffer addedBuf93 (.A(NotContLogic3_0[1]), .Y(ContLogicInY[21]));
   buffer addedBuf94 (.A(NotContLogic3_0[0]), .Y(ContLogicInY[20]));
   buffer addedBuf95 (.A(NotContLogic3_0[3]), .Y(ContLogicInY[19]));
   buffer addedBuf96 (.A(NotContLogic3_0[2]), .Y(ContLogicInY[18]));
   buffer addedBuf97 (.A(NotContLogic3_0[1]), .Y(ContLogicInY[17]));
   buffer addedBuf98 (.A(NotContLogic3_0[0]), .Y(ContLogicInY[16]));
   buffer addedBuf99 (.A(NotContLogic3_0[3]), .Y(ContLogicInY[15]));
   buffer addedBuf100 (.A(NotContLogic3_0[2]), .Y(ContLogicInY[14]));
   buffer addedBuf101 (.A(NotContLogic3_0[1]), .Y(ContLogicInY[13]));
   buffer addedBuf102 (.A(NotContLogic3_0[0]), .Y(ContLogicInY[12]));
   buffer addedBuf103 (.A(NotContLogic3_0[3]), .Y(ContLogicInY[11]));
   buffer addedBuf104 (.A(NotContLogic3_0[2]), .Y(ContLogicInY[10]));
   buffer addedBuf105 (.A(NotContLogic3_0[1]), .Y(ContLogicInY[9]));
   buffer addedBuf106 (.A(NotContLogic3_0[0]), .Y(ContLogicInY[8]));
   buffer addedBuf107 (.A(NotContLogic3_0[3]), .Y(ContLogicInY[7]));
   buffer addedBuf108 (.A(NotContLogic3_0[2]), .Y(ContLogicInY[6]));
   buffer addedBuf109 (.A(NotContLogic3_0[1]), .Y(ContLogicInY[5]));
   buffer addedBuf110 (.A(NotContLogic3_0[0]), .Y(ContLogicInY[4]));
   buffer addedBuf111 (.A(NotContLogic3_0[3]), .Y(ContLogicInY[3]));
   buffer addedBuf112 (.A(NotContLogic3_0[2]), .Y(ContLogicInY[2]));
   buffer addedBuf113 (.A(NotContLogic3_0[1]), .Y(ContLogicInY[1]));
   buffer addedBuf114 (.A(NotContLogic3_0[0]), .Y(ContLogicInY[0]));


   CalcSumLogic M6( X0bus, { GND, Abus[7:0] }, Xbus, Abus, CinFX, WXbus,
		    ContLogicInX, MuxSelPF[10:9],
		    LogicXbus, SumXbus, FXbus, CoutFX_in0, PropThruX );

   CalcSumLogic M7( Y0bus, Bbus, Ybus, Bbus, CinFY, WYbus,
		    ContLogicInY, MuxSelPF[10:9],
		    LogicYbus, SumYbus, FYbus, CoutFY_in0, PropThruY );
   
   MuxesF8bit_4 M8( FXbus, FYbus, QF1bus, QF2bus, QF3bus, QF4bus, MuxSelPF[8:0],
		    OF1bus, OF2bus, OF3bus, OF4bus );

// other logic

   Invert9 M9( FXbus, NotFXbus ),
           M10( FYbus, NotFYbus );

   ZeroFlags M11( SumXbus, LogicXbus, SumYbus, LogicYbus, ZeroFlagOut );

   BusParityChk M12( X0bus, Xbus, Y0bus, Ybus, ParXin, ParYin,
		     MuxSelX, MuxSelY, ContParChk, ParChkOut );

// miscellaneous logic

   MiscLogic M13( MiscMuxIn, MiscContIn, MiscInbus, ContParChk,
		  Xbus[8], LogicXbus[8], SumXbus[8], WXbus[8],
		  X1bus[3:0], X1bus[8], X0bus[8], MuxSelPF[8],
		  MiscMuxOut, MiscOutbus );


endmodule // TopLevel5315

/****************************************************************************
 *                                                                          *
 *  VERILOG HIGH-LEVEL DESCRIPTION OF THE ISCAS-85 BENCHMARK CIRCUIT c5315  *
 *                                                                          *  
 *                                                                          *
 *  Written by   : Hakan Yalcin (hyalcin@cadence.com)                       *
 *  Verified by  : Jonathan David Hauke (jhauke@eecs.umich.edu)             *
 *                                                                          *
 *  First created: Jan 31, 1997                                             *
 *  Last modified: Oct 20, 1998                                             *
 *                                                                          *
****************************************************************************/

module Circuit5315(
        in293, in302, in308, in316, in324, in341, in351, 
        in361, in299, in307, in315, in323, in331, in338, in348, 
        in358, in366, in206, in210, in218, in226, in234, in257, 
        in265, in273, in281, in209, in217, in225, in233, in241, 
        in264, in272, in280, in288, in54, in4, in2174, in1497, 
        in332, in335, in479, in490, in503, in514, in523, in534, 
        in446, in457, in468, in422, in435, in389, in400, in411, 
        in374, in191, in200, in194, in197, in203, in149, in155, 
        in188, in182, in161, in170, in164, in167, in173, in146, 
        in152, in158, in185, in109, in43, in46, in100, in91, 
        in76, in73, in67, in11, in106, in37, in49, in103, 
        in40, in20, in17, in70, in61, in123, in52, in121, 
        in116, in112, in130, in119, in129, in131, in115, in122, 
        in114, in53, in113, in128, in127, in126, in117, in176, 
        in179, in14, in64, in248, in251, in242, in254, in3552, 
        in3550, in3546, in3548, in120, in94, in118, in97, in4091, 
        in4092, in137, in4090, in4089, in4087, in4088, in1694, in1691, 
        in1690, in1689, in372, in369, in292, in289, in562, in245, 
        in552, in556, in559, in386, in132, in23, in80, in25, 
        in81, in79, in82, in24, in26, in86, in88, in87, 
        in83, in34, in4115, in135, in3717, in3724, in141, in2358, 
        in31, in27, in545, in549, in3173, in136, in1, in373, 
        in145, in2824, in140,
        out658, out690, out767, out807, out654, out651, out648, 
        out645, out642, out670, out667, out664, out661, out688, out685, 
        out682, out679, out676, out702, out699, out696, out693, out727, 
        out732, out737, out742, out747, out752, out757, out762, out722, 
        out712, out772, out777, out782, out787, out792, out797, out802, 
        out859, out824, out826, out832, out828, out830, out834, out836, 
        out838, out822, out863, out871, out865, out867, out869, out873, 
        out875, out877, out861, out629, out591, out618, out615, out621, 
        out588, out626, out632, out843, out882, out585, out575, out598, 
        out610, out998, out1002, out1000, out1004, out854, out623, out813, 
        out818, out707, out715, out639, out673, out636, out820, out717, 
        out704, out593, out594, out602, out809, out611, out599, out612, 
        out600, out850, out848, out849, out851, out887, out298, out926, 
        out892, out973, out993, out144, out601, out847, out815, out634, 
        out810, out845, out656, out923, out939, out921, out978, out949, 
        out889, out603, out604, out606);
 
   input
        in293, in302, in308, in316, in324, in341, in351, 
        in361, in299, in307, in315, in323, in331, in338, in348, 
        in358, in366, in206, in210, in218, in226, in234, in257, 
        in265, in273, in281, in209, in217, in225, in233, in241, 
        in264, in272, in280, in288, in54, in4, in2174, in1497, 
        in332, in335, in479, in490, in503, in514, in523, in534, 
        in446, in457, in468, in422, in435, in389, in400, in411, 
        in374, in191, in200, in194, in197, in203, in149, in155, 
        in188, in182, in161, in170, in164, in167, in173, in146, 
        in152, in158, in185, in109, in43, in46, in100, in91, 
        in76, in73, in67, in11, in106, in37, in49, in103, 
        in40, in20, in17, in70, in61, in123, in52, in121, 
        in116, in112, in130, in119, in129, in131, in115, in122, 
        in114, in53, in113, in128, in127, in126, in117, in176, 
        in179, in14, in64, in248, in251, in242, in254, in3552, 
        in3550, in3546, in3548, in120, in94, in118, in97, in4091, 
        in4092, in137, in4090, in4089, in4087, in4088, in1694, in1691, 
        in1690, in1689, in372, in369, in292, in289, in562, in245, 
        in552, in556, in559, in386, in132, in23, in80, in25, 
        in81, in79, in82, in24, in26, in86, in88, in87, 
        in83, in34, in4115, in135, in3717, in3724, in141, in2358, 
        in31, in27, in545, in549, in3173, in136, in1, in373, 
        in145, in2824, in140;
 
   output
        out658, out690, out767, out807, out654, out651, out648, 
        out645, out642, out670, out667, out664, out661, out688, out685, 
        out682, out679, out676, out702, out699, out696, out693, out727, 
        out732, out737, out742, out747, out752, out757, out762, out722, 
        out712, out772, out777, out782, out787, out792, out797, out802, 
        out859, out824, out826, out832, out828, out830, out834, out836, 
        out838, out822, out863, out871, out865, out867, out869, out873, 
        out875, out877, out861, out629, out591, out618, out615, out621, 
        out588, out626, out632, out843, out882, out585, out575, out598, 
        out610, out998, out1002, out1000, out1004, out854, out623, out813, 
        out818, out707, out715, out639, out673, out636, out820, out717, 
        out704, out593, out594, out602, out809, out611, out599, out612, 
        out600, out850, out848, out849, out851, out887, out298, out926, 
        out892, out973, out993, out144, out601, out847, out815, out634, 
        out810, out845, out656, out923, out939, out921, out978, out949, 
        out889, out603, out604, out606;


/************************/
   wire VDD;
   
// VDD = 1'b1
//   buffer addedBuf428 (.A(1'b1), .Y(VDD));


   wire [8:0]	X0bus, X1bus, Abus;
   wire [8:0]	Y0bus, Y1bus, Bbus;
   wire		CinFX, CinFY;
   wire		CinParX, CinParY;
   wire		MuxSelX, MuxSelY;
   wire [10:0]	MuxSelPF;
   wire [8:0]	QF1bus, QF2bus, QF3bus, QF4bus;
   wire [8:0]	WXbus, WYbus;
   wire		QP1, QP2, QP3, QP4;
   wire [7:0]	ContLogic;
   wire [1:0]	ParXin, ParYin;
   wire [5:0]	ContParChk;
   wire [16:0]	MiscMuxIn;
   wire [7:0]	MiscContIn;
   wire [8:0]	MiscInbus;
   wire [1:0]	WparX, WparY;

   wire [8:0]	OF1bus, OF2bus, OF3bus, OF4bus;
   wire		OP1, OP2, OP3, OP4;
   wire		SumLogicParXout, SumLogicParYout;
   wire		CoutFX_in0, CoutFY_in0;
   wire		PropThruX, PropThruY;
   wire [8:0]	NotXFbus, NotYFbus;
   wire [3:0]	ZeroFlagOut;
   wire [4:0]	ParChkOut;
   wire [10:0]	MiscMuxOut;
   wire [25:0]	MiscOutbus;

/************************/

// inputs

   
// X0bus[8:0] = { in293, in302, in308, in316, in324,
//		     VDD, in341, in351, in361 }
   buffer addedBuf410 (.A(in293), .Y(X0bus[8]));
   buffer addedBuf411 (.A(in302), .Y(X0bus[7]));
   buffer addedBuf412 (.A(in308), .Y(X0bus[6]));
   buffer addedBuf413 (.A(in316), .Y(X0bus[5]));
   buffer addedBuf414 (.A(in324), .Y(X0bus[4]));
   buffer addedBuf415 (.A(VDD), .Y(X0bus[3]));
   buffer addedBuf416 (.A(in341), .Y(X0bus[2]));
   buffer addedBuf417 (.A(in351), .Y(X0bus[1]));
   buffer addedBuf418 (.A(in361), .Y(X0bus[0]));

// X1bus[8:0] = { in299, in307, in315, in323, in331,
//		     in338, in348, in358, in366 }
   buffer addedBuf419 (.A(in299), .Y(X1bus[8]));
   buffer addedBuf420 (.A(in307), .Y(X1bus[7]));
   buffer addedBuf421 (.A(in315), .Y(X1bus[6]));
   buffer addedBuf422 (.A(in323), .Y(X1bus[5]));
   buffer addedBuf423 (.A(in331), .Y(X1bus[4]));
   buffer addedBuf424 (.A(in338), .Y(X1bus[3]));
   buffer addedBuf425 (.A(in348), .Y(X1bus[2]));
   buffer addedBuf426 (.A(in358), .Y(X1bus[1]));
   buffer addedBuf427 (.A(in366), .Y(X1bus[0]));

   
// Y0bus[8:0] = { in206, in210, in218, in226, in234,
//		     in257, in265, in273, in281 }
   buffer addedBuf392 (.A(in206), .Y(Y0bus[8]));
   buffer addedBuf393 (.A(in210), .Y(Y0bus[7]));
   buffer addedBuf394 (.A(in218), .Y(Y0bus[6]));
   buffer addedBuf395 (.A(in226), .Y(Y0bus[5]));
   buffer addedBuf396 (.A(in234), .Y(Y0bus[4]));
   buffer addedBuf397 (.A(in257), .Y(Y0bus[3]));
   buffer addedBuf398 (.A(in265), .Y(Y0bus[2]));
   buffer addedBuf399 (.A(in273), .Y(Y0bus[1]));
   buffer addedBuf400 (.A(in281), .Y(Y0bus[0]));

// Y1bus[8:0] = { in209, in217, in225, in233, in241,
//		     in264, in272, in280, in288 }
   buffer addedBuf401 (.A(in209), .Y(Y1bus[8]));
   buffer addedBuf402 (.A(in217), .Y(Y1bus[7]));
   buffer addedBuf403 (.A(in225), .Y(Y1bus[6]));
   buffer addedBuf404 (.A(in233), .Y(Y1bus[5]));
   buffer addedBuf405 (.A(in241), .Y(Y1bus[4]));
   buffer addedBuf406 (.A(in264), .Y(Y1bus[3]));
   buffer addedBuf407 (.A(in272), .Y(Y1bus[2]));
   buffer addedBuf408 (.A(in280), .Y(Y1bus[1]));
   buffer addedBuf409 (.A(in288), .Y(Y1bus[0]));

   
// CinFX = in54
   buffer addedBuf388 (.A(in54), .Y(CinFX));

// CinFY = in4
   buffer addedBuf389 (.A(in4), .Y(CinFY));

// CinParX = in2174
   buffer addedBuf390 (.A(in2174), .Y(CinParX));

// CinParY = in1497
   buffer addedBuf391 (.A(in1497), .Y(CinParY));


   
// MuxSelX = in332
   buffer addedBuf386 (.A(in332), .Y(MuxSelX));

// MuxSelY = in335
   buffer addedBuf387 (.A(in335), .Y(MuxSelY));

   
   
// Abus[8:0] = { VDD, VDD, in479, in490, in503,
//		    in514, in523, in534, VDD }
   buffer addedBuf377 (.A(VDD), .Y(Abus[8]));
   buffer addedBuf378 (.A(VDD), .Y(Abus[7]));
   buffer addedBuf379 (.A(in479), .Y(Abus[6]));
   buffer addedBuf380 (.A(in490), .Y(Abus[5]));
   buffer addedBuf381 (.A(in503), .Y(Abus[4]));
   buffer addedBuf382 (.A(in514), .Y(Abus[3]));
   buffer addedBuf383 (.A(in523), .Y(Abus[2]));
   buffer addedBuf384 (.A(in534), .Y(Abus[1]));
   buffer addedBuf385 (.A(VDD), .Y(Abus[0]));

   
// Bbus[8:0] = { in446, in457, in468, in422, in435,
//		    in389, in400, in411, in374 }
   buffer addedBuf368 (.A(in446), .Y(Bbus[8]));
   buffer addedBuf369 (.A(in457), .Y(Bbus[7]));
   buffer addedBuf370 (.A(in468), .Y(Bbus[6]));
   buffer addedBuf371 (.A(in422), .Y(Bbus[5]));
   buffer addedBuf372 (.A(in435), .Y(Bbus[4]));
   buffer addedBuf373 (.A(in389), .Y(Bbus[3]));
   buffer addedBuf374 (.A(in400), .Y(Bbus[2]));
   buffer addedBuf375 (.A(in411), .Y(Bbus[1]));
   buffer addedBuf376 (.A(in374), .Y(Bbus[0]));

   
// QF1bus[8:0] = { in191, in194, in197, in203, in200,
//		      in149, in155, in188, in182 }
   buffer addedBuf332 (.A(in191), .Y(QF1bus[8]));
   buffer addedBuf333 (.A(in194), .Y(QF1bus[7]));
   buffer addedBuf334 (.A(in197), .Y(QF1bus[6]));
   buffer addedBuf335 (.A(in203), .Y(QF1bus[5]));
   buffer addedBuf336 (.A(in200), .Y(QF1bus[4]));
   buffer addedBuf337 (.A(in149), .Y(QF1bus[3]));
   buffer addedBuf338 (.A(in155), .Y(QF1bus[2]));
   buffer addedBuf339 (.A(in188), .Y(QF1bus[1]));
   buffer addedBuf340 (.A(in182), .Y(QF1bus[0]));

// QF2bus[8:0] = { in161, in164, in167, in173, in170,
//		      in146, in152, in158, in185 }
   buffer addedBuf341 (.A(in161), .Y(QF2bus[8]));
   buffer addedBuf342 (.A(in164), .Y(QF2bus[7]));
   buffer addedBuf343 (.A(in167), .Y(QF2bus[6]));
   buffer addedBuf344 (.A(in173), .Y(QF2bus[5]));
   buffer addedBuf345 (.A(in170), .Y(QF2bus[4]));
   buffer addedBuf346 (.A(in146), .Y(QF2bus[3]));
   buffer addedBuf347 (.A(in152), .Y(QF2bus[2]));
   buffer addedBuf348 (.A(in158), .Y(QF2bus[1]));
   buffer addedBuf349 (.A(in185), .Y(QF2bus[0]));

// QF3bus[8:0] = { in109, in46, in100, in91, in43,
//		      in76, in73, in67, in11 }
   buffer addedBuf350 (.A(in109), .Y(QF3bus[8]));
   buffer addedBuf351 (.A(in46), .Y(QF3bus[7]));
   buffer addedBuf352 (.A(in100), .Y(QF3bus[6]));
   buffer addedBuf353 (.A(in91), .Y(QF3bus[5]));
   buffer addedBuf354 (.A(in43), .Y(QF3bus[4]));
   buffer addedBuf355 (.A(in76), .Y(QF3bus[3]));
   buffer addedBuf356 (.A(in73), .Y(QF3bus[2]));
   buffer addedBuf357 (.A(in67), .Y(QF3bus[1]));
   buffer addedBuf358 (.A(in11), .Y(QF3bus[0]));

// QF4bus[8:0] = { in106, in49, in103, in40, in37,
//		      in20, in17, in70, in61 }
   buffer addedBuf359 (.A(in106), .Y(QF4bus[8]));
   buffer addedBuf360 (.A(in49), .Y(QF4bus[7]));
   buffer addedBuf361 (.A(in103), .Y(QF4bus[6]));
   buffer addedBuf362 (.A(in40), .Y(QF4bus[5]));
   buffer addedBuf363 (.A(in37), .Y(QF4bus[4]));
   buffer addedBuf364 (.A(in20), .Y(QF4bus[3]));
   buffer addedBuf365 (.A(in17), .Y(QF4bus[2]));
   buffer addedBuf366 (.A(in70), .Y(QF4bus[1]));
   buffer addedBuf367 (.A(in61), .Y(QF4bus[0]));


   
// WXbus[8:0] = { in123, in121, in116, in112, in52,
//		     in130, in119, in129, in131 }
   buffer addedBuf314 (.A(in123), .Y(WXbus[8]));
   buffer addedBuf315 (.A(in121), .Y(WXbus[7]));
   buffer addedBuf316 (.A(in116), .Y(WXbus[6]));
   buffer addedBuf317 (.A(in112), .Y(WXbus[5]));
   buffer addedBuf318 (.A(in52), .Y(WXbus[4]));
   buffer addedBuf319 (.A(in130), .Y(WXbus[3]));
   buffer addedBuf320 (.A(in119), .Y(WXbus[2]));
   buffer addedBuf321 (.A(in129), .Y(WXbus[1]));
   buffer addedBuf322 (.A(in131), .Y(WXbus[0]));

// WYbus[8:0] = { in115, in114, in53, in113, in122,
//		     in128, in127, in126, in117 }
   buffer addedBuf323 (.A(in115), .Y(WYbus[8]));
   buffer addedBuf324 (.A(in114), .Y(WYbus[7]));
   buffer addedBuf325 (.A(in53), .Y(WYbus[6]));
   buffer addedBuf326 (.A(in113), .Y(WYbus[5]));
   buffer addedBuf327 (.A(in122), .Y(WYbus[4]));
   buffer addedBuf328 (.A(in128), .Y(WYbus[3]));
   buffer addedBuf329 (.A(in127), .Y(WYbus[2]));
   buffer addedBuf330 (.A(in126), .Y(WYbus[1]));
   buffer addedBuf331 (.A(in117), .Y(WYbus[0]));


   
// QP1 = in176
   buffer addedBuf310 (.A(in176), .Y(QP1));

// QP2 = in179
   buffer addedBuf311 (.A(in179), .Y(QP2));

// QP3 = in14
   buffer addedBuf312 (.A(in14), .Y(QP3));

// QP4 = in64
   buffer addedBuf313 (.A(in64), .Y(QP4));

   
   
// ContLogic[7:0] = { in248, in251, in242, in254,
//			 in3552, in3550, in3546, in3548 }
   buffer addedBuf302 (.A(in248), .Y(ContLogic[7]));
   buffer addedBuf303 (.A(in251), .Y(ContLogic[6]));
   buffer addedBuf304 (.A(in242), .Y(ContLogic[5]));
   buffer addedBuf305 (.A(in254), .Y(ContLogic[4]));
   buffer addedBuf306 (.A(in3552), .Y(ContLogic[3]));
   buffer addedBuf307 (.A(in3550), .Y(ContLogic[2]));
   buffer addedBuf308 (.A(in3546), .Y(ContLogic[1]));
   buffer addedBuf309 (.A(in3548), .Y(ContLogic[0]));

   
// WparX[1:0] = { in120, in94 }
   buffer addedBuf298 (.A(in120), .Y(WparX[1]));
   buffer addedBuf299 (.A(in94), .Y(WparX[0]));

// WparY[1:0] = { in118, in97 }
   buffer addedBuf300 (.A(in118), .Y(WparY[1]));
   buffer addedBuf301 (.A(in97), .Y(WparY[0]));


   
// MuxSelPF[10:0] = { in4091, in4092, in137, in4090, in4089, in4087,
//			 in4088, in1694, in1691, in1690, in1689 }
   buffer addedBuf287 (.A(in4091), .Y(MuxSelPF[10]));
   buffer addedBuf288 (.A(in4092), .Y(MuxSelPF[9]));
   buffer addedBuf289 (.A(in137), .Y(MuxSelPF[8]));
   buffer addedBuf290 (.A(in4090), .Y(MuxSelPF[7]));
   buffer addedBuf291 (.A(in4089), .Y(MuxSelPF[6]));
   buffer addedBuf292 (.A(in4087), .Y(MuxSelPF[5]));
   buffer addedBuf293 (.A(in4088), .Y(MuxSelPF[4]));
   buffer addedBuf294 (.A(in1694), .Y(MuxSelPF[3]));
   buffer addedBuf295 (.A(in1691), .Y(MuxSelPF[2]));
   buffer addedBuf296 (.A(in1690), .Y(MuxSelPF[1]));
   buffer addedBuf297 (.A(in1689), .Y(MuxSelPF[0]));

   
// ParXin[1:0] = { in372, in369 }
   buffer addedBuf283 (.A(in372), .Y(ParXin[1]));
   buffer addedBuf284 (.A(in369), .Y(ParXin[0]));

// ParYin[1:0] = { in292, in289 }
   buffer addedBuf285 (.A(in292), .Y(ParYin[1]));
   buffer addedBuf286 (.A(in289), .Y(ParYin[0]));


   
// ContParChk[5:0] = { in562, in245, in552, in556, in559, in386 }
   buffer addedBuf277 (.A(in562), .Y(ContParChk[5]));
   buffer addedBuf278 (.A(in245), .Y(ContParChk[4]));
   buffer addedBuf279 (.A(in552), .Y(ContParChk[3]));
   buffer addedBuf280 (.A(in556), .Y(ContParChk[2]));
   buffer addedBuf281 (.A(in559), .Y(ContParChk[1]));
   buffer addedBuf282 (.A(in386), .Y(ContParChk[0]));


   
// MiscMuxIn[16:0] = { in132, in23, in80, in25, in81,
//			  in79, in82, in24, in26, in86, in83, in88, in88,
//			  in87, in83, in34, in34 }
   buffer addedBuf260 (.A(in132), .Y(MiscMuxIn[16]));
   buffer addedBuf261 (.A(in23), .Y(MiscMuxIn[15]));
   buffer addedBuf262 (.A(in80), .Y(MiscMuxIn[14]));
   buffer addedBuf263 (.A(in25), .Y(MiscMuxIn[13]));
   buffer addedBuf264 (.A(in81), .Y(MiscMuxIn[12]));
   buffer addedBuf265 (.A(in79), .Y(MiscMuxIn[11]));
   buffer addedBuf266 (.A(in82), .Y(MiscMuxIn[10]));
   buffer addedBuf267 (.A(in24), .Y(MiscMuxIn[9]));
   buffer addedBuf268 (.A(in26), .Y(MiscMuxIn[8]));
   buffer addedBuf269 (.A(in86), .Y(MiscMuxIn[7]));
   buffer addedBuf270 (.A(in83), .Y(MiscMuxIn[6]));
   buffer addedBuf271 (.A(in88), .Y(MiscMuxIn[5]));
   buffer addedBuf272 (.A(in88), .Y(MiscMuxIn[4]));
   buffer addedBuf273 (.A(in87), .Y(MiscMuxIn[3]));
   buffer addedBuf274 (.A(in83), .Y(MiscMuxIn[2]));
   buffer addedBuf275 (.A(in34), .Y(MiscMuxIn[1]));
   buffer addedBuf276 (.A(in34), .Y(MiscMuxIn[0]));

   
// MiscContIn[7:0] = { in4115, in135, in3717, in3724,
//			  in141, in2358, in31, in27 }
   buffer addedBuf252 (.A(in4115), .Y(MiscContIn[7]));
   buffer addedBuf253 (.A(in135), .Y(MiscContIn[6]));
   buffer addedBuf254 (.A(in3717), .Y(MiscContIn[5]));
   buffer addedBuf255 (.A(in3724), .Y(MiscContIn[4]));
   buffer addedBuf256 (.A(in141), .Y(MiscContIn[3]));
   buffer addedBuf257 (.A(in2358), .Y(MiscContIn[2]));
   buffer addedBuf258 (.A(in31), .Y(MiscContIn[1]));
   buffer addedBuf259 (.A(in27), .Y(MiscContIn[0]));

   
// MiscInbus[8:0] = { in545, in549, in3173, in136, in1,
//			 in373, in145, in2824, in140 }
   buffer addedBuf243 (.A(in545), .Y(MiscInbus[8]));
   buffer addedBuf244 (.A(in549), .Y(MiscInbus[7]));
   buffer addedBuf245 (.A(in3173), .Y(MiscInbus[6]));
   buffer addedBuf246 (.A(in136), .Y(MiscInbus[5]));
   buffer addedBuf247 (.A(in1), .Y(MiscInbus[4]));
   buffer addedBuf248 (.A(in373), .Y(MiscInbus[3]));
   buffer addedBuf249 (.A(in145), .Y(MiscInbus[2]));
   buffer addedBuf250 (.A(in2824), .Y(MiscInbus[1]));
   buffer addedBuf251 (.A(in140), .Y(MiscInbus[0]));


// outputs   

   
// out658 = OP1
   buffer addedBuf239 (.A(OP1), .Y(out658));

// out690 = OP2
   buffer addedBuf240 (.A(OP2), .Y(out690));

// out767 = OP3
   buffer addedBuf241 (.A(OP3), .Y(out767));

// out807 = OP4
   buffer addedBuf242 (.A(OP4), .Y(out807));


   
// { out654, out651, out648, out645, out642,
//	out670, out667, out664, out661 } = OF1bus[8:0]
   buffer addedBuf203 (.A(OF1bus[8]), .Y(out654));
   buffer addedBuf204 (.A(OF1bus[7]), .Y(out651));
   buffer addedBuf205 (.A(OF1bus[6]), .Y(out648));
   buffer addedBuf206 (.A(OF1bus[5]), .Y(out645));
   buffer addedBuf207 (.A(OF1bus[4]), .Y(out642));
   buffer addedBuf208 (.A(OF1bus[3]), .Y(out670));
   buffer addedBuf209 (.A(OF1bus[2]), .Y(out667));
   buffer addedBuf210 (.A(OF1bus[1]), .Y(out664));
   buffer addedBuf211 (.A(OF1bus[0]), .Y(out661));

// { out688, out685, out682, out679, out676,
//	out702, out699, out696, out693 } = OF2bus[8:0]
   buffer addedBuf212 (.A(OF2bus[8]), .Y(out688));
   buffer addedBuf213 (.A(OF2bus[7]), .Y(out685));
   buffer addedBuf214 (.A(OF2bus[6]), .Y(out682));
   buffer addedBuf215 (.A(OF2bus[5]), .Y(out679));
   buffer addedBuf216 (.A(OF2bus[4]), .Y(out676));
   buffer addedBuf217 (.A(OF2bus[3]), .Y(out702));
   buffer addedBuf218 (.A(OF2bus[2]), .Y(out699));
   buffer addedBuf219 (.A(OF2bus[1]), .Y(out696));
   buffer addedBuf220 (.A(OF2bus[0]), .Y(out693));

// { out727, out732, out737, out742, out747,
//	out752, out757, out762, out722 } = OF3bus[8:0]
   buffer addedBuf221 (.A(OF3bus[8]), .Y(out727));
   buffer addedBuf222 (.A(OF3bus[7]), .Y(out732));
   buffer addedBuf223 (.A(OF3bus[6]), .Y(out737));
   buffer addedBuf224 (.A(OF3bus[5]), .Y(out742));
   buffer addedBuf225 (.A(OF3bus[4]), .Y(out747));
   buffer addedBuf226 (.A(OF3bus[3]), .Y(out752));
   buffer addedBuf227 (.A(OF3bus[2]), .Y(out757));
   buffer addedBuf228 (.A(OF3bus[1]), .Y(out762));
   buffer addedBuf229 (.A(OF3bus[0]), .Y(out722));

// { out712, out772, out777, out782, out787,
//	out792, out797, out802, out859 } = OF4bus[8:0]
   buffer addedBuf230 (.A(OF4bus[8]), .Y(out712));
   buffer addedBuf231 (.A(OF4bus[7]), .Y(out772));
   buffer addedBuf232 (.A(OF4bus[6]), .Y(out777));
   buffer addedBuf233 (.A(OF4bus[5]), .Y(out782));
   buffer addedBuf234 (.A(OF4bus[4]), .Y(out787));
   buffer addedBuf235 (.A(OF4bus[3]), .Y(out792));
   buffer addedBuf236 (.A(OF4bus[2]), .Y(out797));
   buffer addedBuf237 (.A(OF4bus[1]), .Y(out802));
   buffer addedBuf238 (.A(OF4bus[0]), .Y(out859));


   
// { out824, out826, out828, out830, out832,
//	out834, out836, out838, out822 } = NotXFbus[8:0]
   buffer addedBuf185 (.A(NotXFbus[8]), .Y(out824));
   buffer addedBuf186 (.A(NotXFbus[7]), .Y(out826));
   buffer addedBuf187 (.A(NotXFbus[6]), .Y(out828));
   buffer addedBuf188 (.A(NotXFbus[5]), .Y(out830));
   buffer addedBuf189 (.A(NotXFbus[4]), .Y(out832));
   buffer addedBuf190 (.A(NotXFbus[3]), .Y(out834));
   buffer addedBuf191 (.A(NotXFbus[2]), .Y(out836));
   buffer addedBuf192 (.A(NotXFbus[1]), .Y(out838));
   buffer addedBuf193 (.A(NotXFbus[0]), .Y(out822));

// { out863, out865, out867, out869, out871,
//	out873, out875, out877, out861 } = NotYFbus[8:0]
   buffer addedBuf194 (.A(NotYFbus[8]), .Y(out863));
   buffer addedBuf195 (.A(NotYFbus[7]), .Y(out865));
   buffer addedBuf196 (.A(NotYFbus[6]), .Y(out867));
   buffer addedBuf197 (.A(NotYFbus[5]), .Y(out869));
   buffer addedBuf198 (.A(NotYFbus[4]), .Y(out871));
   buffer addedBuf199 (.A(NotYFbus[3]), .Y(out873));
   buffer addedBuf200 (.A(NotYFbus[2]), .Y(out875));
   buffer addedBuf201 (.A(NotYFbus[1]), .Y(out877));
   buffer addedBuf202 (.A(NotYFbus[0]), .Y(out861));


   
// out629 = CoutFX_in0
   buffer addedBuf181 (.A(CoutFX_in0), .Y(out629));

// out591 = CoutFY_in0
   buffer addedBuf182 (.A(CoutFY_in0), .Y(out591));

// out618 = CoutFX_in0
   buffer addedBuf183 (.A(CoutFX_in0), .Y(out618));

// out621 = CoutFY_in0
   buffer addedBuf184 (.A(CoutFY_in0), .Y(out621));


   
// out615 = PropThruX
   buffer addedBuf177 (.A(PropThruX), .Y(out615));

// out588 = PropThruY
   buffer addedBuf178 (.A(PropThruY), .Y(out588));

// out626 = PropThruX
   buffer addedBuf179 (.A(PropThruX), .Y(out626));

// out632 = PropThruY
   buffer addedBuf180 (.A(PropThruY), .Y(out632));


   
// out843 = SumLogicParXout
   buffer addedBuf175 (.A(SumLogicParXout), .Y(out843));

// out882 = SumLogicParYout
   buffer addedBuf176 (.A(SumLogicParYout), .Y(out882));
 

   
// { out585, out575, out598, out610 } = ZeroFlagOut[3:0]
   buffer addedBuf171 (.A(ZeroFlagOut[3]), .Y(out585));
   buffer addedBuf172 (.A(ZeroFlagOut[2]), .Y(out575));
   buffer addedBuf173 (.A(ZeroFlagOut[1]), .Y(out598));
   buffer addedBuf174 (.A(ZeroFlagOut[0]), .Y(out610));


   
// { out998, out1002, out1000, out1004, out854 } = ParChkOut[4:0]
   buffer addedBuf166 (.A(ParChkOut[4]), .Y(out998));
   buffer addedBuf167 (.A(ParChkOut[3]), .Y(out1002));
   buffer addedBuf168 (.A(ParChkOut[2]), .Y(out1000));
   buffer addedBuf169 (.A(ParChkOut[1]), .Y(out1004));
   buffer addedBuf170 (.A(ParChkOut[0]), .Y(out854));


   
// { out623, out813, out818, out707, out715, out639,
//	out673, out636, out820, out717, out704 } = MiscMuxOut[10:0]
   buffer addedBuf155 (.A(MiscMuxOut[10]), .Y(out623));
   buffer addedBuf156 (.A(MiscMuxOut[9]), .Y(out813));
   buffer addedBuf157 (.A(MiscMuxOut[8]), .Y(out818));
   buffer addedBuf158 (.A(MiscMuxOut[7]), .Y(out707));
   buffer addedBuf159 (.A(MiscMuxOut[6]), .Y(out715));
   buffer addedBuf160 (.A(MiscMuxOut[5]), .Y(out639));
   buffer addedBuf161 (.A(MiscMuxOut[4]), .Y(out673));
   buffer addedBuf162 (.A(MiscMuxOut[3]), .Y(out636));
   buffer addedBuf163 (.A(MiscMuxOut[2]), .Y(out820));
   buffer addedBuf164 (.A(MiscMuxOut[1]), .Y(out717));
   buffer addedBuf165 (.A(MiscMuxOut[0]), .Y(out704));

   
// { out593, out594, out602, out809, out611, out599,
//	out612, out600, out850, out848, out849, out851,
//	out887, out298, out926, out892, out973, out993,
//	out144, out601, out847, out815, out634, out810,
//	out845, out656 } = MiscOutbus[25:0]
   buffer addedBuf129 (.A(MiscOutbus[25]), .Y(out593));
   buffer addedBuf130 (.A(MiscOutbus[24]), .Y(out594));
   buffer addedBuf131 (.A(MiscOutbus[23]), .Y(out602));
   buffer addedBuf132 (.A(MiscOutbus[22]), .Y(out809));
   buffer addedBuf133 (.A(MiscOutbus[21]), .Y(out611));
   buffer addedBuf134 (.A(MiscOutbus[20]), .Y(out599));
   buffer addedBuf135 (.A(MiscOutbus[19]), .Y(out612));
   buffer addedBuf136 (.A(MiscOutbus[18]), .Y(out600));
   buffer addedBuf137 (.A(MiscOutbus[17]), .Y(out850));
   buffer addedBuf138 (.A(MiscOutbus[16]), .Y(out848));
   buffer addedBuf139 (.A(MiscOutbus[15]), .Y(out849));
   buffer addedBuf140 (.A(MiscOutbus[14]), .Y(out851));
   buffer addedBuf141 (.A(MiscOutbus[13]), .Y(out887));
   buffer addedBuf142 (.A(MiscOutbus[12]), .Y(out298));
   buffer addedBuf143 (.A(MiscOutbus[11]), .Y(out926));
   buffer addedBuf144 (.A(MiscOutbus[10]), .Y(out892));
   buffer addedBuf145 (.A(MiscOutbus[9]), .Y(out973));
   buffer addedBuf146 (.A(MiscOutbus[8]), .Y(out993));
   buffer addedBuf147 (.A(MiscOutbus[7]), .Y(out144));
   buffer addedBuf148 (.A(MiscOutbus[6]), .Y(out601));
   buffer addedBuf149 (.A(MiscOutbus[5]), .Y(out847));
   buffer addedBuf150 (.A(MiscOutbus[4]), .Y(out815));
   buffer addedBuf151 (.A(MiscOutbus[3]), .Y(out634));
   buffer addedBuf152 (.A(MiscOutbus[2]), .Y(out810));
   buffer addedBuf153 (.A(MiscOutbus[1]), .Y(out845));
   buffer addedBuf154 (.A(MiscOutbus[0]), .Y(out656));


// identical misc. outputs
   
// out923 = out144
   buffer addedBuf120 (.A(out144), .Y(out923));

// out939 = out993
   buffer addedBuf121 (.A(out993), .Y(out939));

// out921 = out993
   buffer addedBuf122 (.A(out993), .Y(out921));

// out978 = out993
   buffer addedBuf123 (.A(out993), .Y(out978));

// out949 = out993
   buffer addedBuf124 (.A(out993), .Y(out949));

// out889 = out887
   buffer addedBuf125 (.A(out887), .Y(out889));

// out603 = out594
   buffer addedBuf126 (.A(out594), .Y(out603));

// out604 = out594
   buffer addedBuf127 (.A(out594), .Y(out604));

// out606 = out602
   buffer addedBuf128 (.A(out602), .Y(out606));



/* instantiate top level circuit */

   TopLevel5315 Ckt5315( X0bus, X1bus, Abus, Y0bus, Y1bus, Bbus, CinFX, CinFY,
			 CinParX, CinParY, MuxSelX, MuxSelY, MuxSelPF,
			 QF1bus, QF2bus, QF3bus, QF4bus, QP1, QP2, QP3, QP4,
			 WXbus, WYbus, ContLogic, ParXin, ParYin, ContParChk,
			 MiscMuxIn, MiscContIn, MiscInbus, WparX, WparY,
				 
			 OF1bus, OF2bus, OF3bus, OF4bus, OP1, OP2, OP3, OP4,
			 SumLogicParXout, SumLogicParYout, CoutFX_in0, CoutFY_in0,
			 PropThruX, PropThruY, NotXFbus, NotYFbus, ZeroFlagOut,
			 ParChkOut, MiscMuxOut, MiscOutbus	);


endmodule // Circuit5315

