`timescale 1ns/1ps
module N_bit_RippleCarryAdder(input1, input2, result, cout, cin);
 parameter N = 8;
 input [N-1:0] input1;
 input [N-1:0] input2;
 input cin;
 output [N-1:0] result;
 output cout;
 wire [N:0] carry;
 assign cout = carry[N];
 assign carry[0] = cin;
 // instantiating N 1-bit full adders in Verilog
 genvar i;
 generate
    for(i = 0; i < N; i = i + 1) begin
 	FullAdderForCSA f (
     	.input1(input1[i]),
	    .input2(input2[i]),
	    .result(result[i]),
	    .cin(carry[i]),
	    .cout(carry[i+1])
 	);
	end
 endgenerate
endmodule