//Copyright (C)2014-2024 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//GOWIN Version: 1.9.9 Beta-4 Education
//Created Time: 2024-07-08 18:04:39
create_clock -name CLK_27M -period 37.037 -waveform {0 18.518} [get_ports {input_clk_27M}]
create_clock -name CLK_PLL -period 20.833 -waveform {0 10.416} [get_pins {PLL_module/rpll_inst/CLKOUT}]
create_generated_clock -name CLK_24M -source [get_pins {PLL_module/rpll_inst/CLKOUT}] -master_clock CLK_PLL -divide_by 2 [get_pins {CLK_DIV_module/Fg_CLK_s0/Q}]
set_false_path -from [get_clocks {CLK_27M}] -to [get_clocks {CLK_24M}] 
set_false_path -from [get_clocks {CLK_27M}] -to [get_clocks {CLK_PLL}] 
set_false_path -from [get_clocks {CLK_24M}] -to [get_clocks {CLK_27M}] 
set_false_path -from [get_clocks {CLK_PLL}] -to [get_clocks {CLK_27M}] 
