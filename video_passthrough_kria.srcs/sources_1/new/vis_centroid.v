`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2026 10:57:47 PM
// Design Name: 
// Module Name: vis_centroid
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


module vis_centroid(
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
    localparam IMG_H = 12'd60;
    localparam IMG_W = 12'd60;
    
    reg [11:0] x_pos = 0;
    reg [11:0] y_pos = 0;
    
    reg de_reg;
    reg hsync_reg;
    reg vsync_reg;
    
    always @(posedge clk) begin
        de_reg <= de;
        hsync_reg <= hsync;
        vsync_reg <= vsync;
    
        if (vsync == 1) begin
            x_pos <= 0;
            y_pos <= 0;
        end
        else if (de == 1) x_pos <= x_pos + 1;
        
        if (x_pos >= IMG_W - 1) begin
            x_pos <= 0;
            y_pos <= y_pos + 1;
        end
        
        if (y_pos >= IMG_H - 1) y_pos <= 0;
    end
    
    assign pixel_out = ((x_pos == x) || (y_pos == y)) ? {8'hff, 8'h00, 8'h00} : pixel_in;
    assign de_out = de_reg;
    assign hsync_out = hsync_reg;
    assign vsync_out = vsync_reg;
endmodule
