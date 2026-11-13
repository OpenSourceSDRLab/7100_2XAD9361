source $ad_hdl_dir/projects/common/zc706/zc706_system_bd.tcl

# The 7100_2XAD9361 board does not expose the ZC706 I2C interface.
delete_bd_objs [get_bd_cells axi_iic_main] [get_bd_intf_ports iic_main]
ad_connect sys_concat_intc/In14 GND

source $ad_hdl_dir/projects/scripts/adi_pd.tcl

set mem_init_sys_path [get_env_param ADI_PROJECT_DIR ""]mem_init_sys.txt;

#system ID
ad_ip_parameter axi_sysid_0 CONFIG.ROM_ADDR_BITS 9
ad_ip_parameter rom_sys_0 CONFIG.PATH_TO_FILE "[pwd]/$mem_init_sys_path"
ad_ip_parameter rom_sys_0 CONFIG.ROM_ADDR_BITS 9

sysid_gen_sys_init_file

ad_ip_parameter sys_ps7 CONFIG.PCW_EN_CLK2_PORT 1
ad_ip_parameter sys_ps7 CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ 200.0

############################################################################################
# PS7 board-level configuration of the OpenSourceSDRLab XC7Z100 board
#   DDR3 MT41K256M16 (16-bit, 4 Gbit, LVCMOS bank0 3.3V), UART0 on MIO14/15.
#   Values are identical to the original board XSA and to the verified ADRV9009 / ADRV9371
#   XC7Z100 projects. Applied AFTER the ZC706 preset; PS-side parameters only.
#   NOTE: PCW_PRESET_BANK0_VOLTAGE must be set before the PCW_MIO_n_IOTYPE values.
############################################################################################
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_PARTNO "MT41K256M16 RE-125"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_DRAM_WIDTH "16 Bits"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_DEVICE_CAPACITY "4096 MBits"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_USE_INTERNAL_VREF "0"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_T_FAW "40.0"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_T_RAS_MIN "35.0"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_T_RC "48.75"
ad_ip_parameter sys_ps7 CONFIG.PCW_PRESET_BANK0_VOLTAGE "LVCMOS 3.3V"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_0_IOTYPE "LVCMOS 3.3V"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_10_IOTYPE "LVCMOS 3.3V"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_11_IOTYPE "LVCMOS 3.3V"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_12_IOTYPE "LVCMOS 3.3V"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_13_IOTYPE "LVCMOS 3.3V"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_14_IOTYPE "LVCMOS 3.3V"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_15_IOTYPE "LVCMOS 3.3V"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_1_IOTYPE "LVCMOS 3.3V"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_2_IOTYPE "LVCMOS 3.3V"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_3_IOTYPE "LVCMOS 3.3V"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_4_IOTYPE "LVCMOS 3.3V"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_5_IOTYPE "LVCMOS 3.3V"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_6_IOTYPE "LVCMOS 3.3V"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_7_IOTYPE "LVCMOS 3.3V"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_8_IOTYPE "LVCMOS 3.3V"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_9_IOTYPE "LVCMOS 3.3V"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_TREE_PERIPHERALS "Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#GPIO#GPIO#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#UART 0#UART 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#USB Reset#GPIO#GPIO#GPIO#GPIO#GPIO#Enet 0#Enet 0"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_TREE_SIGNALS "qspi1_ss_b#qspi0_ss_b#qspi0_io[0]#qspi0_io[1]#qspi0_io[2]#qspi0_io[3]/HOLD_B#qspi0_sclk#gpio[7]#gpio[8]#qspi1_sclk#qspi1_io[0]#qspi1_io[1]#qspi1_io[2]#qspi1_io[3]#rx#tx#tx_clk#txd[0]#txd[1]#txd[2]#txd[3]#tx_ctl#rx_clk#rxd[0]#rxd[1]#rxd[2]#rxd[3]#rx_ctl#data[4]#dir#stp#nxt#data[0]#data[1]#data[2]#data[3]#clk#data[5]#data[6]#data[7]#clk#cmd#data[0]#data[1]#data[2]#data[3]#reset#gpio[47]#gpio[48]#gpio[49]#gpio[50]#gpio[51]#mdc#mdio"
ad_ip_parameter sys_ps7 CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY0 "0.100"
ad_ip_parameter sys_ps7 CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY1 "0.113"
ad_ip_parameter sys_ps7 CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY2 "0.111"
ad_ip_parameter sys_ps7 CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY3 "0.100"
ad_ip_parameter sys_ps7 CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_0 "-0.017"
ad_ip_parameter sys_ps7 CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_1 "-0.039"
ad_ip_parameter sys_ps7 CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_2 "-0.040"
ad_ip_parameter sys_ps7 CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_3 "-0.016"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 "0.25"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 "0.25"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 "0.25"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 "0.25"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 "0.0"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 "0.0"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 "0.0"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 "0.0"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PACKAGE_LENGTH "92.3275"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PACKAGE_LENGTH "92.3275"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PACKAGE_LENGTH "92.3275"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PACKAGE_LENGTH "92.3275"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_DQS_0_PACKAGE_LENGTH "108.9255"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_DQS_1_PACKAGE_LENGTH "131.286"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_DQS_2_PACKAGE_LENGTH "131.83"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_DQS_3_PACKAGE_LENGTH "108.5285"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_DQ_0_PACKAGE_LENGTH "107.643"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_DQ_1_PACKAGE_LENGTH "132.917"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_DQ_2_PACKAGE_LENGTH "129.6135"
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_DQ_3_PACKAGE_LENGTH "108.6395"
ad_ip_parameter sys_ps7 CONFIG.PCW_ENET0_RESET_ENABLE "0"
ad_ip_parameter sys_ps7 CONFIG.PCW_ENET0_RESET_IO "<Select>"
ad_ip_parameter sys_ps7 CONFIG.PCW_EN_I2C0 "0"
ad_ip_parameter sys_ps7 CONFIG.PCW_EN_UART0 "1"
ad_ip_parameter sys_ps7 CONFIG.PCW_EN_UART1 "0"
ad_ip_parameter sys_ps7 CONFIG.PCW_FTM_CTI_IN0 "<Select>"
ad_ip_parameter sys_ps7 CONFIG.PCW_FTM_CTI_IN1 "<Select>"
ad_ip_parameter sys_ps7 CONFIG.PCW_FTM_CTI_IN2 "<Select>"
ad_ip_parameter sys_ps7 CONFIG.PCW_FTM_CTI_IN3 "<Select>"
ad_ip_parameter sys_ps7 CONFIG.PCW_FTM_CTI_OUT0 "<Select>"
ad_ip_parameter sys_ps7 CONFIG.PCW_FTM_CTI_OUT1 "<Select>"
ad_ip_parameter sys_ps7 CONFIG.PCW_FTM_CTI_OUT2 "<Select>"
ad_ip_parameter sys_ps7 CONFIG.PCW_FTM_CTI_OUT3 "<Select>"
ad_ip_parameter sys_ps7 CONFIG.PCW_I2C0_I2C0_IO "<Select>"
ad_ip_parameter sys_ps7 CONFIG.PCW_I2C0_PERIPHERAL_ENABLE "0"
ad_ip_parameter sys_ps7 CONFIG.PCW_I2C0_RESET_ENABLE "0"
ad_ip_parameter sys_ps7 CONFIG.PCW_I2C0_RESET_IO "<Select>"
ad_ip_parameter sys_ps7 CONFIG.PCW_I2C_PERIPHERAL_FREQMHZ "25"
ad_ip_parameter sys_ps7 CONFIG.PCW_I2C_RESET_ENABLE "0"
ad_ip_parameter sys_ps7 CONFIG.PCW_I2C_RESET_SELECT "<Select>"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_15_DIRECTION "out"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_47_DIRECTION "inout"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_48_DIRECTION "inout"
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_49_DIRECTION "inout"
ad_ip_parameter sys_ps7 CONFIG.PCW_PERIPHERAL_BOARD_PRESET "part0"
ad_ip_parameter sys_ps7 CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE "0"
ad_ip_parameter sys_ps7 CONFIG.PCW_QSPI_GRP_FBCLK_IO "<Select>"
ad_ip_parameter sys_ps7 CONFIG.PCW_SD0_GRP_CD_ENABLE "0"
ad_ip_parameter sys_ps7 CONFIG.PCW_SD0_GRP_CD_IO "<Select>"
ad_ip_parameter sys_ps7 CONFIG.PCW_SD0_GRP_WP_ENABLE "0"
ad_ip_parameter sys_ps7 CONFIG.PCW_SD0_GRP_WP_IO "<Select>"
ad_ip_parameter sys_ps7 CONFIG.PCW_UART0_PERIPHERAL_ENABLE "1"
ad_ip_parameter sys_ps7 CONFIG.PCW_UART0_UART0_IO "MIO 14 .. 15"
ad_ip_parameter sys_ps7 CONFIG.PCW_UART1_PERIPHERAL_ENABLE "0"
ad_ip_parameter sys_ps7 CONFIG.PCW_UART1_UART1_IO "<Select>"
ad_ip_parameter sys_ps7 CONFIG.PCW_USB0_RESET_IO "MIO 46"

ad_connect  sys_dma_clk sys_ps7/FCLK_CLK2
source ../common/fmcomms5_bd.tcl

ad_ip_parameter axi_ad9361_0 CONFIG.ADC_INIT_DELAY 16
ad_ip_parameter axi_ad9361_1 CONFIG.ADC_INIT_DELAY 16
