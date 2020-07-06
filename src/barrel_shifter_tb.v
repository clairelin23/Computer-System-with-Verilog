`timescale 1ns/1ps
/*
module barrel_shifter_tb;
// output list
wire [31:0] Y, Y1, Y2;
// input list
reg [31:0] D, D1, D2;
reg [4:0] S, S1, S2 ;
reg LnR;
// left shifter
SHIFT32_L s_inst1 (Y,D,S);
//right shifter
SHIFT32_R s_inst2 (Y1,D1,S1);

BARREL_SHIFTER32 inst3 (Y2,D2,S2, LnR);

initial
begin
D=0; S=0; D1=0; S1=0; D2 = 0; S2 = 0; LnR =0;
#5 D=1; S=0;  D1=1; S1=0; D2 = 1; S2 = 0; LnR =0;
#5 D=1; S=1;  D1=1; S1=1; D2 = 1; S2 = 1; LnR =1;
#5 D=1; S=2;  D1=1; S1=2; D2 = 1; S2 = 2; LnR =0;
#5 D=1; S=4;  D1=4; S1=1; D2 = 1; S2 = 4; LnR =1;
#5 D=1; S=5;  D1=5; S1=1; D2 = 1; S2 = 5; LnR =0;
#5 D=1; S=6;  D1=5; S1=3; D2 = 5; S2 = 3; LnR =1;
#5 D=1; S=7;  D1=7; S1=1; D2 = 5; S2 = 3; LnR =0;
#5 D=1; S=8;  D1=8; S1=2; D2 = 15; S2 = 5;LnR =1;
#5 D=1; S=15;  D1=15; S1=5; D2 = 100; S2 = 5;LnR =0;
#5 D=100; S=8;  D1=100; S1=5; D2 = 100; S2 = 5;LnR =1;
#5;


end
endmodule */

module barrel_32_b_shifter_tb;
// output list
wire [31:0] Y2;
// input list
reg [31:0] D2, S2;
reg LnR;

SHIFT32 inst1 (Y2,D2,S2, LnR);

initial
begin
D2 = 1; S2 = 0; LnR =0;
#5  D2 = 1; S2 = 1; LnR =1;
#5  D2 = 1; S2 = 32; LnR =1;
#5  D2 = 1; S2 = 4; LnR =1;
#5  D2 = 10; S2 = 32; LnR =0;
#5  D2 = 10; S2 = 3; LnR =0;
#5  D2 = 15; S2 = 5;LnR =1;
#5  D2 = 100; S2 = 5;LnR =0;
#5  D2 = 100; S2 = 10;LnR =1; 
#5  D2 = 100; S2 = 33;LnR =1; 
#5 ;
end
endmodule