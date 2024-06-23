

`timescale 1ps/1ps

module fillter_mode4_tb();

    // ----------- registers -----------
    reg [10:0]Address_i_tb = 0; 
    reg [2:0]Mode_i_tb = 0;
    reg clk = 0;
    // ----------- wires -----------
    wire [10:0]Address_o_tb ;
    // ----------- device under test -----------
    fillter_mode4 fillter_mode4_module(
        .Address_i (Address_i_tb), 
        .Mode_i    (Mode_i_tb), 
        .Address_o (Address_o_tb)
    );

    // ----------- system signal generator-----------
    always #(1000) clk = ~clk;

    // ----------- test scenarios -----------
    initial begin
        $display("Starting test");
        repeat(4)@(posedge clk) begin
            repeat(100)@(posedge clk) Address_i_tb <= Address_i_tb + 1; 
            repeat(200)@(posedge clk);//delay
            Mode_i_tb <= Mode_i_tb + 1;
        end
        $stop;
    end
        
        
  

    // ----------- dumping wave -----------
    initial begin
        $dumpfile("fillter_mode4_tb.vcd");
        $dumpvars(0,fillter_mode4_tb);
        
    end
    
endmodule
