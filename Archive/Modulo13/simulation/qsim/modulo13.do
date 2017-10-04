onerror {quit -f}
vlib work
vlog -work work modulo13.vo
vlog -work work modulo13.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.g27_shift_left_3_vlg_vec_tst
vcd file -direction modulo13.msim.vcd
vcd add -internal g27_shift_left_3_vlg_vec_tst/*
vcd add -internal g27_shift_left_3_vlg_vec_tst/i1/*
add wave /*
run -all
