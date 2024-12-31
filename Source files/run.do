vlog -lint -source design.sv testbench.sv

vsim work.fir_filter_tb
vsim -voptargs=+acc work.fir_filter_tb

add wave sim:/fir_filter_tb/*
run -all
