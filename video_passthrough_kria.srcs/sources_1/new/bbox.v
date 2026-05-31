`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2026 10:05:18 PM
// Design Name: 
// Module Name: bbox
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


module bbox #(
    parameter IMG_W = 64,
    parameter IMG_H = 64
)(
    input clk,
    input de,
    input hsync,
    input vsync,
    input mask,
    
    output [11:0] top,
    output [11:0] bottom,
    output [11:0] left,
    output [11:0] right
    );
    
    reg [11:0] x_pos = 0;
    reg [11:0] y_pos = 0;
    
    reg prev_vsync = 0;
    
    wire eof;
        
    reg inside_box = 0;
    
    reg [11:0] min_y = 0;
    reg [11:0] max_y = 0;
    reg [11:0] min_x = 0;
    reg [11:0] max_x = 0;
    
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
    
    always @(posedge clk) begin
        if (mask == 1'b1) begin
            if (!inside_box) begin
                min_y <= y_pos;
                min_x <= x_pos;
                inside_box <= 1'b1;
            end else begin
                if (x_pos >= max_x) max_x <= x_pos;
                if (y_pos >= max_y) max_y <= y_pos;
                if (x_pos <= min_x) min_x <= x_pos;
            end
        end      
    end
    
    assign eof = (prev_vsync == 1'b0 && vsync == 1'b1) ? 1'b1 : 1'b0;
    
    reg [11:0] top_reg;
    reg [11:0] bottom_reg;
    reg [11:0] left_reg;
    reg [11:0] right_reg;
    
    always @(posedge clk) begin
        if (eof) begin
            top_reg <= min_y;
            bottom_reg <= max_y;
            left_reg <= min_x;
            right_reg <= max_x;
            
            inside_box <= 0;
            min_x <= 0;
            max_x <= 0;
            min_y <= 0;
            max_y <= 0;
        end
    end
    
    assign top = top_reg;
    assign bottom = bottom_reg;
    assign left = left_reg;
    assign right = right_reg;
endmodule
