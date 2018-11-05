module inv (A, Y);
   input A;
   output Y;
endmodule

module test_inv_call(I, O);
   input [3:0] I;
   output [3:0] O;
   wire 	in;
   wire 	out;

   inv i1( in,    out);
   inv i2( I[0],  out);
   inv i3( in,    O[1]);
   inv i4( I[2],  O[2]);
   inv i5( .Y(O[3]), .A(I[3]) );
   
endmodule // test_inv_call

   