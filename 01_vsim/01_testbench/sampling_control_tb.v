`timescale 1ps/1ps

module sampling_control_tb();

    // ----------- registers -----------
    reg Fg_CLK_i = 0;
    reg RESETn_i = 0;
    reg IntBTN_i = 0;
    
    // ----------- wires -----------
    wire Ready_o;
    wire Enable_o;
    wire [3:0] Mode_o;
    
    // ----------- device under test -----------
    sampling_control samp_module(
        .Fg_CLK(Fg_CLK_i),
        .RESETn(RESETn_i),
        .IntBTN(IntBTN_i),
        .Ready(Ready_o),
        .Enable(Enable_o),
        .Mode(Mode_o)
    );

    // ----------- system signal generator-----------
    always #(41_666) Fg_CLK_i = ~Fg_CLK_i; //24M

    // ----------- test scenarios -----------
    initial begin
        repeat(10)@(posedge Fg_CLK_i);
        RESETn_i <= 1;
        repeat(10)@(posedge Fg_CLK_i);
        $display("Starting test");
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 0;
        repeat(1000)@(posedge Fg_CLK_i);

        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 0;
        repeat(1000)@(posedge Fg_CLK_i);

        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 0;
        repeat(10000)@(posedge Fg_CLK_i);

        //test loop mode
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 0;
        repeat(100)@(posedge Fg_CLK_i);

        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 0;
        repeat(100)@(posedge Fg_CLK_i);
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 0;
        repeat(100)@(posedge Fg_CLK_i);
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 0;
        repeat(100)@(posedge Fg_CLK_i);
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 0;
        repeat(100)@(posedge Fg_CLK_i);
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 0;
        repeat(100)@(posedge Fg_CLK_i);
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 0;
        repeat(100)@(posedge Fg_CLK_i);
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 0;
        repeat(100)@(posedge Fg_CLK_i);
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 0;
        repeat(100)@(posedge Fg_CLK_i);
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 0;
        repeat(100)@(posedge Fg_CLK_i);
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 1;
        repeat(1)@(posedge Fg_CLK_i);
        IntBTN_i <= 0;
        repeat(100)@(posedge Fg_CLK_i);
        repeat(1000)@(posedge Fg_CLK_i);
        $stop;
    end

    // ----------- dumping wave -----------
    initial begin
        $dumpfile("sampling_control_tb.vcd");
        $dumpvars(0,sampling_control_tb);
    end
endmodule
