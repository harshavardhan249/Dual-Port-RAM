//------------------------------------------------------------------------------
// File Name   : dual_port_ram.sv
// Author      : Harshavardhan K (1BM23EC098)
// Date        : 03-Feb-2026
// Course      : SystemVerilog and Verification (23EC6PE2SV)
// Faculty     : Prof. Ajaykumar Devarapalli
// Experiment  : Dual Port RAM Design and Verification
//
// Description :
//   This module implements a Dual Port RAM using
//   SystemVerilog. The design supports simultaneous
//   write and read operations through independent
//   ports controlled by a common clock.
//------------------------------------------------------------------------------ 
module dual_port_ram (
    input  logic        clk,
    input  logic        we,
    input  logic [7:0]  waddr,
    input  logic [7:0]  raddr,
    input  logic [31:0] wdata,
    output logic [31:0] rdata
);

    logic [31:0] mem [0:255];

    always_ff @(posedge clk) begin
        if (we)
            mem[waddr] <= wdata;
    end

    always_ff @(posedge clk) begin
        rdata <= mem[raddr];
    end

endmodule
