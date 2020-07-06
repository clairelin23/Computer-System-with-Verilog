// Name: rc_add_sub_32.v
// Module: RC_ADD_SUB_32
//
// Output: Y : Output 32-bit
//         CO : Carry Out
//         
//
// Input: A : 32-bit input
//        B : 32-bit input
//        SnA : if SnA=0 it is add, subtraction otherwise
//
// Notes: 32-bit adder / subtractor implementaiton.
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

module RC_ADD_SUB_64(Y, CO, A, B, SnA);
output [63:0] Y;
output CO;
input [63:0] A;
input [63:0] B;
input SnA;
wire [63:0] xor_result, co_imm_result;//may need change

genvar i;
generate
    for(i =0; i<64; i = i+1)
    begin : xor64_gen_loop
	xor xor_inst (xor_result[i], SnA, B[i]);
    end
endgenerate

    FULL_ADDER fa_inst1(Y[0],co_imm_result[0], A[0],xor_result[0], SnA);

genvar j;
generate
    for(j =1; j<64; j = j+1)
    begin : fa64_gen_loop
	 FULL_ADDER fa_inst (Y[j], co_imm_result[j], A[j], xor_result[j],co_imm_result[j-1]);
    end
endgenerate
assign CO = co_imm_result[63];
endmodule

module RC_ADD_SUB_32(Y, CO, A, B, SnA);
output [`DATA_INDEX_LIMIT:0] Y;
output CO;
input [`DATA_INDEX_LIMIT:0] A;
input [`DATA_INDEX_LIMIT:0] B;
input SnA;
wire [31:0] xor_result, co_imm_result;//may need change

genvar i;
generate
    for(i =0; i<32; i = i+1)
    begin : xor32_gen_loop
	xor xor_inst (xor_result[i], SnA, B[i]);
    end
endgenerate
    FULL_ADDER fa_inst1(Y[0],co_imm_result[0], A[0],xor_result[0], SnA);

genvar j;
generate
    for(j =1; j<32; j = j+1)
    begin : fa32_gen_loop
	 FULL_ADDER fa_inst (Y[j], co_imm_result[j], A[j], xor_result[j],co_imm_result[j-1]);
    end
endgenerate
assign CO = co_imm_result[31];
endmodule

