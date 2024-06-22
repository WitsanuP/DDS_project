module dds_top();
    ResetGen_Module resetgen_module(
    input   wire    CLK,

    input   wire    ExtRESETn,
    
    input   wire    PllLocked,
    output  wire    PllRESETn,

    output  wire    FgRESETn
);
    pll_module pll_module(
    	.clkin(Ext_clk_27) //input clkin
        .reset(reset_i), //input reset

        .clkout(clkout_o), //output clkout
        .lock(lock_o), //output lock
    );

    clk_divider clk_div_module(
        .PLL_CLK(PLL_CLK_tb),
        .RESETn(RESETn_tb),

        .Fg_CLK(Fg_CLK_tb),
        .Dac_CLK(Dac_CLK_tb)
    );

    button button_module(
        .Fg_CLK(Fg_CLK_i),
        .RESETn(RESETn_i),
        .ExtBTN(ExtBTN_i),

        .IntBTN(IntBTN_o)
    );

    sampling_control samp_module(
        .Fg_CLK(Fg_CLK_i),
        .RESETn(RESETn_i),
        .IntBTN(IntBTN_i),

        .Ready(Ready_o),
        .Enable(Enable_o),
        .Mode(Mode_o)
    );

    button button_rot_C_module(
        .Fg_CLK(Fg_CLK_i),
        .RESETn(RESETn_i),

        .ExtBTN(ExtBTN_i),
        .IntBTN(IntBTN_o)
    );

    rotary rotary_module (
        .Fg_CLK (Fg_CLK_tb), 
        .RESETn (RESETn_tb), 
        .Rot_A  (Rot_A_i), 
        .Rot_B  (Rot_B_i), 
        .Rot_C  (Rot_C_i), 
        
        .Address    (Adddress_o), 
        .FreqChng   (FreqChng_o)
    );



        oscillator osc_module(
        .Fg_CLK(Fg_CLK_tb),
        .RESETn(RESETn_tb), 
        .Enable(Enable_o), 
        .Ready(Ready_o), 
        .init1(32'd96_878_045), 
        .init2(32'd1_054_193_702),

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

        .interpOut(interpOut_o)
    );


endmodule