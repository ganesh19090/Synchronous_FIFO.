vlog syn_fifo.v
#vsim tb +test_name=FULL
#vsim tb +test_name=OVERFLOW
#vsim tb +test_name=EMPTY
#vsim tb +test_name=UNDERFLOW
vsim tb +test_name=CONCURRENT
add wave -position insertpoint sim:/tb/*
add wave -radix unsigned sim:/tb/dut/wr_ptr
add wave -radix unsigned sim:/tb/dut/rd_ptr
add wave -position end sim:/tb/dut/wr_toggle_f
add wave -position end sim:/tb/dut/rd_toggle_f
run -all
