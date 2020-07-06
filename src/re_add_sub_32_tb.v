`timescale 1ns/1ps

module re_add_sub_32_tb;
reg[31:0] A,B;
reg SnA;
wire [31:0] Y;
wire CO;

reg[63:0] A1,B1;
reg SnA1;
wire [63:0] Y1;
wire CO1;

//implicit wiring
RC_ADD_SUB_32 rc_inst1 (Y, CO, A, B, SnA);
RC_ADD_SUB_64 rc_inst2 (Y1, CO1, A1, B1, SnA1);
initial
begin
A=0; B=0; SnA =0; A1=0; B1=0; SnA1 =0;
#10 A=0; B=0; SnA = 1; A1=0; B1=100; SnA1 =1;
#10 A=0; B=1; SnA = 0; A1 = 64'd2199023255552; B1=2393; SnA1 =1;
#10 A=0; B=1; SnA = 1; A1 = 64'd2199023255552; B1=2393; SnA1 =0;
#10 A=5; B=20; SnA= 0; 
#10 A=5; B=20; SnA = 1;
#10 A=4; B=2; SnA = 0;
#10 A=4; B=2000; SnA = 1;

end
endmodule
