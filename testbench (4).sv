//------------------------------------------------------------------------------
// File Name   : tb_dual_port_ram.sv
// Author      : Kartik Malipatil (1BM23EC117)
// Date        : 03-Feb-2026
// Course      : SystemVerilog and Verification (23EC6PE2SV)
// Faculty     : Prof. Ajaykumar Devarapalli
// Experiment  : Dual Port RAM – Testbench and Verification
//
// Description :
//   This testbench verifies the functionality of the
//   Dual Port RAM module. It applies randomized write
//   and read transactions to validate correct memory
//   behavior.
//------------------------------------------------------------------------------ 
module tb_dual_port_ram;

    logic        clk;
    logic        we;
    logic [7:0]  waddr, raddr;
    logic [31:0] wdata;
    logic [31:0] rdata;

    dual_port_ram dut (
        .clk(clk),
        .we(we),
        .waddr(waddr),
        .raddr(raddr),
        .wdata(wdata),
        .rdata(rdata)
    );

    // Reference model (NOT dumped)
    logic [31:0] ref_mem [int];

    // Clock
    always #5 clk = ~clk;

    // ✅ LIMITED VCD DUMP (prevents overload)
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1, dut);   // ONLY DUT, depth = 1
    end

    initial begin
        clk = 0;
        we  = 0;

        // WRITE
        repeat (5) begin
            @(posedge clk);
            we    = 1;
            waddr = $urandom_range(0,255);
            wdata = $urandom;
            ref_mem[waddr] = wdata;
            $display("WRITE Addr=%0d Data=%0h", waddr, wdata);
        end

        we = 0;

        // READ + CHECK
        repeat (5) begin
            @(posedge clk);
            raddr = $urandom_range(0,255);

            @(posedge clk);
            if (ref_mem.exists(raddr) && rdata == ref_mem[raddr])
                $display("PASS Addr=%0d Data=%0h", raddr, rdata);
            else
                $display("FAIL Addr=%0d Exp=%0h Got=%0h",
                          raddr, ref_mem[raddr], rdata);
        end

        $finish;
    end

endmodule
