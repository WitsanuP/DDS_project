`timescale 1ps/1ps

module lookup_table_tb();

    // ----------- registers -----------
    reg Fg_CLK_tb=0;
    reg RESETn=0;
    reg [10:0] Address_i=0;
    // ----------- wires -----------
    wire [31:0] sin1x_o;
    wire [31:0] cos2x_o;
    // ----------- device under test -----------
    lookup_table lookup_module(
        .Fg_CLK(Fg_CLK_tb), 
        .RESETn(RESETn_tb), 
        .Adddress(Address_i), 
        .out1(), 
        .out2(), 

        .sin1x(sin1x_o), 
        .cos2x(cos2x_o)
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
        $dumpfile("lookup_table_tb.vcd");
        $dumpvars(0,lookup_table_tb);
        
    end
    
endmodule
