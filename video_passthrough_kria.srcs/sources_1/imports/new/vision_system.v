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
    
    localparam Ta = 8'd77;
    localparam Tb = 8'd127;
    localparam Tc = 8'd133;
    localparam Td = 8'd173;
    
    wire [7:0] Cb = rgb_mux[3][15:8];
    wire [7:0] Cr = rgb_mux[3][7:0];
    
    assign ycbcr_bin = (Cb > Ta && Cb < Tb && Cr > Tc && Cr < Td) ? 1 : 0;
    
    assign rgb_mux[4] = {24{ycbcr_bin}};
    assign de_mux[4] = de_mux[3];
    assign hsync_mux[4] = hsync_mux[3];
    assign vsync_mux[4] = vsync_mux[3];
    
    //output
    
    assign pixel_out = rgb_mux[sw];
    assign de_out = de_mux[sw];
    assign hsync_out = hsync_mux[sw];
    assign vsync_out = vsync_mux[sw];
    
endmodule
