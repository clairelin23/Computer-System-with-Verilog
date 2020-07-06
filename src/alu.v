// Name: alu.v
// Module: ALU

// Notes: 32 bit combinatorial ALU
// 
// Supports the following functions
//	- Integer add (0x1), sub(0x2), mul(0x3)
//	- Integer shift_rigth (0x4), shift_left (0x5)
//	- Bitwise and (0x6), or (0x7), nor (0x8)
//  - set less than (0x9)
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
//
`include "prj_definition.v"
module ALU(OUT, ZERO, OP1, OP2, OPRN);
// input list
input [`DATA_INDEX_LIMIT:0] OP1; // operand 1
input [`DATA_INDEX_LIMIT:0] OP2; // operand 2
input [`ALU_OPRN_INDEX_LIMIT:0] OPRN; // operation code

// output list
output [`DATA_INDEX_LIMIT:0] OUT; // result of the operation.
output ZERO;

wire SnA, SnA_out1, SnA_out2;
wire LnR, coNoNeed;//carry bit of add/sub operations
wire [31:0] addsub_out, mul_out, mulHiNoNeed, shift_out, and_out, or_out, nor_out;
wire [31:0] NoResult;
wire [30:0] or_result;

 nor nor1 (SnA_out1, OPRN[0]);
 and and1 (SnA_out2, OPRN[3], OPRN[0]);
 or or1 (SnA, SnA_out1, SnA_out2);
 assign LnR = OPRN[0];

 RC_ADD_SUB_32 addsub1 (addsub_out, coNoNeed, OP1, OP2, SnA);
 MULT32 mul_inst1 (mulHiNoNeed, mul_out, OP1, OP2);
 SHIFT32 sh_inst1 (shift_out,OP1,OP2, LnR);
 AND32_2x1 and_inst1(and_out,OP1,OP2);
 OR32_2x1 or_inst1 (or_out,OP1,OP2);
 NOR32_2x1 nor_inst1 (nor_out,OP1,OP2);

 MUX32_16x1 mu_inst1 (OUT, NoResult,addsub_out ,addsub_out, mul_out, shift_out, shift_out, and_out, or_out, nor_out,
            {{31'b0},addsub_out[31]},NoResult , NoResult, NoResult, NoResult, NoResult, NoResult, OPRN[3:0]);

or inst_or11 (or_result[0], OUT[0], OUT[1]);
genvar i;
generate
    for(i =2; i<=31; i = i+1)
    begin : or30_gen_loop
	or inst_or12 (or_result[i-1], OUT[i], or_result[i-2]);
    end 
endgenerate

not not_inst1 (ZERO,or_result[30]);
endmodule
