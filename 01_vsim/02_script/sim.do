vlog -file ./00_filelist/src.f \
    -file ./00_filelist/tb.f

vsim work.pll_module_tb -L gowin

add wave -position insertpoint  \
sim:/pll_module_tb/reset_i \
sim:/pll_module_tb/clkin_i \
sim:/pll_module_tb/clkout_o \
sim:/pll_module_tb/lock_o

restart -force

run -all

wave zoom full