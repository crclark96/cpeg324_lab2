default: shift_reg_tb

dff.o: dff.vhdl
	ghdl -a dff.vhdl

shift_reg.o: shift_reg.vhdl
	ghdl -a shift_reg.vhdl

shift_reg_tb.o: shift_reg_tb.vhdl
	ghdl -a shift_reg_tb.vhdl

shift_reg_tb: shift_reg_tb.o shift_reg.o dff.o
	ghdl -e shift_reg_tb.vhdl
	ghdl -r shift_reg_tb --vcd=shift_reg_tb.vcd
