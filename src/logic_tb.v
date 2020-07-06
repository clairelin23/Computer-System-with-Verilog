`timescale 1ns/1ps

module logic_tb;
/*
//output list
wire [63:0] Y;
//input list
reg [63:0] A;
TWOSCOMP64 inst1 (Y,A);

wire [31:0] Y2;
reg [31:0] A2;
TWOSCOMP32 inst2(Y2,A2);

initial
begin
A=0; A2=0; 
#5 A=1; A2=1; 
#5 A=64'd2199023255552; A2=2393;
#5 A=259493; A2=259493;
#5;
end
*/
reg I0, I1, I2;
wire Y;
nand_3bit inst1 (Y,I0, I1, I2);
initial
begin
I0=0; I1=0; I2 = 0;
#5 I0=0; I1=1; I2 = 0;
#5 I0=1; I1=0; I2 = 0;
#5 I0=0; I1=0; I2 = 1;
#5 I0=1; I1=1; I2 = 0;
#5 I0=0; I1=1; I2 = 1;
#5 I0=1; I1=1; I2 = 1;
#5;
end
endmodule