 // Name: barrel_shifter.v
// Module: SHIFT32_L , SHIFT32_R, SHIFT32
//
// Notes: 32-bit barrel shifter
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

// 32-bit shift amount shifter
module SHIFT32(Y,D,S, LnR);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [31:0] S;
input LnR;
wire [31:0] b_out;
wire [25:0] or_result;

BARREL_SHIFTER32 inst1 (b_out,D,S[4:0], LnR);
or inst_or1 (or_result[0], S[5], S[6]);
genvar i;
generate
    for(i =1; i<=25; i = i+1)
    begin : or27_gen_loop
	or inst_or (or_result[i], S[6+i], or_result[i-1]);
    end 
endgenerate
 MUX32_2x1 inst3 (Y, b_out, {32'b0}, or_result[25]);
endmodule

// Shift with control L or R shift
module BARREL_SHIFTER32(Y,D,S, LnR);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [4:0] S;
input LnR;
wire [31:0] left_out, right_out;

SHIFT32_L inst1 (left_out,D,S);
SHIFT32_R inst2 (right_out,D,S);
MUX32_2x1 inst3 (Y, right_out, left_out, LnR);
endmodule

// Left shifter
module SHIFT32_L(Y,D,S);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [4:0] S;
wire [31:0] mu_out [0:4]; //important row/column direction

MUX1_2x1 mux_inst1 (mu_out[0][0], D[0], {1'b0},S[0]);
genvar i;
generate
    for(i =1; i<32; i = i+1)
    begin : mux32_gen_loop
	MUX1_2x1 mux_inst (mu_out[0][i], D[i], D[i-1],S[0]);
    end 
endgenerate

genvar j, m;
generate
    for(j =1; j<5; j = j+1)
    begin : mux32_gen_loop_inner_column
	for(m =0; m<32; m = m+1)
         begin : mux32_gen_loop_inner_row
             if (m<2**j ) MUX1_2x1 mux_inst1 (mu_out[j][m], mu_out[j-1][m], {1'b0},S[j]);
             else  MUX1_2x1 mux_inst2 (mu_out[j][m], mu_out[j-1][m], mu_out[j-1][m-(2**j)],S[j]);
        end 
    end
endgenerate

assign Y = mu_out[4];

endmodule

// Right shifter
module SHIFT32_R(Y,D,S);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [4:0] S;

wire [31:0] mu_out [0:4]; //important row/column direction

MUX1_2x1 mux_inst1 (mu_out[0][31], D[31], {1'b0},S[0]);
genvar i;
generate
    for(i =0; i<31; i = i+1)
    begin : mux32_gen_loop
	MUX1_2x1 mux_inst (mu_out[0][i], D[i], D[i+1],S[0]);
    end 
endgenerate

genvar j, m;
generate
    for(j =1; j<5; j = j+1)
    begin : mux32_gen_loop_inner_column
	for(m =31; m>=0; m = m-1)
         begin : mux32_gen_loop_inner_row
             if (m> (31- (2**j)) ) MUX1_2x1 mux_inst1 (mu_out[j][m], mu_out[j-1][m], {1'b0},S[j]);
             else  MUX1_2x1 mux_inst2 (mu_out[j][m], mu_out[j-1][m], mu_out[j-1][m+(2**j)],S[j]);
        end 
    end
endgenerate

assign Y = mu_out[4];

endmodule

