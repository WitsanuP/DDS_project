`timescale 1ps/1ps

module coef_prom_tb();

    // ----------- registers -----------
    reg Fg_CLK_tb=0;
    reg RESETn=0;
    reg Address_i=0;
    reg oce_i=1;
    // ----------- wires -----------
    wire [47:0] dout_o;
    // ----------- device under test -----------
    coef_prom rom_module(
        clk(Fg_CLK_tb), 
        oce(oce_i), 
        ce(1'd1), 
        reset(~RESETn), 
        ad(Address_i),

        dout(dout_o)
    );


    // ----------- system signal generator-----------
    always #(41_666/2) Fg_CLK_tb = ~Fg_CLK_tb;

    // ----------- test scenarios -----------
    initial begin
        repeat(10)@(posedge Fg_CLK_tb);
        RESETn <= 1;
        $display("Starting test");
        repeat(100)@(posedge Fg_CLK_tb);
        Address_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Address_i <= 2;
        repeat(100)@(posedge Fg_CLK_tb);
        Address_i <= 3;
        repeat(1000)@(posedge Fg_CLK_tb);
        
        
        $stop;
    end

    // ----------- dumping wave -----------
    initial begin
        $dumpfile("coef_prom_tb.vcd");
        $dumpvars(0,coef_prom_tb);
        
    end
    
endmodule
