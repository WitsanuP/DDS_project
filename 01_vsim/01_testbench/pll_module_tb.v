`timescale 1ps/1ps

module pll_module_tb();

    // ----------- registers -----------
    reg reset_i =0;
    reg clkin_i =0; 

    // ----------- wires -----------
    wire clkout_o;
    wire lock_o;


    // ----------- device under test -----------
   pll_module your_instance_name(
        .clkout(clkout_o), //output clkout
        .lock(lock_o), //output lock
        .reset(reset_i), //input reset
        .clkin(clkin_i) //input clkin
    );

    // ----------- system signal generator-----------
    always #(37037/2) clkin_i = ~clkin_i;

    // ----------- test scenarios -----------
    initial begin
        $display("Starting test");
        repeat(10_000)@(posedge clkin_i);
        #10 reset_i = 1;
        #10 reset_i = 0;
        repeat(10_000)@(posedge clkin_i);
        $stop;
    end

    // ----------- dumping wave -----------
    initial begin
        $dumpfile("pll_module_tb.vcd");
        $dumpvars(0,pll_module_tb);
    end
    
endmodule