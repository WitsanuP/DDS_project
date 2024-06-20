vlog -file ./00_filelist/src.f \
    -file ./00_filelist/tb.f

vsim -L gowin work.clk_divider_tb

add wave -position insertpoint  \
sim:/clk_divider_tb/PLL_CLK_tb \
sim:/clk_divider_tb/RESETn_tb \
sim:/clk_divider_tb/Fg_CLK_tb \
sim:/clk_divider_tb/Dac_CLK_tb

restart -force

run -all

wave zoom full