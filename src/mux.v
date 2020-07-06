// Name: mux.v
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
// 32-bit mux
module MUX32_32x1(Y, I0, I1, I2, I3, I4, I5, I6, I7,
                     I8, I9, I10, I11, I12, I13, I14, I15,
                     I16, I17, I18, I19, I20, I21, I22, I23,
                     I24, I25, I26, I27, I28, I29, I30, I31, S);
// output list
output [31:0] Y;
//input list
input [31:0] I0, I1, I2, I3, I4, I5, I6, I7;
input [31:0] I8, I9, I10, I11, I12, I13, I14, I15;
input [31:0] I16, I17, I18, I19, I20, I21, I22, I23;
input [31:0] I24, I25, I26, I27, I28, I29, I30, I31;
input [4:0] S;

wire[31:0] mu_out1, mu_out2;
MUX32_16x1 inst1 (mu_out1, I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, S[3:0]);
MUX32_16x1 inst2 (mu_out2, I16, I17, I18, I19, I20, I21, I22, I23, I24, I25, I26, I27, I28, I29, I30, I31, S[3:0]);
MUX32_2x1 inst3 (Y, mu_out1, mu_out2, S[4]);

endmodule

// 32-bit 16x1 mux
module MUX32_16x1(Y, I0, I1, I2, I3, I4, I5, I6, I7,
                     I8, I9, I10, I11, I12, I13, I14, I15, S);
// output list
output [31:0] Y;
//input list
input [31:0] I0;
input [31:0] I1;
input [31:0] I2;
input [31:0] I3;
input [31:0] I4;
input [31:0] I5;
input [31:0] I6;
input [31:0] I7;
input [31:0] I8;
input [31:0] I9;
input [31:0] I10;
input [31:0] I11;
input [31:0] I12;
input [31:0] I13;
input [31:0] I14;
input [31:0] I15;
input [3:0] S;
wire[31:0] mu_out1, mu_out2;
MUX32_8x1 inst1 (mu_out1, I0, I1, I2, I3, I4, I5, I6, I7, S[2:0]);
MUX32_8x1 inst2 (mu_out2, I8, I9, I10, I11, I12, I13, I14, I15, S[2:0]);
MUX32_2x1 inst3 (Y, mu_out1, mu_out2, S[3]);
endmodule

// 32-bit 8x1 mux
module MUX32_8x1(Y, I0, I1, I2, I3, I4, I5, I6, I7, S);
// output list
output [31:0] Y;
//input list
input [31:0] I0;
input [31:0] I1;
input [31:0] I2;
input [31:0] I3;
input [31:0] I4;
input [31:0] I5;
input [31:0] I6;
input [31:0] I7;
input [2:0] S;
wire[31:0] mu_out1, mu_out2;

MUX32_4x1 inst1(mu_out1, I0, I1, I2, I3, S[1:0]);
MUX32_4x1 inst2(mu_out2, I4, I5, I6, I7, S[1:0]);
MUX32_2x1 inst3 (Y, mu_out1, mu_out2, S[2]);
endmodule

// 32-bit 4x1 mux
module MUX32_4x1(Y, I0, I1, I2, I3, S);
// output list
output [31:0] Y;
//input list
input [31:0] I0;
input [31:0] I1;
input [31:0] I2;
input [31:0] I3;
input [1:0] S;

wire[31:0] mu_out1, mu_out2;

MUX32_2x1 inst1 (mu_out1, I0, I1, S[0]);
MUX32_2x1 inst2 (mu_out2, I2, I3, S[0]);
MUX32_2x1 inst3 (Y, mu_out1, mu_out2, S[1]);
endmodule

// 32-bit mux
module MUX32_2x1(Y, I0, I1, S);
output [31:0] Y;
input [31:0] I0;
input [31:0] I1;
input S;

genvar i;
generate
    for(i =0; i<32; i = i+1)
    begin : mux32_gen_loop
	MUX1_2x1 mux_inst (Y[i], I0[i], I1[i],S);
    end 
endgenerate

endmodule

// 1-bit mux
module MUX1_2x1(Y,I0, I1, S);
output Y;
input I0, I1, S;
wire and_imm1, inv_imm, and_imm2;

and  and_inst1 (and_imm1, I1, S);
not not_inst1 (inv_imm, S);
and and_inst2 (and_imm2, inv_imm, I0);
or or_inst1 (Y, and_imm1, and_imm2);

endmodule
