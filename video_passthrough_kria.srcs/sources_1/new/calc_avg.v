`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2026 09:24:00 PM
// Design Name: 
// Module Name: calc_avg
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


module calc_avg(
    input clk,
    input [11:0]x,
    input [11:0]y,
    input ce,
    input rst,
    
    output [11:0]x_avg,
    output [11:0]y_avg
    );
    
    wire [20:0] m00;
    wire [30:0] m01;
    wire [30:0] m10;

    cnt m00_cnt (
        .clk(clk),
        .ce(ce),
        .rst(rst),
        .cnt(m00)
        );
        
    accumulate m10_acc (
        .clk(clk),
        .ce(ce),
        .rst(rst),
        .a(x),
        .y(m10)
        );
        
    accumulate m01_acc (
        .clk(clk),
        .ce(ce),
        .rst(rst),
        .a(y),
        .y(m01)
        );
        
    wire [31:0] x_div_out;
    wire x_ready;
        
    divider_32_21_0 div_x (
        .clk(clk),
        .start(rst),
        .dividend({1'b0, m10}),
        .divisor(m00),
        .quotient(x_div_out),
        .qv(x_ready)
        );
        
    wire [31:0] y_div_out;
    wire y_ready;
        
    divider_32_21_0 div_y (
        .clk(clk),
        .start(rst),
        .dividend({1'b0, m01}),
        .divisor(m00),
        .quotient(y_div_out),
        .qv(y_ready)
        );
        
    reg [11:0] x_reg;
    reg [11:0] y_reg;
        
    always @(posedge clk) begin
        if (x_ready) begin 
            x_reg <= x_div_out[11:0];
        end;
        if (y_ready) y_reg <= y_div_out[11:0];
    end
    
    assign x_avg = x_reg;
    assign y_avg = y_reg;
endmodule
