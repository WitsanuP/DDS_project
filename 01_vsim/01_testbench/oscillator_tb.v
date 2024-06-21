`timescale 1ps/1ps

module oscillator_tb();

    // ----------- registers -----------
    reg Fg_CLK_i = 0;
    reg RESETn_i = 0;
    reg IntBTN_i = 0;
    
    // ----------- wires -----------
        //simp Ctl
    wire Ready_o;
    wire Enable_o;
    wire [3:0] Mode_o;
        //osc
    wire [31:0] out1_o;
    wire [31:0] out2_o;
    // ----------- device under test -----------
    sampling_control samp_module(
        .Fg_CLK(Fg_CLK_i),
        .RESETn(RESETn_i),
        .IntBTN(IntBTN_i),

        .Ready(Ready_o),
        .Enable(Enable_o),
        .Mode(Mode_o)
    );

    oscillator osc_module(
        .Fg_CLK(Fg_CLK_i),
        .RESETn(RESETn_i), 
        .Enable(Enable_o), 
        .Ready(Ready_o), 
        .init1(32'd96_878_045), 
        .init2(32'd1_054_193_702),

        .out1(out1_o), 
        .out2(out2_o)
    );

    // ----------- system signal generator-----------
    always #(41_666) Fg_CLK_i = ~Fg_CLK_i; //24M

    // ----------- test scenarios -----------
    initial begin
        repeat(10)@(posedge Fg_CLK_i);
        RESETn_i <= 1;
        repeat(10)@(posedge Fg_CLK_i);
        $display("Starting test");

repeat(10000)@(posedge Fg_CLK_i);

        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 0;
        repeat(1000)@(posedge Fg_CLK_i);

repeat(10000)@(posedge Fg_CLK_i);

        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 0;
        repeat(1000)@(posedge Fg_CLK_i);

repeat(10000)@(posedge Fg_CLK_i);

        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 0;
        repeat(10000)@(posedge Fg_CLK_i);

repeat(10000)@(posedge Fg_CLK_i);

        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 0;
        repeat(100000)@(posedge Fg_CLK_i);
        
repeat(500000)@(posedge Fg_CLK_i);

        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 0;
        repeat(1000)@(posedge Fg_CLK_i);

        $stop;
    end

    // ----------- dumping wave -----------
    initial begin
        $dumpfile("oscillator_tb.vcd");
        $dumpvars(0,oscillator_tb);
    end
endmodule
