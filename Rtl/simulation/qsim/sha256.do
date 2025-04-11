onerror {quit -f}
vlib work
vlog -work work sha256.vo
vlog -work work sha256.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.sum_1_vlg_vec_tst
vcd file -direction sha256.msim.vcd
vcd add -internal sum_1_vlg_vec_tst/*
vcd add -internal sum_1_vlg_vec_tst/i1/*
add wave /*
run -all
