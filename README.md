# OpenCore
An Open Source RISC-V core built using Verilog
Implements the RISC-V 32 IM ISA


# Instructions
## Download pre-requisites
```
sudo apt install -y autoconf gperf make gcc g++ bison flex gtkwave
git clone https://github.com/steveicarus/iverilog.git
cd iverilog
git checkout --track -b v11-branch origin/v11-branch
sh autoconf.sh
./configure
make
make install
cd ..
```
## Compile and run simulations
```
iverilog -o full_adder_tb full_adder.v tb_full_adder.v
iverilog -o sequential_tb sequential.v sequential_tb.v
vvp full_adder_tb
vvp sequential_tb
```
### Waveforms
```
gtkwave full_adder.vcd
gtkwave sequential.vcd
```
