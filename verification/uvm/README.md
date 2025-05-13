# SPI IP UVM Verification

## Setup

```bash
export GIT_ROOT=$(git rev-parse --show-toplevel)
export UVM_WORK="$GIT_ROOT/work/uvm"
mkdir -p work/uvm && cd work/uvm
ln -sf $GIT_ROOT/scripts/makefiles/Makefile.xilinx Makefile
ln -sf $GIT_ROOT/scripts/setup/setup_vivado_eda.sh
source setup_synopsys_eda.tcsh
make
```
