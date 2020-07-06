`timescale 1ns/1ps

module decoder_tb;
/*
// output
wire [3:0] D;
// input
reg [1:0] I;
// 2x4 Line decoder
DECODER_2x4 inst1 (D,I);

initial
begin
I=0;
#5 I = 1;
#5 I = 2;
#5 I = 3;
#5 ;
end
endmodule


// output
wire [7:0] D;
// input
reg [2:0] I;
// 3x8 Line decoder
 DECODER_3x8 inst1(D,I);

initial
begin
I=0;
#5 I = 1;
#5 I = 2;
#5 I = 3;
#5 I = 4;
#5 I = 5;
#5 I = 6;
#5 I = 7;
#5 ;
end
endmodule 


// output
wire [15:0] D;
// input
reg [3:0] I;
DECODER_4x16 inst1 (D,I);
initial
begin
I=0;
#5 I = 1;
#5 I = 2;
#5 I = 3;
#5 I = 4;
#5 I = 5;
#5 I = 6;
#5 I = 7;
#5 I = 8;
#5 I = 9;
#5 I = 10;
#5 I = 11;
#5 I = 12;
#5 I = 13;
#5 I = 14;
#5 I = 15;
#5 ;
end
endmodule
*/
// output
wire [31:0] D;
// input
reg [4:0] I;
// 5x32 Line decoder
DECODER_5x32 inst1(D,I);

initial
begin
I=0;
#5 I = 1;
#5 I = 2;
#5 I = 3;
#5 I = 4;
#5 I = 5;
#5 I = 6;
#5 I = 7;
#5 I = 8;
#5 I = 9;
#5 I = 10;
#5 I = 11;
#5 I = 12;
#5 I = 13;
#5 I = 14;
#5 I = 15;
#5 I = 16;
#5 I = 17;
#5 I = 18;
#5 I = 19;
#5 I = 20;
#5 I = 21;
#5 I = 22;
#5 I = 23;
#5 I = 24;
#5 I = 25;
#5 I = 26;
#5 I = 27;
#5 I = 28;
#5 I = 29;
#5 I = 30;
#5 I = 31;
#5 ;
end
endmodule
