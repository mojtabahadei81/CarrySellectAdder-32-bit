`timescale 1ns/1ps
module CarrySelectAdder_32_bit (input1, input2, cin, result, cout);
	input [31:0] input1;
	input [31:0] input2;
	input cin;
	output [31:0] result;
	output cout;
	//Inner Connections
	wire [7:0] bus [0:2][0:1];
	wire [3:0] muxSelect;
	wire rippleAddersCout[0:2][0:1];
	wire [7:0] littleMuxResults [0:2];
	wire muxCouts [0:3];
	wire [15:0] bigMUXResult; //change output to wire and delete from ()
	//digit as RCAs Cins
	reg digit[0:1];
	initial begin
		digit[1] = 1'b1;
		digit[0] = 1'b0;
	end
	//instantiate necessary modules
	N_bit_RippleCarryAdder rca0 (
		.input1(input1[7:0]),
		.input2(input2[7:0]),
		.result(result[7:0]),
		.cin(cin),
		.cout(muxSelect[0])
	);
	genvar i,j;
	generate
		for(j = 0; j < 3; j = j + 1) begin
			for(i = 0; i < 2; i = i + 1) begin
				N_bit_RippleCarryAdder rcas (
					.input1(input1[(j+2)*8-1:(j+1)*8]),
					.input2(input2[(j+2)*8-1:(j+1)*8]),
					.result(bus[j][i]),
					.cin(digit[i]),
					.cout(rippleAddersCout[j][i])
				);
			end
		end
	endgenerate
	genvar k;
	generate
		for(k = 0; k < 3; k = k + 1) begin
			Mux_2_In_1 littleMUXs (
				.Input0(bus[k][0]),
				.Input1(bus[k][1]),
				.cin0(rippleAddersCout[k][0]),
				.cin1(rippleAddersCout[k][1]),
				.Sel(muxSelect[k]),
				.Data_out(littleMuxResults[k]),
				.cout(muxCouts[k])
			);
		end
	endgenerate
	assign muxSelect[1] = rippleAddersCout[1][0];
	assign muxSelect[2] = rippleAddersCout[1][1];
	assign muxSelect[3] = muxCouts[0];
	Mux_2_In_1 #(16) bigMUX (
		.Input0({littleMuxResults[1],bus[1][0]}),
		.Input1({littleMuxResults[2],bus[1][1]}),
		.cin0(muxCouts[1]),
		.cin1(muxCouts[2]),
		.Sel(muxSelect[3]),
		.Data_out(bigMUXResult),
		.cout(cout)
	);
	assign result[31:8] = {bigMUXResult, littleMuxResults[0]};
endmodule