source ../../../scripts/adi_env.tcl
source $ad_hdl_dir/projects/scripts/adi_project_xilinx.tcl
source $ad_hdl_dir/projects/scripts/adi_board.tcl

adi_project_create fmcomms5_zc706 0 [list] xc7z100ffg900-2 not-applicable
adi_project_files fmcomms5_zc706 [list \
  "system_top.v" \
  "ADF4001_init.v" \
  "ADF4001_spi_drive.v" \
  "system_constr.xdc"\
  "$ad_hdl_dir/library/common/ad_iobuf.v" \
  "$ad_hdl_dir/projects/common/zc706/zc706_system_constr.xdc" ]

set_property STEPS.WRITE_BITSTREAM.TCL.PRE \
  [file normalize write_bitstream_prehook.tcl] [get_runs impl_1]

adi_project_run fmcomms5_zc706
source $ad_hdl_dir/library/axi_ad9361/axi_ad9361_delay.tcl
