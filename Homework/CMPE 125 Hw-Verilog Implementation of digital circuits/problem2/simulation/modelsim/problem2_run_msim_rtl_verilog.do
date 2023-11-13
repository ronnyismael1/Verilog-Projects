transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/rismael/Documents/Homework/S23/CMPE125/Homework/Homework/CMPE\ 125\ Hw-Verilog\ Implementation\ of\ digital\ circuits/problem2 {C:/Users/rismael/Documents/Homework/S23/CMPE125/Homework/Homework/CMPE 125 Hw-Verilog Implementation of digital circuits/problem2/problem2.v}

