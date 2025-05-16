# SPI IP Directed Verification

## Setup

### Linux

Make sure `settings64.sh` is sourced before running the following commands.

```bash
export GIT_ROOT=$(git rev-parse --show-toplevel)
export UVM_WORK="$GIT_ROOT/work/directed"
mkdir -p work/uvm && cd work/directed
ln -sf $GIT_ROOT/verification/directed/scripts/makefiles/Makefile.xilinx Makefile
ln -sf $GIT_ROOT/verification/directed/scripts/setup/setup_vivado_eda.sh
source setup_synopsys_eda.sh
make
```

### Windows

Use [Git for Windows](https://git-scm.com/downloads/win) and make sure
`settings64.sh` is sourced before running the following commands.

```bash
export GIT_ROOT=$(git rev-parse --show-toplevel)
export UVM_WORK="$GIT_ROOT/work/directed"
mkdir -p work/directed && cd work/directed
ln -sf $GIT_ROOT/verification/directed/scripts/makefiles/Makefile.xilinx Makefile
ln -sf $GIT_ROOT/verification/directed/scripts/setup/setup_vivado_eda.sh
ln -sf $GIT_ROOT/verification/directed/scripts/setup/settings64.sh
source setup_synopsys_eda.sh
make
```
