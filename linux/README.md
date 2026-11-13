# Linux (PetaLinux 2022.2) for the 7100_2XAD9361

This folder holds the board-specific part of the PetaLinux project that builds the SD-card image in the Releases. Everything else comes unchanged from Analog Devices and Xilinx/AMD release 2022_R2 / 2022.2.

| Path | Contents |
|---|---|
| `petalinux/` | PetaLinux 2022.2 project: `project-spec/` (configuration, device-tree additions incl. the ADF5355 external LO, U-Boot and kernel configuration fragments, `fmcomms5-heartbeat` monitor service) |
| `hardware/system_top.xsa` | Prebuilt hardware description: XC7Z100 PS configuration and the interface logic of both AD9361 (the PL DDR3 is not used) |
| `hdl/projects/` | Files of the Analog Devices `fmcomms5/zc706` HDL project that were changed or added for this board (XC7Z100-2FFG900 pin-out and PS configuration, ADF4001 reference PLL setup, no ZC706 I2C), plus the HDL licence files |
| `kernel/0001-7100_2XAD9361-board-support.patch` | Changes to the Analog Devices Linux kernel (ADF5355 RFOUTA enable pin, device trees for this board) |
| `meta-adi-2022_R2/` | Changed and added device-tree files of the Analog Devices `meta-adi` layer |
| `prepare.sh` | Points the project configuration at the folder it is run from |

## Upstream sources

| Component | Source | Version |
|---|---|---|
| HDL | <https://github.com/analogdevicesinc/hdl> | branch `hdl_2022_r2` |
| Linux kernel | <https://github.com/analogdevicesinc/linux> | branch `2022_R2`, commit `7aa63204d396316bb6c362b34294babae7a6f32b` |
| Yocto layer | <https://github.com/analogdevicesinc/meta-adi> | branch `2022_R2` |
| PetaLinux, U-Boot, root filesystem | Xilinx/AMD PetaLinux 2022.2 (U-Boot `u-boot-xlnx` `xilinx-v2022.2`) | 2022.2 |

## Assemble and build

On Ubuntu with PetaLinux 2022.2 and (only if you change the HDL) Vivado 2022.2:

1. Create the project tree. `<repo>` is your clone of this repository:

        mkdir -p ~/7100_2XAD9361 && cd ~/7100_2XAD9361
        git clone -b hdl_2022_r2 https://github.com/analogdevicesinc/hdl.git hdl
        git clone -b 2022_R2 https://github.com/analogdevicesinc/meta-adi.git meta-adi-2022_R2
        git clone -b 2022_R2 https://github.com/analogdevicesinc/linux.git linux-2022_R2
        git -C linux-2022_R2 checkout 7aa63204d396316bb6c362b34294babae7a6f32b
        git -C linux-2022_R2 apply <repo>/linux/kernel/0001-7100_2XAD9361-board-support.patch
        cp -r <repo>/linux/hdl/projects/. hdl/projects/
        cp -r <repo>/linux/meta-adi-2022_R2/. meta-adi-2022_R2/
        cp -r <repo>/linux/petalinux <repo>/linux/hardware <repo>/linux/prepare.sh .

2. Run `bash prepare.sh` once (again whenever the folder moves).

3. Load PetaLinux and build:

        source <petalinux-2022.2-install-dir>/settings.sh
        cd petalinux
        petalinux-config --get-hw-description=../hardware --silentconfig
        petalinux-config -c rootfs --silentconfig
        petalinux-build
        petalinux-package --boot --fsbl images/linux/zynq_fsbl.elf --fpga images/linux/system.bit \
          --u-boot images/linux/u-boot.elf --dtb images/linux/system.dtb --force

    The first build downloads the Yocto sources; on a machine without Internet access, prepare a `downloads` folder and point `CONFIG_PRE_MIRROR_URL` in `project-spec/configs/config` to it.

4. The results are in `petalinux/images/linux/`: `BOOT.BIN`, `image.ub`, `boot.scr`, `system.dtb` and `rootfs.tar.gz`. See the Quick Start Guide for writing them to an SD card.

To rebuild the hardware description, run `make` in `hdl/projects/fmcomms5/zc706` with Vivado 2022.2 and copy the resulting `system_top.xsa` to `hardware/`.

## Board notes

- Serial console: PS UART0, 115200 8N1 (`console=ttyPS0,115200 earlycon root=/dev/mmcblk0p2 rw rootwait`).
- Network: `eth0` static `192.168.1.10/24`, gateway `192.168.1.1`.
- Login: `root` / `root` (PetaLinux image with `CONFIG_ADD_EXTRA_USERS`).
- Heartbeat LED: the white PS_LED (MIO7, `/sys/class/leds/fmcomms5:heartbeat`) is driven by the kernel `heartbeat` trigger and blinks from boot, independent of the radios. The `fmcomms5-heartbeat` service only monitors both AD9361 and logs their state (`logread | grep fmcomms5-heartbeat`).
- External LO: the on-board ADF5355 (IC17) drives the TX and RX `EXT_LO_IN` of both AD9361 from RFOUTA through an ADCLK925; RFOUTB is off. The RFOUTA enable (`5355_RF_EN`, FPGA AE20, EMIO GPIO 57) is handled by the driver through `adi,pdbrf-gpio` and follows `out_altvoltage0_powerdown`. Default output 4.8 GHz (`adi,clock-shift = <2>`), i.e. an LO of 2.4 GHz on both chips.
