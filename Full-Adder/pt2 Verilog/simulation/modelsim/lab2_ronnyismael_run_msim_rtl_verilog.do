transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/rismael/Documents/Homework/S23/CMPE125/Lab/Lab2/pt2\ Verilog {C:/Users/rismael/Documents/Homework/S23/CMPE125/Lab/Lab2/pt2 Verilog/lab2_ronnyismael.v}

