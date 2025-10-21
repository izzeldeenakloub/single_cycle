transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/User/Desktop/single_cycle {C:/Users/User/Desktop/single_cycle/program_counter.v}
vlog -vlog01compat -work work +incdir+C:/Users/User/Desktop/single_cycle {C:/Users/User/Desktop/single_cycle/instruction_memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/User/Desktop/single_cycle {C:/Users/User/Desktop/single_cycle/Register_file.v}
vlog -vlog01compat -work work +incdir+C:/Users/User/Desktop/single_cycle {C:/Users/User/Desktop/single_cycle/top_level.v}
vlog -vlog01compat -work work +incdir+C:/Users/User/Desktop/single_cycle {C:/Users/User/Desktop/single_cycle/Control_Unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/User/Desktop/single_cycle {C:/Users/User/Desktop/single_cycle/SignExtend.v}
vlog -vlog01compat -work work +incdir+C:/Users/User/Desktop/single_cycle {C:/Users/User/Desktop/single_cycle/Comparator.v}
vlog -vlog01compat -work work +incdir+C:/Users/User/Desktop/single_cycle {C:/Users/User/Desktop/single_cycle/Mux_2_to_1.v}
vlog -vlog01compat -work work +incdir+C:/Users/User/Desktop/single_cycle {C:/Users/User/Desktop/single_cycle/Mux_3_to_1.v}
vlog -vlog01compat -work work +incdir+C:/Users/User/Desktop/single_cycle {C:/Users/User/Desktop/single_cycle/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/User/Desktop/single_cycle {C:/Users/User/Desktop/single_cycle/Adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/User/Desktop/single_cycle {C:/Users/User/Desktop/single_cycle/memory.v}

vlog -vlog01compat -work work +incdir+C:/Users/User/Desktop/single_cycle {C:/Users/User/Desktop/single_cycle/tb_cpu.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  tb_cpu

add wave *
view structure
view signals
run -all
