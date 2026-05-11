`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2026 09:04:02 PM
// Design Name: 
// Module Name: cnt
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


module cnt
(
    input clk,
    input ce,
    input rst,
    output [20:0]cnt
);

reg [20:0]val = 0;

always @(posedge clk)
begin
    if (rst) val <= 0;
    else if (ce) val <= val + 1;
    else val <= val;
end

assign cnt = val;

endmodule
