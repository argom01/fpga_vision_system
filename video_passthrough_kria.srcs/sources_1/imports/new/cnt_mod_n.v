`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2026 10:18:39 PM
// Design Name: 
// Module Name: cnt_mod_n
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


module cnt_mod_n # (
    parameter N = 10,
    parameter WIDTH = $clog2(N)
)
(
    input clk,
    input ce,
    input rst,
    output [WIDTH - 1:0]cnt
);

reg [WIDTH - 1:0]val = 0;

always @(posedge clk)
begin
    if (rst) val <= 0;
    else if (ce)
    begin
        if (cnt == N - 1)
            val <= 0;
        else
            val <= val + 1;
    end
        
    else val <= val;
end

assign cnt = val;

endmodule
