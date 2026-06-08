`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2026 12:43:22 AM
// Design Name: 
// Module Name: vision_system
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vision_system(
    input clk,
    input [3:0]sw,
    input de_in,
    input hsync_in,
    input vsync_in,
    input [23:0]pixel_in,
    
    output de_out,
    output hsync_out,
    output vsync_out,
    output [23:0]pixel_out
    );
    
    localparam H_SIZE = 2200;
    localparam WIDTH = 1920;
    localparam HEIGHT = 1080;
    
//    localparam H_SIZE = 83;
//    localparam WIDTH = 64;
//    localparam HEIGHT = 64;
    
    wire [23:0] rgb_mux [15:0];
    wire de_mux[15:0];
    wire hsync_mux[15:0];
    wire vsync_mux[15:0];
    
    //rgb_out
    
    assign rgb_mux[0] = pixel_in;
    assign de_mux[0] = de_in;
    assign hsync_mux[0] = hsync_in;
    assign vsync_mux[0] = vsync_in;
    
    //lut_out
    
    reg r_de = 0;
    reg r_hsync = 0;
    reg r_vsync = 0;
    
    always @(posedge clk)
    begin
        r_de <= de_in;
        r_hsync <= hsync_in;
        r_vsync <= vsync_in;
    end
        
    assign de_mux[1] = r_de;
    assign hsync_mux[1] = r_hsync;
    assign vsync_mux[1] = r_vsync;
    
    lut lut_r (
        .a(pixel_in[23:16]),
        .clk(clk),
        .qspo(rgb_mux[1][23:16])
        );
        
    lut lut_g (
        .a(pixel_in[15:8]),
        .clk(clk),
        .qspo(rgb_mux[1][15:8])
        );
        
    lut lut_b (
        .a(pixel_in[7:0]),
        .clk(clk),
        .qspo(rgb_mux[1][7:0])
        );
    
    //lut_binary_out
    
    wire r_out;
    wire g_out;
    wire b_out;
    
    lut_binary lut_binary_r (
        .a(pixel_in[23:16]),
        .clk(clk),
        .qspo(r_out)
        );
        
    lut_binary lut_binary_g (
        .a(pixel_in[15:8]),
        .clk(clk),
        .qspo(g_out)
        );
    
    lut_binary lut_binary_b (
        .a(pixel_in[7:0]),
        .clk(clk),
        .qspo(b_out)
        );
         
    assign de_mux[2] = r_de;
    assign hsync_mux[2] = r_hsync;
    assign vsync_mux[2] = r_vsync;
    
    assign rgb_mux[2] = {24{r_out & g_out & b_out}};  
    
    //ycbcr_out
    
    rgb2ycbcr_1 rgb2ycbcr (
        .clk(clk),
        .de_in(de_in),
        .hsync_in(hsync_in),
        .vsync_in(vsync_in),
        .de_out(de_mux[3]),
        .hsync_out(hsync_mux[3]),
        .vsync_out(vsync_mux[3]),
        
        .pixel_in(pixel_in),
        .pixel_out(rgb_mux[3])
        );
        
    //ycbcr_bin_out
    
    localparam Ta = 8'd70;
    localparam Tb = 8'd130;
    localparam Tc = 8'd55;
    localparam Td = 8'd110;
    
    wire [7:0] Cb = rgb_mux[3][15:8];
    wire [7:0] Cr = rgb_mux[3][7:0];
    
    assign ycbcr_bin = (Cb > Ta && Cb < Tb && Cr > Tc && Cr < Td) ? 1 : 0;
    
    assign rgb_mux[4] = {24{ycbcr_bin}};
    assign de_mux[4] = de_mux[3];
    assign hsync_mux[4] = hsync_mux[3];
    assign vsync_mux[4] = vsync_mux[3];
    
    wire [11:0] centroid_x;
    wire [11:0] centroid_y;
    
    //5x5median_out
    
    median5x5 # (
        .H_SIZE(H_SIZE)
    ) median_filter (
        .clk(clk),
        .de_in(de_mux[4]),
        .hsync_in(hsync_mux[4]),
        .vsync_in(vsync_mux[4]),
        .mask(rgb_mux[4][0]),
        .de_out(de_mux[5]),
        .hsync_out(hsync_mux[5]),
        .vsync_out(vsync_mux[5]),
        .pixel_out(rgb_mux[5])
        );
        
    // opening
    wire [23:0] erosion_pixel_out;
    wire [2:0] opening_sync;
    
    erosion5x5 # (
        .H_SIZE(H_SIZE)
    ) erosion_opening (
        .clk(clk),
        .de_in(de_mux[4]),
        .hsync_in(hsync_mux[4]),
        .vsync_in(vsync_mux[4]),
        .mask(rgb_mux[4][0]),
        .de_out(opening_sync[0]),
        .hsync_out(opening_sync[1]),
        .vsync_out(opening_sync[2]),
        .pixel_out(erosion_pixel_out)
        );
    
    dilation5x5 # (
        .H_SIZE(H_SIZE)
    ) dilation_opening (
        .clk(clk),
        .de_in(opening_sync[0]),
        .hsync_in(opening_sync[1]),
        .vsync_in(opening_sync[2]),
        .mask(erosion_pixel_out[0]),
        .de_out(de_mux[9]),
        .hsync_out(hsync_mux[9]),
        .vsync_out(vsync_mux[9]),
        .pixel_out(rgb_mux[9])
        );
        
    // opening
    wire [23:0] dilation_pixel_out;
    wire [2:0] closing_sync;
    
    dilation5x5 # (
        .H_SIZE(H_SIZE)
    ) dilation_closing (
        .clk(clk),
        .de_in(de_mux[4]),
        .hsync_in(hsync_mux[4]),
        .vsync_in(vsync_mux[4]),
        .mask(rgb_mux[4][0]),
        .de_out(closing_sync[0]),
        .hsync_out(closing_sync[1]),
        .vsync_out(closing_sync[2]),
        .pixel_out(dilation_pixel_out)
        );
    
    erosion5x5 # (
        .H_SIZE(H_SIZE)
    ) erosion_closing (
        .clk(clk),
        .de_in(closing_sync[0]),
        .hsync_in(closing_sync[1]),
        .vsync_in(closing_sync[2]),
        .mask(dilation_pixel_out[0]),
        .de_out(de_mux[10]),
        .hsync_out(hsync_mux[10]),
        .vsync_out(vsync_mux[10]),
        .pixel_out(rgb_mux[10])
        );
    
    //centroid_out
    
    centroid # (
        .IMG_W(WIDTH),
        .IMG_H(HEIGHT)
    ) centroid (
        .clk(clk),
        .de(de_mux[5]),
        .hsync(hsync_mux[5]),
        .vsync(vsync_mux[5]),
        .mask(rgb_mux[5][0]),
        .centroid_x(centroid_x),
        .centroid_y(centroid_y)
        );
        
    vis_centroid # (
        .IMG_W(WIDTH),
        .IMG_H(HEIGHT)
    ) vis_centroid (
        .clk(clk),
        .de(de_mux[5]),
        .hsync(hsync_mux[5]),
        .vsync(vsync_mux[5]),
        .pixel_in(rgb_mux[5]),
        .x(centroid_x),
        .y(centroid_y),
        .pixel_out(rgb_mux[6]),
        .de_out(de_mux[6]),
        .hsync_out(hsync_mux[6]),
        .vsync_out(vsync_mux[6])
        );
    
    vis_centroid_circle # (
        .IMG_W(WIDTH),
        .IMG_H(HEIGHT),
        .RADIUS_PX(5)
    ) vis_centroid_circle (
        .clk(clk),
        .de(de_mux[5]),
        .hsync(hsync_mux[5]),
        .vsync(vsync_mux[5]),
        .pixel_in(rgb_mux[5]),
        .x(centroid_x),
        .y(centroid_y),
        .pixel_out(rgb_mux[7]),
        .de_out(de_mux[7]),
        .hsync_out(hsync_mux[7]),
        .vsync_out(vsync_mux[7])
        );
    
    //bbox
    
    wire [11:0] top;
    wire [11:0] bottom;
    wire [11:0] left;
    wire [11:0] right;
    
    bbox # (
        .IMG_W(WIDTH),
        .IMG_H(HEIGHT)
    ) bbox (
        .clk(clk),
        .de(de_mux[5]),
        .hsync(hsync_mux[5]),
        .vsync(vsync_mux[5]),
        .mask(rgb_mux[5][0]),
        .top(top),
        .bottom(bottom),
        .left(left),
        .right(right)
        );
        
    bbox_vis # (
        .IMG_W(WIDTH),
        .IMG_H(HEIGHT)
    ) bbox_vis (
        .clk(clk),
        .de(de_mux[5]),
        .hsync(hsync_mux[5]),
        .vsync(vsync_mux[5]),
        .pixel_in(rgb_mux[5]),
        .top(top),
        .bottom(bottom),
        .left(left),
        .right(right),
        .pixel_out(rgb_mux[8]),
        .de_out(de_mux[8]),
        .hsync_out(hsync_mux[8]),
        .vsync_out(vsync_mux[8])
        );
        
    // 3x3 filter
    filter3x3 # (
        .H_SIZE(H_SIZE)
    ) filter3x3 (
        .clk(clk),
        .de_in(de_mux[3]),
        .hsync_in(hsync_mux[3]),
        .vsync_in(vsync_mux[3]),
        .pixel_in(rgb_mux[3]),
        .de_out(de_mux[11]),
        .hsync_out(hsync_mux[11]),
        .vsync_out(vsync_mux[11]),
        .pixel_out(rgb_mux[11])
        );
        
    //sobel
    sobel_0 # (
        .H_SIZE(H_SIZE)
        ) sobel_0 (
        .clk(clk),
        .de_in(de_mux[3]),
        .hsync_in(hsync_mux[3]),
        .vsync_in(vsync_mux[3]),
        .pixel_in(rgb_mux[3]),
        .de_out(de_mux[12]),
        .hsync_out(hsync_mux[12]),
        .vsync_out(vsync_mux[12]),
        .pixel_out(rgb_mux[12])
        );
                
    //hsv_out
    
    rgb2hsv_0 rgb2hsv (
        .clk(clk),
        .de_in(de_in),
        .hsync_in(hsync_in),
        .vsync_in(vsync_in),
        .de_out(de_mux[15]),
        .hsync_out(hsync_mux[15]),
        .vsync_out(vsync_mux[15]),
        
        .pixel_in(pixel_in),
        .pixel_out(rgb_mux[15])
        );
    
    //output
    
    assign pixel_out = rgb_mux[sw];
    assign de_out = de_mux[sw];
    assign hsync_out = hsync_mux[sw];
    assign vsync_out = vsync_mux[sw];
    
endmodule
