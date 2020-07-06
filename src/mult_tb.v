`timescale 1ns/1ps

module mult_tb;

wire [31:0] HI, LO, HI1, LO1;
reg [31:0] A, B, A1, B1;

//implicit wiring
MULT32_U mul_inst (HI, LO, A, B);
MULT32 mul_inst2 (HI1, LO1, A1, B1);

initial
begin
A=0; B=0; A1 = 0; B1=0;
#5 A=0; B=1; A1 = 0; B1=1;
#5 A=1; B=0; A1 = 1; B1=0;
#5 A=5; B=20;A1 = -5; B1=20;
#5 A=4; B=2; A1 = -5; B1 = -20;
#5 A=2147483647; B=203; A1 = -5; B1 = 20;
#5 A=4000000000; B=2; A1=-4000000000; B1=-2;
#5 A1=4000000000; B1=-2;
#5 A1=-4000000000; B1=2;
end
endmodule;