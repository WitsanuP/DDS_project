`timescale 1ps/1ps

module interpolator_tb();

    // ----------- registers -----------
    reg Fg_CLK_tb = 0;
    reg RESETn_tb = 0;
    reg IntBTN_i = 0;
    
    // ----------- wires -----------
        //simp Ctl
    wire Ready_o;
    wire Enable_o;
    wire [3:0] Mode_o;
        //osc
    wire [31:0] out1_o;
    wire [31:0] out2_o;
        //interpolator
    wire [11:0] interpOut_o;
    // ----------- device under test -----------
    sampling_control samp_module(
        .Fg_CLK(Fg_CLK_tb),
        .RESETn(RESETn_tb),
        .IntBTN(IntBTN_i),

        .Ready(Ready_o),
        .Enable(Enable_o),
        .Mode(Mode_o)
    );

    oscillator osc_module(
        .Fg_CLK(Fg_CLK_tb),
        .RESETn(RESETn_tb), 
        .Enable(Enable_o), 
        .Ready(Ready_o), 
        .init1(32'd96_878_045), 
        .init2(32'd1_054_193_702),
	.Mode(0),
	.freqchange(0),
        .out1(out1_o), 
        .out2(out2_o)
    );
    interpolator interp_module(
        .Fg_CLK(Fg_CLK_tb), 
        .RESETn(RESETn_tb), 
        .out1(out1_o), 
        .out2(out2_o), 
        .Mode(Mode_o), 
        .Enable(Enable_o), 

        .osc_out(interpOut_o)
    );

    // ----------- system signal generator-----------
    always #(41_666) Fg_CLK_tb = ~Fg_CLK_tb; //24M

    // ----------- test scenarios -----------
    initial begin
        repeat(10)@(posedge Fg_CLK_tb);
        RESETn_tb <= 1;
        repeat(10)@(posedge Fg_CLK_tb);
        $display("Starting test");

repeat(10000)@(posedge Fg_CLK_tb);

        repeat(1)@(posedge Fg_CLK_tb);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        IntBTN_i <= 0;
        repeat(1000)@(posedge Fg_CLK_tb);

repeat(10000)@(posedge Fg_CLK_tb);

        repeat(1)@(posedge Fg_CLK_tb);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        IntBTN_i <= 0;
        repeat(1000)@(posedge Fg_CLK_tb);

repeat(10000)@(posedge Fg_CLK_tb);

        repeat(1)@(posedge Fg_CLK_tb);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        IntBTN_i <= 0;
        repeat(10000)@(posedge Fg_CLK_tb);

repeat(10000)@(posedge Fg_CLK_tb);

        repeat(1)@(posedge Fg_CLK_tb);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        IntBTN_i <= 0;
        repeat(100000)@(posedge Fg_CLK_tb);
        
repeat(500000)@(posedge Fg_CLK_tb);

        repeat(1)@(posedge Fg_CLK_tb);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        IntBTN_i <= 0;
        repeat(1000)@(posedge Fg_CLK_tb);

        $stop;
    end

    // ----------- dumping wave -----------
    initial begin
        $dumpfile("interpolator_tb.vcd");
        $dumpvars(0,interpolator_tb);
    end
endmodule
