`timescale 1ps/1ps

module button_tb();

    // ----------- registers -----------
    reg Fg_CLK_i=1;
    reg task_CLK=1;
    reg RESETn_i=0;
    reg ExtBTN_i=1;

    // ----------- wires -----------
    wire IntBTN_o;

    //---------------task-------------
    task press();
        begin

            for (integer i=0; i<10; i++ ) begin
                ExtBTN_i<=~ExtBTN_i;
                @(posedge task_CLK);
                
            end

            for (integer i=0; i<20; i++ ) begin
                ExtBTN_i<=0;
                @(posedge task_CLK);
            end

            for (integer i=0; i<10; i++ ) begin
                ExtBTN_i<=~ExtBTN_i;
                @(posedge task_CLK);
                
            end

            ExtBTN_i <=1;


        end
    endtask

    // ----------- device under test -----------
    button button_module(
        .Fg_CLK(Fg_CLK_i),
        .RESETn(RESETn_i),
        .ExtBTN(ExtBTN_i),
        .IntBTN(IntBTN_o)
    );

    // ----------- system signal generator-----------
    always #(41_666/2) Fg_CLK_i = ~Fg_CLK_i; //24M
    always #(50_000/2) task_CLK = ~task_CLK; // clk for task press
    // ----------- test scenarios -----------
    initial begin
        repeat(10)@(posedge Fg_CLK_i);
        #10_000 RESETn_i = 1;
        $display("Starting test");
        repeat(100)@(posedge Fg_CLK_i);
        #10 press();
        repeat(400)@(posedge Fg_CLK_i);
        press();
        repeat(1000)@(posedge Fg_CLK_i);
        $stop;
    end

    // ----------- dumping wave -----------
    initial begin
        $dumpfile("button_tb.vcd");
        $dumpvars(0,button_tb);
        
    end
    
endmodule
