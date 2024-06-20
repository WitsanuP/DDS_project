`timescale 1ps/1ps

module clk_divider_tb();

    // ----------- registers -----------
    reg PLL_CLK_tb = 0;
    reg RESETn_tb = 0; 
    
    // ----------- wires -----------
    wire Fg_CLK_tb;
    wire Dac_CLK_tb;

    // ----------- device under test -----------
    clk_divider test_module(
        .PLL_CLK(PLL_CLK_tb),
        .RESETn(RESETn_tb),
        .Fg_CLK(Fg_CLK_tb),
        .Dac_CLK(Dac_CLK_tb)
    );

    // ----------- system signal generator-----------
    always #(20833/2) PLL_CLK_tb = ~PLL_CLK_tb; //48M

    // ----------- test scenarios -----------
    initial begin
        $display("Starting test");
        repeat(10)@(posedge PLL_CLK_tb or negedge PLL_CLK_tb);
        #10 RESETn_tb = 1;
        repeat(10_000)@(posedge PLL_CLK_tb or negedge PLL_CLK_tb);
        RESETn_tb = 0;
        #100_000 RESETn_tb = 1;
        repeat(10_000)@(posedge PLL_CLK_tb or negedge PLL_CLK_tb);
        $stop;
    end

    // ----------- dumping wave -----------
    initial begin
        $dumpfile("clk_divider_tb.vcd");
        $dumpvars(0,clk_divider_tb);
    end
    
endmodule