`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2026 11:45:54 AM
// Design Name: 
// Module Name: rgb_max
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


module rgb_max(
    input clk,
    
    input [9:0] R,
    input [9:0] G,
    input [9:0] B,
    
    output [9:0] max_val,
    output [1:0] max_channel
    );
    
    reg [9:0] max_val_r;
    reg [1:0] max_channel_r;
    
    always @(posedge clk) begin
        if (R > G) begin
            if (R > B) begin
                max_val_r <= R;
                max_channel_r <= 2'd0;
            end
            else begin
                max_val_r <= B;
                max_channel_r <= 2'd2;
            end
        end
        else begin
            if (G > B) begin
                max_val_r <= G;
                max_channel_r <= 2'd1;
            end
            else begin
                max_val_r <= B;
                max_channel_r <= 2'd2;
            end
        end           
    end
    
    assign max_val = max_val_r;
    assign max_channel = max_channel_r;
endmodule
