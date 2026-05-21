`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2026 05:57:23 PM
// Design Name: 
// Module Name: vis_centroid_circle
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


module vis_centroid_circle # (
    parameter IMG_W = 64,
    parameter IMG_H = 64,
    parameter RADIUS_PX = 2
)(
    input clk,
    input de,
    input hsync,
    input vsync,
    input [23:0] pixel_in,
    
    input [11:0] x,
    input [11:0] y,
    
    output [23:0] pixel_out,
    output de_out,
    output hsync_out,
    output vsync_out
    );
    
    reg [11:0] x_pos = 0;
    reg [11:0] y_pos = 0;
    
    reg de_reg;
    reg hsync_reg;
    reg vsync_reg;
    reg [23:0] pixel_reg;
    
    always @(posedge clk) begin
        de_reg <= de;
        hsync_reg <= hsync;
        vsync_reg <= vsync;
    
        if (vsync == 1) begin
            x_pos <= 0;
            y_pos <= 0;
        end
        else if (de == 1) x_pos <= x_pos + 1;
        
        if (x_pos == IMG_W - 1) begin
            x_pos <= 0;
            y_pos <= y_pos + 1;
        end
        
        if (y_pos == IMG_H - 1) y_pos <= 0;
        
        pixel_reg <= (((x_pos - x) * (x_pos - x)) + ((y_pos - y) * (y_pos - y)) <= RADIUS_PX * RADIUS_PX) ? {8'hff, 8'h00, 8'h00} : pixel_in;
    end
    
    assign pixel_out = pixel_reg;
    assign de_out = de_reg;
    assign hsync_out = hsync_reg;
    assign vsync_out = vsync_reg;
endmodule
