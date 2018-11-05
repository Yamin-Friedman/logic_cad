
module EDFFX1 ( D , CK, E, Q );
input [4:0] D;
output [2:0] CK;
input E,Q;
wire abc[1], abc[2:0];
endmodule

module dram ( clk, address, we, din, dout );
input  [6:0] address;
output [2:0] dout;
input  [2:0] din;
input  clk, we;
wire n1111, n1234, n5121, mytest[1];

EDFFX1 edffxax (.CK(mytest[1]) );
EDFFX1 edffx2ndins (.CK(dout[2:0]),  .Q(we) , .E(n5121), .D( { address[6], address[5], address[4], address[3], address[2] } ));

endmodule


module dramtester ( D , CK, E, Q );
input D;
output [2:0] CK;
input E,Q;
wire abc[2:0];

dram dram1 ( .din(3'b110) );
endmodule
