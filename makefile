EXEC = mux_4_1 shift_reg dff shift_reg_tb adder_4_bit_tb adder_4_bit full_adder
CC = ghdl

default: shift_reg_tb adder_4_bit_tb

add: adder_4_bit_tb

shift: shift_reg_tb

mux_4_1.o: mux_4_1.vhdl
	$(CC) -a mux_4_1.vhdl

dff.o: dff.vhdl
	$(CC) -a dff.vhdl

shift_reg.o: shift_reg.vhdl dff.o mux_4_1.o
	$(CC) -a shift_reg.vhdl

shift_reg_tb.o: shift_reg_tb.vhdl shift_reg.o
	$(CC) -a shift_reg_tb.vhdl

shift_reg_tb: shift_reg_tb.o
	$(CC) -e shift_reg_tb
	$(CC) -r shift_reg_tb --vcd=shift_reg_tb.vcd
	
full_adder.o: full_adder.vhdl
	$(CC) -a full_adder.vhdl
	
adder_4_bit.o: adder_4_bit.vhdl full_adder.o
	$(CC) -a adder_4_bit.vhdl
	
adder_4_bit_tb.o: adder_4_bit_tb.vhdl adder_4_bit.o
	$(CC) -a adder_4_bit_tb.vhdl
	
adder_4_bit_tb: adder_4_bit_tb.o
	$(CC) -e adder_4_bit_tb
	$(CC) -r adder_4_bit_tb --vcd=adder_4_bit_tb.vcd

clean:
	rm *.o *.vcd *.cf $(EXEC)
