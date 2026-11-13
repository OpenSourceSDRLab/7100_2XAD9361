# Third-party notices

This repository and its release files contain work by OpenSourceSDRLab together with third-party software. The Apache License 2.0 in [LICENSE](LICENSE) applies **only** to the files created by OpenSourceSDRLab:

- `docs/`, `hardware/`, `images/`, `README.md`, `NOTICE.md`, and the `README.md` files in sub-folders
- in `baremetal/`:
  - `FMCOMMS5_PS/LED/src/main.c`
- in `linux/`:
  - `prepare.sh`
  - `petalinux/project-spec/meta-user/recipes-apps/fmcomms5-heartbeat/` (the recipe itself declares MIT)
  - `petalinux/project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi`
  - `hdl/projects/fmcomms5/zc706/`: `ADF4001_init.v`, `ADF4001_spi_drive.v`, `write_bitstream_prehook.tcl`, `mem_init_sys.txt` (new files for this board)

All other files keep their original copyright notices and licences, which have not been changed:

| Component | Files | Owner | Licence |
|---|---|---|---|
| ADI HDL project files (modified by OpenSourceSDRLab for this board) | `linux/hdl/projects/fmcomms5/zc706/` `Makefile`, `system_bd.tcl`, `system_constr.xdc`, `system_project.tcl`, `system_top.v`; `linux/hdl/projects/common/zc706/`; `baremetal/FMCOMMS5_PL/projects/fmcomms5/zc706/system_top.v`, `system_constr.xdc`; `baremetal/FMCOMMS5_PL/projects/common/zc706/zc706_system_constr.xdc` | Analog Devices, Inc. | ADI HDL licence terms, see `linux/hdl/LICENSE*` and `baremetal/FMCOMMS5_PL/LICENSE*` |
| AD9361 driver, ADF5355 driver and no-OS platform code (Analog Devices no-OS, release `2023_R2`) | `baremetal/FMCOMMS5_PS/FMCOMMS5/` (`ad9361/`, `api/`, `axi_core/`, `iio/`, `include/`, `util/`, `xilinx/`, `src/`) | Analog Devices, Inc. | BSD-style licence in each file header. Modified versions: `src/main.c`, `src/parameters.h`, `src/app_config.h`, `src/adf5355.*`, `api/no_os_spi.c`, `iio/iio_app/iio_app.c`, `xilinx/xilinx_axi_io.c` and the files in `axi_core/` contain changes made for this board (ADF5355 external LO, four-channel DMA example, include paths) |
| Linux kernel changes | `linux/kernel/0001-7100_2XAD9361-board-support.patch` (changes to Analog Devices / Xilinx kernel files) | Analog Devices, Inc., Xilinx, Inc. and the Linux kernel authors | GPL-2.0 |
| meta-adi device-tree files (modified / added) | `linux/meta-adi-2022_R2/` | Analog Devices, Inc. | MIT |
| PetaLinux project configuration | `linux/petalinux/project-spec/` (generated configuration and recipe templates), `linux/hardware/system_top.xsa` | Xilinx, Inc. / AMD | Xilinx/AMD licence terms |
| Xilinx/AMD IP cores, block design and generated files | `baremetal/FMCOMMS5_PL/projects/fmcomms5/zc706/fmcomms5_zc706.xpr` and `fmcomms5_zc706.srcs/` (`.bd`, `.xci` and generated files), `baremetal/FMCOMMS5_PS/system_top.xsa`, and the Xilinx parts of the prebuilt `.bit`, `.xsa` and `fsbl.elf` in Releases | Xilinx, Inc. / AMD | Xilinx/AMD licence terms |
| Xilinx example applications | `baremetal/FMCOMMS5_PS/TCP_Server/`, `DDR_Test/`, `xusbps_intr_example_1/`, and the `lscript.ld` linker scripts | Xilinx, Inc. | as stated in each file header (MIT / BSD-style) |
| lwIP library (inside `TCP_Server.elf` in Releases) | Releases only | Swedish Institute of Computer Science and contributors; Xilinx, Inc. | BSD-style |
| SD-card image and boot files (Releases) | Linux kernel, U-Boot, BusyBox and other root-filesystem packages built with PetaLinux 2022.2 and the Analog Devices kernel 2022_R2; FPGA bitstream built from the ADI HDL | the respective authors (Linux kernel and U-Boot: GPL-2.0) | as stated in each component; source code: see below |

The bare-metal FPGA design is based on the Analog Devices HDL repository, branch `hdl_2023_r2`, commit `d146370c10fdd55156de2bafdd9b24292c01b6e1`; only the files changed for this board are included (see `baremetal/README.md`).

Source code of the GPL software in the SD-card image: the kernel is the Analog Devices Linux kernel, branch `2022_R2` (commit `7aa63204d396316bb6c362b34294babae7a6f32b`), with the changes in `linux/kernel/`; U-Boot and the root filesystem are built by PetaLinux 2022.2 from the Xilinx/AMD and Yocto sources of that release with the configuration in `linux/petalinux/`. See `linux/README.md`. To receive the complete corresponding source code of the GPL software in the image, write to support@opensourcesdrlab.com.

"Analog Devices", "AD9361", "ADF5355", "ADF4001", "FMCOMMS5", "Xilinx", "Zynq", "Vivado", "Vitis" and "PetaLinux" are trademarks of their respective owners. They are used here only to describe compatibility and do not imply endorsement.
