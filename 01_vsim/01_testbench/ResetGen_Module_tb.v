
`timescale 1ps/1ps

module ResetGen_Module_tb();

    // ----------- registers -----------
    reg i_reset_n =0;
    reg clk_tb =0;
    reg i_pll = 0;
    // ----------- wires -----------
    wire o_pllreset;
    wire o_fg_resetn;
    // ----------- device under test -----------

ResetGen_Module dut_resetgen(
    .CLK(clk_tb),
    .ExtRESETn(i_reset_n),
    .PllLocked(i_pll),

    .PllRESETn(o_pllreset),
    .FgRESETn(o_fg_resetn)
);
    // ----------- system signal generator-----------
    always #(37037/2) clk_tb = ~clk_tb; //27M

    // ----------- test scenarios -----------
    initial begin
        $display("Starting test");
        repeat(10)@(posedge clk_tb);
        i_reset_n <= 1;
        repeat(10)@(posedge clk_tb);
        i_pll <= 1;
        repeat(1000)@(posedge clk_tb)
        $stop;
    end

    // ----------- dumping wave -----------
    initial begin
        $dumpfile("ResetGen_Module_tb.vcd");
        $dumpvars(0,ResetGen_Module_tb);
        
    end
    
endmodule
