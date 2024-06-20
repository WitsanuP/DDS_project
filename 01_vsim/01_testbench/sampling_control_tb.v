`timescale 1ps/1ps

module sampling_control_tb();

    // ----------- registers -----------
    reg Fg_CLK_i = 0;
    reg RESETn_i = 1;
    reg IntBTN = 0;

    // ----------- wires -----------
    wire Ready_o;
    wire Enable;
    wire Mode;
    
    // ----------- device under test -----------
    sampling_control samp_module(
        .Fg_CLK(),
        .RESETn(),
        .IntBTN(),
        .Ready(),
        .Enable(),
        .Mode()
        );

    // ----------- system signal generator-----------
    always #(1) clk = ~clk;

    // ----------- test scenarios -----------
    initial begin
        $display("Starting test");
        
        
        $stop;
    end

    // ----------- dumping wave -----------
    initial begin
        $dumpfile("sampling_control_tb.vcd");
        $dumpvars(0,sampling_control_tb);
        
    end
    
endmodule
