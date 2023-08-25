transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/helcsnewsxd/Documentos/famaf/arqui/Arquitectura-del-Computador/SingleCycleProcessor {/home/helcsnewsxd/Documentos/famaf/arqui/Arquitectura-del-Computador/SingleCycleProcessor/alu.sv}

vlog -sv -work work +incdir+/home/helcsnewsxd/Documentos/famaf/arqui/Arquitectura-del-Computador/SingleCycleProcessor {/home/helcsnewsxd/Documentos/famaf/arqui/Arquitectura-del-Computador/SingleCycleProcessor/alu_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  alu_tb

add wave *
view structure
view signals
run -all
