`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2026 11:11:47 PM
// Design Name: 
// Module Name: preprocess
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


module preprocess(
    input [23:0]brg,
    output [23:0]rgb
    );
    
    assign rgb[23:8] = brg[15:0];
    assign rgb[7:0] = brg[23:16]; 
endmodule
