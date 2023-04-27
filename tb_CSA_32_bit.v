`timescale 1ns/1ps
module tb_CSA_32_bit;
	//module CarrySelectAdder_32_bit (input1, input2, cin, result, cout);
	reg [31:0] input1;
	reg [31:0] input2;
	reg c0;
	wire [31:0] result;
	wire cout;
	CarrySelectAdder_32_bit uut(
		.input1(input1),
		.input2(input2),
		.cin(c0),
		.result(result),
		.cout(cout)
	);
	initial begin
		input1 = 32'h11abcdef;
		input2 = 32'h00aabbcc;
		c0 = 1'b0;
		#20;
		input1 = 32'h5233458;
		input2 = 32'h4578213;
		c0 = 1'b0;
		#20;
		input1 = 32'd0025366408;
		input2 = 32'd40010303;
		c0 = 1'b0;
		#20;
	end
endmodule

