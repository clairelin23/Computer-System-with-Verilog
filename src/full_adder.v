// Name: full_adder.v
// Module: FULL_ADDER
//
// Output: S : Sum
//         CO : Carry Out
//
// Input: A : Bit 1
//        B : Bit 2
//        CI : Carry In
//
// Notes: 1-bit full adder implementaiton.
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

module FULL_ADDER(S,CO,A,B, CI);
output S,CO;
input A,B, CI;

//use wire for intermediet outputs?
wire half_add_out1, half_add_out2, half_add_out3;

HALF_ADDER ha_inst1 (.Y(half_add_out1),.C(half_add_out2),.A(A),.B(B));
HALF_ADDER ha_inst2 (.Y(S),.C(half_add_out3),.A(half_add_out1),.B(CI));
or inst3(CO,half_add_out3, half_add_out2);


endmodule
