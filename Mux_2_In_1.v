`timescale 1ns / 1ps

module Mux_2_In_1 #(parameter BITS = 8) (Input0, cin0, Input1, cin1, Sel, Data_out, cout);
   // constant declaration
   parameter S0 = 1'b0;
   parameter S1 = 1'b1; 
   //inputs
   input [BITS-1:0] Input0;
   input [BITS-1:0] Input1;
   input cin0;
   input cin1;
   input Sel;
   //outputs
   output reg [BITS-1:0] Data_out;
   output reg cout;
   always @ (Sel or Input0 or Input1)
   begin
      case(Sel)
         S0: begin
            Data_out <= Input0;
	    cout <= cin0;
         end
         S1: begin
            Data_out <= Input1;
	    cout <= cin1;
	 end
      endcase
   end
endmodule