module dds_top();
    pll_module your_instance_name(
    	.clkin(Ext_clk_27) //input clkin
        .reset(reset_i), //input reset
        .clkout(clkout_o), //output clkout
        .lock(lock_o), //output lock
    );

    clk_divider your_instance_name(
        .
    );

endmodule