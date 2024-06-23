`timescale 1ps/1ps

module coef_prom_tb();

    // ----------- registers -----------
    reg RESETn_tb = 0;
    reg Fg_CLK_tb = 0;
    reg [10:0]Address_i = 11'd0;
    reg oce_i = 1;
    // ----------- wires -----------
    wire [47:0] dout_o;
    // ----------- device under test -----------
    coef_prom rom_module(
        .dout(dout_o),

        .clk(Fg_CLK_tb), 
        .oce(oce_i), 
        .ce(1'd1), 
        .reset(~RESETn_tb), 
        .ad(Address_i)

    );


    // ----------- system signal generator-----------
    always #(41_666/2) Fg_CLK_tb = ~Fg_CLK_tb;

    // ----------- test scenarios -----------
    initial begin
        repeat(100)@(posedge Fg_CLK_tb);
        RESETn_tb <= 1;
        $display("Starting test");
        repeat(100)@(posedge Fg_CLK_tb);
        Address_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Address_i <= 2;
        repeat(100)@(posedge Fg_CLK_tb);
        Address_i <= 3;
        repeat(500)@(posedge Fg_CLK_tb);
        
        oce_i <= 0;
        repeat(100)@(posedge Fg_CLK_tb);
        Address_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Address_i <= 2;
        repeat(100)@(posedge Fg_CLK_tb);
        Address_i <= 3;
        repeat(500)@(posedge Fg_CLK_tb);
        $stop;
    end

    // ----------- dumping wave -----------
    initial begin
        $dumpfile("coef_prom_tb.vcd");
        $dumpvars(0,coef_prom_tb);
        
    end
    
endmodule
