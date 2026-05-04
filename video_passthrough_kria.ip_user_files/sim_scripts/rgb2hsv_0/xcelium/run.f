-makelib xcelium_lib/xilinx_vip -sv \
  "C:/Xilinx/Vivado/2022.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
  "C:/Xilinx/Vivado/2022.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
  "C:/Xilinx/Vivado/2022.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
  "C:/Xilinx/Vivado/2022.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
  "C:/Xilinx/Vivado/2022.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
  "C:/Xilinx/Vivado/2022.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
  "C:/Xilinx/Vivado/2022.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
  "C:/Xilinx/Vivado/2022.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
  "C:/Xilinx/Vivado/2022.2/data/xilinx_vip/hdl/rst_vip_if.sv" \
-endlib
-makelib xcelium_lib/xpm -sv \
  "C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
  "C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xbip_utils_v3_0_10 \
  "../../../ipstatic/hdl/xbip_utils_v3_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xbip_pipe_v3_0_6 \
  "../../../ipstatic/hdl/xbip_pipe_v3_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xbip_bram18k_v3_0_6 \
  "../../../ipstatic/hdl/xbip_bram18k_v3_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/mult_gen_v12_0_18 \
  "../../../ipstatic/hdl/mult_gen_v12_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../video_passthrough_kria.gen/sources_1/ip/rgb2hsv_0/src/mult_gen_1/sim/mult_gen_1.vhd" \
-endlib
-makelib xcelium_lib/axi_utils_v2_0_6 \
  "../../../ipstatic/hdl/axi_utils_v2_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xbip_dsp48_wrapper_v3_0_4 \
  "../../../ipstatic/hdl/xbip_dsp48_wrapper_v3_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xbip_dsp48_addsub_v3_0_6 \
  "../../../ipstatic/hdl/xbip_dsp48_addsub_v3_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/floating_point_v7_0_20 \
  "../../../ipstatic/hdl/floating_point_v7_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xbip_dsp48_mult_v3_0_6 \
  "../../../ipstatic/hdl/xbip_dsp48_mult_v3_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xbip_dsp48_multadd_v3_0_6 \
  "../../../ipstatic/hdl/xbip_dsp48_multadd_v3_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/div_gen_v5_1_19 \
  "../../../ipstatic/hdl/div_gen_v5_1_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../video_passthrough_kria.gen/sources_1/ip/rgb2hsv_0/src/div_gen_1/sim/div_gen_1.vhd" \
-endlib
-makelib xcelium_lib/c_reg_fd_v12_0_6 \
  "../../../ipstatic/hdl/c_reg_fd_v12_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xbip_addsub_v3_0_6 \
  "../../../ipstatic/hdl/xbip_addsub_v3_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/c_addsub_v12_0_14 \
  "../../../ipstatic/hdl/c_addsub_v12_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../video_passthrough_kria.gen/sources_1/ip/rgb2hsv_0/src/c_addsub_2/sim/c_addsub_2.vhd" \
  "../../../../video_passthrough_kria.gen/sources_1/ip/rgb2hsv_0/src/c_addsub_1/sim/c_addsub_1.vhd" \
  "../../../../video_passthrough_kria.gen/sources_1/ip/rgb2hsv_0/src/mult_gen_0/sim/mult_gen_0.vhd" \
  "../../../../video_passthrough_kria.gen/sources_1/ip/rgb2hsv_0/src/div_gen_2/sim/div_gen_2.vhd" \
  "../../../../video_passthrough_kria.gen/sources_1/ip/rgb2hsv_0/src/c_addsub_0/sim/c_addsub_0.vhd" \
  "../../../../video_passthrough_kria.gen/sources_1/ip/rgb2hsv_0/src/div_gen_0/sim/div_gen_0.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../video_passthrough_kria.gen/sources_1/ip/rgb2hsv_0/src/delay_line.v" \
  "../../../../video_passthrough_kria.gen/sources_1/ip/rgb2hsv_0/src/rgb_max.v" \
  "../../../../video_passthrough_kria.gen/sources_1/ip/rgb2hsv_0/src/rgb_min.v" \
  "../../../../video_passthrough_kria.gen/sources_1/ip/rgb2hsv_0/src/rgb2hsv.v" \
  "../../../../video_passthrough_kria.gen/sources_1/ip/rgb2hsv_0/sim/rgb2hsv_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

