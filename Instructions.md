# Instructions
This project uses the `icarus-verilog` suite, along with `gtkwave` to view our simulation waveforms.
Our synthesis and implementation tools are yet to be decided (dependent on FPGA chipset being used).

The files we use to describe our designs are design sources, while those used to simulate and test their operation are simulation sources (or otherwise known as testbenches).
## Download pre-requisites
## Mac
```sh
brew install icarus-verilog
brew install --cask gtkwave
```
## *nix/WSL
```sh
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
```sh
iverilog -o [output file]  [testbench] [design source]
vvp [output file]
```
### Waveforms
```sh
gtkwave [output waveform file] # See the file name in the corresponding test bench
```
