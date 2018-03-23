# Collin Clark, Zachary Irons
### CPEG 324
### Lab 2
### 2 April 2018

## Abstract

We implemented three designs in this project: a generic 4-to-1 mux,
an 8-bit shift register, and a 4-bit add/subtractor. All designs are
implemented in gate-level RTL designs using synthesizable VHDL constructs
such that they could be used to program FPGA chips with these designs.

All of our designs ran conclusive testbenches for corner cases and general
case problems.

## Division of Labor

The project has three main sections, each with two tasks. Each design
(mux, register, and adder), requires both a VHDL implementation and
a test bench. Zach and Collin worked together to write the logic design,
while Collin wrote the VHDL implementation for the mux and register,
Zach wrote the VHDL implementation for the adder. The two wrote test benches
for the designs they did not implement.

## Detailed Strategy

Each system is implemented using only gate-level RTL. The 4 bit shift register
contains four simple DFFs with a combinational circuit to calculate all
of the inputs to the DFF block. The 8 bit shift register is simply two
4 bit shift registers with the appropriate portions of bus signal mapping
between the two. A simple mux determines the I_SHIFT_IN signal for the
registers, which allows them to carry bits between the two.

The 4 bit adder is a cascade of single bit full adders, with a possible bitwise
inversion for one of the inputs to allow for subtraction. During subtraction,
a single bit is carried in to create a two's complement representation of the
input value. Overflow and underflow are determined by logical operations.
Underflow can only occur when adding two negative numbers and creating a
positive, while overflow is the opposite. Only the sign bits are used for these
comparisons. Underflow is not the signed bit of the result, and carry out,
and the signed bits of the two inputs. Overflow is not the signed bit of
the first input, anded with not the signed bit of the second input, the
result of which is anded with the signed bit of the output.

## Results

All of our components passed their testbenches.

For the mux, we tested each possible selection and got the corresponding input.

For the 4 bit shift register, we tested every combination of operations,
including shifting left and right with both 0 and 1 as inputs, and overflowing
past the register's capacity. We also tested our enable function and holding.

For the 8 bit shift register, we tested every combination of operations,
as well as shifting past the middle (between the two inner registers) and
shifting values into both sides.

For the adder, we tested every possible combination of addition and subtraction
with positive and negative numbers, as well as one of each for overflow
and underflow.

## Conclusion

The most difficult part of the lab was that some of the behavior wasn't
precisely specified, so some ambiguity with the design made it difficult
to implement. Once we grasped all of the concepts, the lab was fairly
straightforward and we were able to implement all of the components quickly
and easily. Writing testbenches for every possible case is a bit tedious,
though our fledgling knowledge of VHDL may have contributed to the tedium.

Our project has no functional errors to the extent of our knowledge.

## Appendix I

## Appendix II

## Appendix III

