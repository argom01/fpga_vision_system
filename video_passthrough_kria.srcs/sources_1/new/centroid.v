`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2026 10:31:46 AM
// Design Name: 
// Module Name: centroid
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


module centroid #(
    parameter IMG_W = 64,
    parameter IMG_H = 64
)(
    input clk,
    input de,
    input hsync,
    input vsync,
    input mask,
    
    output [11:0] centroid_x,
    output [11:0] centroid_y
    );
    
    reg [11:0] x_pos = 0;
    reg [11:0] y_pos = 0;
    
    reg prev_vsync = 0;
    
    wire eof;
    
    always @(posedge clk) begin
        prev_vsync <= vsync;
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
    
    assign eof = (prev_vsync == 1'b0 && vsync == 1'b1) ? 1'b1 : 1'b0;
    
    calc_avg calc_avg (
        .clk(clk),
        .x(x_pos),
        .y(y_pos),
        .ce(mask & de),
        .rst(eof),
        
        .x_avg(centroid_x),
        .y_avg(centroid_y)
        );
    
endmodule
