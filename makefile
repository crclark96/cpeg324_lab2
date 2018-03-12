default: shift_reg_tb

mux_4_1.o: mux_4_1.vhdl
	ghdl -a mux_4_1.vhdl

dff.o: dff.vhdl
	ghdl -a dff.vhdl

shift_reg.o: shift_reg.vhdl dff.o mux_4_1.o
	ghdl -a shift_reg.vhdl

shift_reg_tb.o: shift_reg_tb.vhdl shift_reg.o
	ghdl -a shift_reg_tb.vhdl

shift_reg_tb: shift_reg_tb.o
	ghdl -e shift_reg_tb
	ghdl -r shift_reg_tb --vcd=shift_reg_tb.vcd
