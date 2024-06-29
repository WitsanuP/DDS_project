`timescale 1ns/1ns

module dds_top_tb();

    // ----------- registers -----------
    reg clk_tb = 0;
    reg reset_gen_tb = 1;
    reg mode_tb = 1;
    reg rota_tb = 1;
    reg rotb_tb = 1;
    reg step_tb = 1;
    
    // ----------- wires -----------
    wire dac_clk_tb;
    wire [11:0]output_tb;
    // ----------- task 
    task reset_BTN();
        begin
            repeat(1)@(posedge clk_tb);
            reset_gen_tb <= 0;
            repeat(5)@(posedge clk_tb);
            reset_gen_tb <= 1;
            repeat(1)@(posedge clk_tb);
        end
    endtask

    task mode_BTN();
        begin
            repeat(1)@(posedge clk_tb);
            mode_tb <= 0;
            repeat(5)@(posedge clk_tb);
            mode_tb <= 1;
            repeat(1)@(posedge clk_tb);
        end
    endtask 

    task step_BTN();
        begin
            repeat(1)@(posedge clk_tb);
            step_tb <= 0;
            repeat(5)@(posedge clk_tb);
            step_tb <= 1;
            repeat(1)@(posedge clk_tb);
        end
    endtask 

    task cw_task();
        begin 
            repeat(1)@(posedge clk_tb);
            rota_tb <= 0;
            repeat(2)@(posedge clk_tb);
            rotb_tb <= 0;
            repeat(2)@(posedge clk_tb);
            rota_tb <= 1;
            repeat(2)@(posedge clk_tb);
            rotb_tb <= 1;
            repeat(1)@(posedge clk_tb);
        end
    endtask

    task ccw_task();
        begin 
            repeat(1)@(posedge clk_tb);
            rotb_tb <= 0;
            repeat(2)@(posedge clk_tb);
            rota_tb <= 0;
            repeat(2)@(posedge clk_tb);
            rotb_tb <= 1;
            repeat(2)@(posedge clk_tb);
            rota_tb <= 1;
            repeat(1)@(posedge clk_tb);
        end
    endtask
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
        
        repeat(100)@(posedge clk_tb);
        reset_BTN();
        repeat(2000)@(posedge clk_tb);//
        $display("Starting test");
        
        // ----------- test each mode -------
        // mode_BTN();
        // repeat(5000)@(posedge clk_tb);
        // mode_BTN();
        // repeat(50000)@(posedge clk_tb);
        // mode_BTN();
        // repeat(250000)@(posedge clk_tb);
        // mode_BTN();
        // repeat(5000000)@(posedge clk_tb);
        // mode_BTN();
        // repeat(1000)@(posedge clk_tb);
        
        // ---------- test loop mode --------
        repeat(10)begin
            mode_BTN();
            repeat(5000)@(posedge clk_tb);
        end

        // test step BTN

        // test rotery
        
        // test reset

        // test 
        // repeat(500)begin
        //     cw_task();
        //     repeat(100)@(posedge clk_tb);
        // end
        
        
        repeat(5000)@(posedge clk_tb);
        $stop;
    end

    // ----------- dumping wave -----------
    initial begin
        $dumpfile("dds_top_tb.vcd");
        $dumpvars(0,dds_top_tb);
        
    end
    
endmodule
