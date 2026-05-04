`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2026 11:16:57 PM
// Design Name: 
// Module Name: tb_rgb2ycbcr
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


module tb_rgb2ycbcr(

    );
    
    reg clk = 0;
    reg hsync = 0;
    reg vsync = 0;
    reg de = 0;
    
    reg [23:0] pixel_in;
    
    initial
    begin
        while(1)
        begin
            #4;
            de <= 1'b1;
            hsync <= 1'b1;
            pixel_in <= 24'b1100100111101011000010;
            #20;
            pixel_in <= 0;
            hsync <= 0;
            de <= 0;
        end
    end
    
    wire hsync_out;
    wire vsync_out;
    wire de_out;
    
    wire [23:0] pixel_out;
    
    rgb2ycbcr dut (
        .clk(clk),
        .hsync_in(hsync),
        .vsync_in(vsync),
        .de_in(de),
        .pixel_in(pixel_in),
        .hsync_out(hsync_out),
        .vsync_out(vsync_out),
        .de_out(de_out),
        .pixel_out(pixel_out)
        );
    
    initial 
    begin
        while(1)
        begin
            #1; clk = 1'b0;
            #1; clk = 1'b1;
        end
    end
    
endmodule
