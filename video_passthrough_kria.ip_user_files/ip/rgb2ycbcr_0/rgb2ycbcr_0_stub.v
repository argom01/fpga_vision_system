// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Mon Apr 27 11:16:22 2026
// Host        : DESKTOP-I43IRA7 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/hhhh/rekonfigi/video_passthrough_kria/video_passthrough_kria.gen/sources_1/ip/rgb2ycbcr_0/rgb2ycbcr_0_stub.v
// Design      : rgb2ycbcr_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xck26-sfvc784-2LV-c
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "rgb2ycbcr,Vivado 2022.2" *)
module rgb2ycbcr_0(clk, hsync_in, vsync_in, de_in, pixel_in, 
  hsync_out, vsync_out, de_out, pixel_out)
/* synthesis syn_black_box black_box_pad_pin="clk,hsync_in,vsync_in,de_in,pixel_in[23:0],hsync_out,vsync_out,de_out,pixel_out[23:0]" */;
  input clk;
  input hsync_in;
  input vsync_in;
  input de_in;
  input [23:0]pixel_in;
  output hsync_out;
  output vsync_out;
  output de_out;
  output [23:0]pixel_out;
endmodule
