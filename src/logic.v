// Name: logic.v
// Module: 
// Input: 
// Output: 
//
// Notes: Common definitions
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 02, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
//
// 64-bit two's complement
module TWOSCOMP64(Y,A);
//output list
output [63:0] Y;
//input list
input [63:0] A;

wire [63:0] inv_out;
wire CO_NOT_NEED;

INV32_1x1 inv_inst1 (inv_out[31:0],A[31:0]);
INV32_1x1 inv_inst2 (inv_out[63:32],A[63:32]);
RC_ADD_SUB_64 rc_inst1 (Y, CO_NOT_NEED, inv_out, {64'b1},{ 1'b0});

endmodule

// 32-bit two's complement
module TWOSCOMP32(Y,A);
//output list
output [31:0] Y;
//input list
input [31:0] A;
wire [31:0] inv_out;
wire CO_NOT_NEED;

INV32_1x1 inv_inst(inv_out,A);
RC_ADD_SUB_32 rc_inst1 (Y, CO_NOT_NEED, inv_out, {32'b1}, {1'b0});

endmodule

// 32-bit registere +ve edge, Reset on RESET=0
module REG32(Q, D, LOAD, CLK, RESET);
output [31:0] Q;
input CLK, LOAD;
input [31:0] D;
input RESET;

