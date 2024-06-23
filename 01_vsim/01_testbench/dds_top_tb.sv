`timescale 1ps/1ps

module dds_top_tb();

    // ----------- registers -----------
    reg clk_tb = 0;
    reg reset_gen_tb = 0;
    reg [3:0]mode_tb = 0;
    reg rota_tb = 1;
    reg rotb_tb = 1;
    reg step_tb = 0;
    
    // ----------- wires -----------
    wire dac_clk_tb;
    wire [11:0]output_tb;
    // ----------- device under test -----------
    dds_top dut(
        .input_clk_27M(clk_tb),
        .input_RESET_gen(reset_gen_tb),

        .input_BTN_mode(mode_tb),
        .input_Rot_A(rota_tb),
        .input_Rot_B(rotb_tb),
        .input_BTN_step(step_tb),

        .output_Dac_CLK(dac_clk_tb),
        .output_interp_unsigned(output_tb)
    );

    // ----------- system signal generator-----------
    always #(37037/2) clk_tb = ~clk_tb; //27M

    // ----------- test scenarios -----------
    initial begin
        $display("Starting test");

        repeat(100)@(posedge clk_tb);
        reset_gen_tb <=1; 
        repeat(100)@(posedge clk_tb);
        reset_gen_tb <= 0;
        repeat(100)@(posedge clk_tb);
        mode_tb <= 2;
        
        repeat(10)@(posedge clk_tb);
        step_tb <= step_tb+ 2;

        repeat(100)@(posedge clk_tb);
        repeat(1000)@(posedge clk_tb);
        $stop;
    end

    // ----------- dumping wave -----------
    initial begin
        $dumpfile("dds_top_tb.vcd");
        $dumpvars(0,dds_top_tb);
        
    end
    
endmodule
