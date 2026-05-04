`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2026 11:45:54 AM
// Design Name: 
// Module Name: rgb_min
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


module rgb_min(
    input clk,
    
    input [9:0] R,
    input [9:0] G,
    input [9:0] B,
    
    output [9:0] min_val
    );
    
    reg [9:0] min_val_r;
    
    always @(posedge clk) begin
        if (R < G) begin
            if (R < B) begin
                min_val_r <= R;
            end
            else begin
                min_val_r <= B;
            end
        end
        else begin
            if (G < B) begin
                min_val_r <= G;
            end
            else begin
                min_val_r <= B;
            end
        end           
    end
    
    assign min_val = min_val_r;
endmodule