wire [31:0] qbar;
genvar i;
generate
    for(i =0; i<32; i = i+1)
    begin : reg32_gen_loop
        REG1 reg_inst1 (Q[i], qbar[i], D[i], LOAD, CLK, {1'b1}, RESET);
    end 
endgenerate
endmodule

// 1 bit register +ve edge, 
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module REG1(Q, Qbar, D, L, C, nP, nR);
input D, C, L;
input nP, nR;
output Q,Qbar;

wire mux_out, f_out;
MUX1_2x1 mux_inst1 (mux_out,f_out, D, L);
D_FF df_inst1 (f_out, Qbar, mux_out, C, nP, nR);
buf (Q, f_out);
endmodule

// 1 bit flipflop +ve edge, 
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module D_FF(Q, Qbar, D, C, nP, nR);
input D, C;
input nP, nR;
output Q,Qbar;

wire Y, Ybar;

D_LATCH inst1(Y, Ybar, D, C, nP, nR);
SR_LATCH inst2 (Q,Qbar, Y, Ybar, C, nP, nR);

endmodule


// 1 bit D latch
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module D_LATCH(Q, Qbar, D, C, nP, nR);
input D, C;
input nP, nR;
output Q,Qbar;

wire nand_out1, nand_out2, nand_out3, nand_out4;
wire inv_out;

not not_inst1 (inv_out, D);
nand nand_inst1 (nand_out1, D, C);
nand nand_inst2 (nand_out2, inv_out, C);
nand_3bit nand_inst3 (nand_out3, nand_out1, nand_out4, nP);
nand_3bit nand_inst4 (nand_out4, nand_out2, nand_out3, nR);
buf b1 (Q,nand_out3);
buf b2 (Qbar, nand_out4);
endmodule

// 1 bit SR latch
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module SR_LATCH(Q,Qbar, S, R, C, nP, nR);
input S, R, C;
input nP, nR;
output Q,Qbar;

wire nand_out5, nand_out6, nand_out7, nand_out8;
wire inv_out2;

not not_inst2 (inv_out2, C);
nand nand_inst5 (nand_out5, S, inv_out2);
nand nand_inst6 (nand_out6, inv_out2, R);
nand_3bit nand_inst7 (nand_out7, nand_out5, nand_out8, nP);
nand_3bit nand_inst8 (nand_out8, nand_out7, nand_out6, nR);
buf b1 (Q,nand_out7);
buf b2 (Qbar, nand_out8);

endmodule

//3 input nand
module nand_3bit(Y,I0, I1, I2);
input I0, I1, I2;
output Y;
wire temp, temp2;
	and nand_inst1 (temp, I0, I1);
        and nand_inst2 (temp2, I2, temp);
        not not_inst1 (Y, temp2);
endmodule

// 5x32 Line decoder
module DECODER_5x32(D,I);
// output
output [31:0] D;
// input
input [4:0] I;

wire [15:0] D_out;
wire  inv_out3;

DECODER_4x16 inst1(D_out,I[3:0]);
not  not_inst1 (inv_out3, I[4]);

and and_inst0 (D[0], D_out[0], inv_out3);
and and_inst1 (D[1], D_out[1], inv_out3);
and and_inst2 (D[2], D_out[2], inv_out3);
and and_inst3 (D[3], D_out[3], inv_out3);
and and_inst4 (D[4], D_out[4], inv_out3);
and and_inst5 (D[5], D_out[5], inv_out3);
and and_inst6 (D[6], D_out[6], inv_out3);
and and_inst7 (D[7], D_out[7], inv_out3);
and and_inst8 (D[8], D_out[8], inv_out3);
and and_inst9 (D[9], D_out[9], inv_out3);
and and_inst10 (D[10], D_out[10], inv_out3);
and and_inst11 (D[11], D_out[11], inv_out3);
and and_inst12 (D[12], D_out[12], inv_out3);
and and_inst13 (D[13], D_out[13], inv_out3);
and and_inst14 (D[14], D_out[14],inv_out3);
and and_inst15 (D[15], D_out[15], inv_out3);
and and_inst16 (D[16], D_out[0], I[4]);
and and_inst17 (D[17], D_out[1], I[4]);
and and_inst18 (D[18], D_out[2], I[4]);
and and_inst19 (D[19], D_out[3], I[4]);
and and_inst20 (D[20], D_out[4],I[4]);
and and_inst21 (D[21], D_out[5], I[4]);
and and_inst22 (D[22], D_out[6], I[4]);
and and_inst23 (D[23], D_out[7],I[4]);
and and_inst24 (D[24], D_out[8], I[4]);
and and_inst25 (D[25], D_out[9], I[4]);
and and_inst26 (D[26], D_out[10], I[4]);
and and_inst27 (D[27], D_out[11], I[4]);
and and_inst28 (D[28], D_out[12], I[4]);
and and_inst29 (D[29], D_out[13], I[4]);
and and_inst30 (D[30], D_out[14], I[4]);
and and_inst31 (D[31], D_out[15], I[4]);

endmodule

// 4x16 Line decoder
module DECODER_4x16(D,I);
// output
output [15:0] D;
// input
input [3:0] I;

wire [7:0] D_out;
wire  inv_out3;

DECODER_3x8 inst1(D_out,I[2:0]);
not  not_inst1 (inv_out3, I[3]);

and and_inst0 (D[0], D_out[0], inv_out3);
and and_inst1 (D[1], D_out[1], inv_out3);
and and_inst2 (D[2], D_out[2], inv_out3);
and and_inst3 (D[3], D_out[3], inv_out3);
and and_inst4 (D[4], D_out[4], inv_out3);
and and_inst5 (D[5], D_out[5], inv_out3);
and and_inst6 (D[6], D_out[6], inv_out3);
and and_inst7 (D[7], D_out[7], inv_out3);
and and_inst8 (D[8], D_out[0], I[3]);
and and_inst9 (D[9], D_out[1], I[3]);
and and_inst10 (D[10], D_out[2], I[3]);
and and_inst11 (D[11], D_out[3], I[3]);
and and_inst12 (D[12], D_out[4], I[3]);
and and_inst13 (D[13], D_out[5], I[3]);
and and_inst14 (D[14], D_out[6], I[3]);
and and_inst15 (D[15], D_out[7], I[3]);


endmodule

// 3x8 Line decoder
module DECODER_3x8(D,I);
// output
output [7:0] D;
// input
input [2:0] I;
wire [3:0] D_out;
wire  inv_out2;

DECODER_2x4 inst1(D_out,I[1:0]);
not  not_inst1 (inv_out2, I[2]);

and and_inst1 (D[0], D_out[0], inv_out2);
and and_inst2 (D[1], D_out[1], inv_out2);
and and_inst3 (D[2], D_out[2], inv_out2);
and and_inst4 (D[3], D_out[3], inv_out2);
and and_inst5 (D[4], D_out[0], I[2]);
and and_inst6 (D[5], D_out[1], I[2]);
and and_inst7 (D[6], D_out[2], I[2]);
and and_inst8 (D[7], D_out[3], I[2]);


endmodule

// 2x4 Line decoder
module DECODER_2x4(D,I);
// output
output [3:0] D;
// input
input [1:0] I;
wire inv_out0, inv_out1;
not  not_inst1 (inv_out1, I[1]);
not  not_inst2 (inv_out0, I[0]);
and and_inst1 (D[0], inv_out1, inv_out0);
and and_inst2 (D[1], inv_out1, I[0]);
and and_inst3 (D[2], I[1], inv_out0);
and and_inst4 (D[3], I[1], I[0]);


endmodule