module dds_top(
    input wire input_clk_27M,
    input wire input_RESET_gen,

    input wire input_BTN_mode,
    input wire input_Rot_A,
    input wire input_Rot_B,
    input wire input_BTN_step,

    output output_Dac_CLK,
    output output_interp_unsigned
);
    
    wire clk_48M;
    wire fg_clk;
    wire lock;
    wire pll_reset;
    wire reset_n;

    ResetGen_Module RESETGEN_module(
        .CLK(input_clk_27M),
        .ExtRESETn(input_RESET_gen),
        .PllLocked(lock),

        .PllRESETn(pll_reset),
        .FgRESETn(reset_n)
    );

    pll_module PLL_module(
        .clkout(clk_48M), //output clkout
        .lock(lock), //output lock
        
        .reset(~pll_reset), //input reset
        .clkin(input_clk_27M) //input clkin
    );

    clk_divider CLK_DIV_module(
        .PLL_CLK(clk_48M),
        .RESETn(~reset_n),

        .Fg_CLK(fg_clk),
        .Dac_CLK(output_Dac_CLK)
    );

    //////////////////////////
    //  second part module  //
    //////////////////////////
    wire wire_rot_c;
    wire [10:0] wire_address;
    wire wire_btn_simp;
    wire wire_ready;
    wire wire_enable;
    wire [3:0] wire_mode;
    wire wire_feqchange;
    wire [31:0] wire_cos2x;
    wire [31:0] wire_sin1x;
    wire [31:0] wire_out1;
    wire [31:0] wire_out2;

    button MODE_BTN_module(
        .Fg_CLK(fg_clk),
        .RESETn(reset_n),
        .ExtBTN(input_BTN_mode),

        .IntBTN(wire_btn_simp)
    );

    sampling_control SAMP_module(
        .Fg_CLK(fg_clk),
        .RESETn(reset_n),
        .IntBTN(wire_btn_simp),

        .Ready(wire_ready),
        .Enable(wire_enable),
        .Mode(wire_mode)
    );

    button STEP_BTN_module(
        .Fg_CLK(fg_clk),
        .RESETn(reset_n),
        .ExtBTN(input_BTN_step),

        .IntBTN(wire_rot_c)
    );

    rotary ROTARY_module (
        .Fg_CLK (fg_clk), 
        .RESETn (reset_n), 
        .Rot_B  (input_Rot_A), 
        .Rot_A  (input_Rot_B), 
        .Rot_C  (wire_rot_c), 
        
        .Address    (wire_address),
        .FreqChng   (wire_feqchange)
    );

    lookup_table lookup_module(
        .Fg_CLK(fg_clk), 
        .RESETn(reset_n), 
        .Address(wire_address), 
        .out1(), 
        .out2(), 

        .sin1x(wire_sin1x), 
        .cos2x(wire_cos2x)
    );

    oscillator OSC_module(
        .Fg_CLK(fg_clk),
        .RESETn(reset_n), 
        .Enable(wire_enable), 
        .Ready(wire_ready), 
        .init1(wire_sin1x), 
        .init2(wire_cos2x),
        .Mode(wire_mode),
        .freqchange(wire_feqchange),

        .out1(wire_out1), 
        .out2(wire_out2)
    );
    
    interpolator INTERPOLATOR_module(
        .Fg_CLK(fg_clk), 
        .RESETn(reset_n), 
        .out1(wire_out1), 
        .out2(wire_out2), 
        .Mode(wire_mode), 
        .Enable(wire_enable), 

        .osc_out(output_interp_unsigned)
    );
endmodule