`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2026 11:55:00 PM
// Design Name: 
// Module Name: postprocess
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


module postprocess(
    input [23:0]rgb,
    output [35:0]brg
    );
    
    assign brg[35:0] = {rgb[7:0], 4'b0000, rgb[23:16], 4'b0000, rgb[15:8], 4'b0000};
endmodule
