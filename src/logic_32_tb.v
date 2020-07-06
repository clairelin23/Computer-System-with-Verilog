`timescale 1ns/1ps

module logic_32_tb;

wire [31:0] Y;
//input
reg [31:0] A;

INV32_1x1 inv_inst(Y,A);

initial
begin
A=0; 
#5 A=1; 
#5 A = 2147483647;
#5 A=259493;
end

endmodule
