`timescale 1ns/1ps

module latch_tb;

reg D, C;
reg nP, nR;
wire Q,Qbar;
// 1 bit register +ve edge, 
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
D_FF inst1(Q, Qbar, D, C, nP, nR);
initial
begin
#5 C=0; D=0; nP = 0; nR = 1; 
#5 C = 1; 

#5 C=0; D=0; nP = 1; nR = 0; 
#5 C = 1; 

//normal op
#5 C =0; D=0; nP = 1; nR = 1; 
#5 C = 1;
#5  C =0; D=1; nP = 1; nR = 1; 
#5 C = 1;

#5 $stop;
end
endmodule

