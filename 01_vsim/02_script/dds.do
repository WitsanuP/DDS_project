vlog -file ./00_filelist/src_dds.f \
    -file ./00_filelist/tb_dds.f \
    +define+TEST_MODE 

vsim -L gowin work.dds_top_tb

add wave -position insertpoint  \
sim:/dds_top_tb/clk_tb \
sim:/dds_top_tb/reset_gen_tb \
sim:/dds_top_tb/mode_tb \
sim:/dds_top_tb/rota_tb \
sim:/dds_top_tb/rotb_tb \
sim:/dds_top_tb/step_tb \
sim:/dds_top_tb/dac_clk_tb \
sim:/dds_top_tb/output_tb

add wave -position insertpoint  \
sim:/dds_top_tb/dut/clk_48M \
sim:/dds_top_tb/dut/fg_clk \
sim:/dds_top_tb/dut/lock \
sim:/dds_top_tb/dut/pll_reset\
sim:/dds_top_tb/dut/output_Dac_CLK\

add wave -position insertpoint sim:/dds_top_tb/dut/ROTARY_module/count
add wave -position insertpoint sim:/dds_top_tb/dut/OSC_module/Mode

restart -force

run -all

wave zoom full