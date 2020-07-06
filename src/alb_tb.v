`timescale 1ns/10ps

// Notes: Testbench for ALU functionality
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 02, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//  1.1     Sep 04, 2014	Kaushik Patra	kpatra@sjsu.edu		Fixed test_and_count task
//                                                                      to count number of test and
//                                                                      pass correctly.
//------------------------------------------------------------------------------------------
//
module alu_tb;

integer total_test;
integer pass_test;

reg [5:0] oprn_reg;
reg [31:0] op1_reg;
reg [31:0] op2_reg;

wire [31:0] r_net;
wire zero;


ALU ALU_INST_01(.OUT(r_net), .ZERO(zero), .OP1(op1_reg), 
                .OP2(op2_reg), .OPRN(oprn_reg));

// Drive the test patterns and test
initial
begin
op1_reg=0;
op2_reg=0;
oprn_reg=0;

total_test = 0;
pass_test = 0;

// test 15 + 3 = 18
#5  op1_reg=15;
    op2_reg=3;
    oprn_reg=6'h01;
#5  test_and_count(total_test, pass_test, 
                   test_golden(op1_reg,op2_reg,oprn_reg,r_net));
#5  op1_reg=15;
    op2_reg=5;
    oprn_reg=6'h02;   
#5  test_and_count(total_test, pass_test, 
                   test_golden(op1_reg,op2_reg,oprn_reg,r_net));
#5  op1_reg=15;
    op2_reg=5;
    oprn_reg=6'h03;
#5  test_and_count(total_test, pass_test, 
                   test_golden(op1_reg,op2_reg,oprn_reg,r_net));

#5  op1_reg=15;
    op2_reg=0;
    oprn_reg=6'h03;
#5  test_and_count(total_test, pass_test, 
                   test_golden(op1_reg,op2_reg,oprn_reg,r_net));
#5  op1_reg=15;
    op2_reg=5;
    oprn_reg=6'h04;
#5  test_and_count(total_test, pass_test, 
                   test_golden(op1_reg,op2_reg,oprn_reg,r_net));

#5  op1_reg=15;
    op2_reg=5;
    oprn_reg=6'h05;
#5  test_and_count(total_test, pass_test, 
                   test_golden(op1_reg,op2_reg,oprn_reg,r_net));

#5  op1_reg=15;
    op2_reg=5;
    oprn_reg=6'h06;
#5  test_and_count(total_test, pass_test, 
                   test_golden(op1_reg,op2_reg,oprn_reg,r_net));

#5  op1_reg=15;
    op2_reg=5;
    oprn_reg=6'h07;
#5  test_and_count(total_test, pass_test, 
                   test_golden(op1_reg,op2_reg,oprn_reg,r_net));

#5  op1_reg=15;
    op2_reg=5;
    oprn_reg=6'h08;
#5  test_and_count(total_test, pass_test, 
                   test_golden(op1_reg,op2_reg,oprn_reg,r_net));

#5  op1_reg=15;
    op2_reg=5;
    oprn_reg=6'h09;
#5  test_and_count(total_test, pass_test, 
                   test_golden(op1_reg,op2_reg,oprn_reg,r_net));

#5  op1_reg=5;
    op2_reg=15;
    oprn_reg=6'h09;
#5  test_and_count(total_test, pass_test, 
                   test_golden(op1_reg,op2_reg,oprn_reg,r_net));
// 
// TBD: Fill out for other operations
//
#5  $write("\n");
    $write("\tTotal number of tests %d\n", total_test);
    $write("\tTotal number of pass  %d\n", pass_test);
    $write("\n");
    $stop; // stop simulation here
end

//-----------------------------------------------------------------------------
// TASK: test_and_count
// 
// PARAMETERS: 
//     INOUT: total_test ; total test counter
//     INOUT: pass_test ; pass test counter
//     INPUT: test_status ; status of the current test 1 or 0
//
// NOTES: Keeps track of number of test and pass cases.
//
//-----------------------------------------------------------------------------
task test_and_count;
inout total_test;
inout pass_test;
input test_status;

integer total_test;
integer pass_test;
begin
    total_test = total_test + 1;
    if (test_status)
    begin
        pass_test = pass_test + 1;
    end
end
endtask

//-----------------------------------------------------------------------------
// FUNCTION: test_golden
// 
// PARAMETERS: op1, op2, oprn and result
// RETURN: 1 or 0 if the result matches golden 
//
// NOTES: Tests the result against the golden. Golden is generated inside.
//
//-----------------------------------------------------------------------------
function test_golden;
input [31:0] op1;
input [31:0] op2;
input [5:0] oprn;
input [31:0] res;

reg [31:0] golden; // expected result
begin
    $write("[TEST] %0d ", op1);
    case(oprn)
        6'h01 : begin $write("+ "); golden = op1 + op2; end
        6'h02 : begin $write("- "); golden = op1 - op2; end
	6'h03 : begin $write("* "); golden = op1 * op2; end
	6'h04 : begin $write(">> "); golden = op1 >> op2; end
	6'h05 : begin $write("<< "); golden = op1 << op2; end
	6'h06 : begin $write("& "); golden = op1 & op2; end
	6'h07 : begin $write("| "); golden = op1 | op2; end
	6'h08 : begin $write("~| "); golden = ~(op1 | op2); end
	6'h09 : begin $write("< "); golden = (op1<op2)?1:0; end
	
   
        default: begin $write("? "); golden = 32'hx; end
    endcase
    $write("%0d = %0d , got %0d ... ", op2, golden, res);

    test_golden = (res === golden)?1'b1:1'b0; // case equality
    if (test_golden)
	$write("[PASSED]");
    else 
        $write("[FAILED]");
    $write("\n");
end
endfunction

endmodule

