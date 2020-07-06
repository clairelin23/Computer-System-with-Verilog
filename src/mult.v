// Name: mult.v
// Module: MULT32 , MULT32_U
//
// Output: HI: 32 higher bits
//         LO: 32 lower bits
//         
//
// Input: A : 32-bit input
//        B : 32-bit input
//
// Notes: 32-bit multiplication
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

module MULT32(HI, LO, A, B);
// output list
output [31:0] HI;
output [31:0] LO;
// input list
input [31:0] A; //MCND
input [31:0] B;

wire [31:0] out_1, out_2, out_3;
wire [31:0] in_mul1, in_mul2;
wire [63:0] mul_out, twos64_out;
wire xor_out;

TWOSCOMP32 tcm_inst1 (out_1,A);
MUX32_2x1 mu_1(in_mul1,  A, out_1, A[31]);
TWOSCOMP32 tcm_inst2 (out_2,B);
MUX32_2x1 mu_2 (in_mul2,  B, out_2, B[31]);
MULT32_U mul_1 (mul_out[63:32], mul_out[31:0], in_mul1, in_mul2);
xor xor_inst1 (xor_out, A[31], B[31]);
TWOSCOMP64 tcm_inst3 (twos64_out,mul_out);
MUX32_2x1 mu_3(LO,  mul_out[31:0], twos64_out[31:0], xor_out);
MUX32_2x1 mu_4(HI,  mul_out[63:32], twos64_out[63:32], xor_out);
endmodule

module MULT32_U(HI, LO, A, B);
// output list
output [31:0] HI;
output [31:0] LO;
// input list
input [31:0] A;
input [31:0] B;

wire [31:0] and_out [0:31];
wire [31:0] carry_out;
wire co_not_used;

AND32_2x1 and32_inst1 (and_out[0],A,{32{B[0]}});
assign carry_out[0] =1'b0;
assign LO[0] = and_out[0][0];

genvar i;
generate
    for(i =1; i<32; i = i+1)
    begin : mul32_gen_loop
	wire [31:0] left_out;
	AND32_2x1 and32_inst (left_out ,A,{32{B[i]}}); //check
	RC_ADD_SUB_32 rc_inst (and_out[i], carry_out[i], left_out,{carry_out[i-1],{and_out[i-1][31:1]}} , 1'b0);
	assign LO[i] = and_out[i][0];
    end
endgenerate
RC_ADD_SUB_32 add_inst (HI, co_not_used, {32'b0}, {carry_out[31], {and_out[31][31:1]}}, {1'b0});

endmodule
