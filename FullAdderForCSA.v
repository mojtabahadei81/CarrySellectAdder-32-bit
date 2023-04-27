`timescale 1ns/1ps
module FullAdderForCSA (input1, input2, result, cin, cout);
    input input1;
    input input2;
    output reg result;
    input cin;
    output reg cout;
    always @(*) begin
		cout <= (input1 & input2) | ((input1 ^ input2) & cin);
		result <= input1^input2^cin;
    end
endmodule