// Name: register_file.v
// Module: REGISTER_FILE_32x32
// Input:  DATA_W : Data to be written at address ADDR_W
//         ADDR_W : Address of the memory location to be written
//         ADDR_R1 : Address of the memory location to be read for DATA_R1
//         ADDR_R2 : Address of the memory location to be read for DATA_R2
//         READ    : Read signal
//         WRITE   : Write signal
//         CLK     : Clock signal
//         RST     : Reset signal
// Output: DATA_R1 : Data at ADDR_R1 address
//         DATA_R2 : Data at ADDR_R1 address
//
// Notes: - 32 bit word accessible dual read register file having 32 regsisters.
//        - Reset is done at -ve edge of the RST signal
//        - Rest of the operation is done at the +ve edge of the CLK signal
//        - Read operation is done if READ=1 and WRITE=0
//        - Write operation is done if WRITE=1 and READ=0
//        - X is the value at DATA_R* if both READ and WRITE are 0 or 1
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
//
`include "prj_definition.v"

// This is going to be +ve edge clock triggered register file.
// Reset on RST=0
module REGISTER_FILE_32x32(DATA_R1, DATA_R2, ADDR_R1, ADDR_R2, 
                            DATA_W, ADDR_W, READ, WRITE, CLK, RST);

// input list
input READ, WRITE, CLK, RST;
input [`DATA_INDEX_LIMIT:0] DATA_W;
input [`REG_ADDR_INDEX_LIMIT:0] ADDR_R1, ADDR_R2, ADDR_W;

// output list
output [`DATA_INDEX_LIMIT:0] DATA_R1;
output [`DATA_INDEX_LIMIT:0] DATA_R2;

wire [31:0] decode_out;
wire [31:0] and_out, read_out1, read_out2;
wire [31:0] qout [0:31];
DECODER_5x32 decode_inst1 (decode_out, ADDR_W);
genvar i;
generate
    for(i =0; i<33; i = i+1)
    begin : reg32_gen_loop
	and and_inst (and_out[i], decode_out[i], WRITE);
    end 
endgenerate

genvar j;
generate
    for(j =0; j<32; j = j+1)
    begin : re32_gen_loop
        REG32 reg_inst (qout[j], DATA_W, and_out[j] , CLK, RST);
    end
endgenerate
MUX32_32x1 mux32_inst1 (read_out1, qout[0], qout[1], qout[2], qout[3], qout[4], qout[5], qout[6], qout[7],
                     qout[8], qout[9], qout[10], qout[11], qout[12], qout[13],  qout[14], qout[15],
                     qout[16], qout[17], qout[18], qout[19], qout[20], qout[21], qout[22], qout[23],
                      qout[24], qout[25], qout[26], qout[27], qout[28], qout[29], qout[30], qout[31], ADDR_R1);

MUX32_32x1 mux32_inst2 (read_out2, qout[0], qout[1], qout[2], qout[3], qout[4], qout[5], qout[6], qout[7],
                     qout[8], qout[9], qout[10], qout[11], qout[12], qout[13],  qout[14], qout[15],
                     qout[16], qout[17], qout[18], qout[19], qout[20], qout[21], qout[22], qout[23],
                      qout[24], qout[25], qout[26], qout[27], qout[28], qout[29], qout[30], qout[31], ADDR_R2);
MUX32_2x1 mux_inst1 (DATA_R1, {32'bZ}, read_out1, READ);
MUX32_2x1 mux_inst2 (DATA_R2, {32'bZ}, read_out2, READ);
endmodule
