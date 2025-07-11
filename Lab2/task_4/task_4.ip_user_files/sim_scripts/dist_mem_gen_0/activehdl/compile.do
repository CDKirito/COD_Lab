transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vmap -link {C:/Users/86152/Desktop/CS/Lab/Lab2/task_4/task_4.cache/compile_simlib/activehdl}
vlib activehdl/dist_mem_gen_v8_0_13
vlib activehdl/xil_defaultlib

vlog -work dist_mem_gen_v8_0_13  -v2k5 -l dist_mem_gen_v8_0_13 -l xil_defaultlib \
"../../../ipstatic/simulation/dist_mem_gen_v8_0.v" \

vlog -work xil_defaultlib  -v2k5 -l dist_mem_gen_v8_0_13 -l xil_defaultlib \
"../../../../task_4.gen/sources_1/ip/dist_mem_gen_0/sim/dist_mem_gen_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

