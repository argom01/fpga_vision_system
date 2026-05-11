`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2026 10:00:03 PM
// Design Name: 
// Module Name: accumulate
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


module accumulate(
    input [11:0]a,
    input clk,
    input ce,
    input rst,
    
    output [30:0]y
    );
    
    wire [30:0] sum;
    reg [30:0] acc = 0;
    
    acc_adder adder (
        .A(a),
        .B(acc),
        .S(sum)
    );
    
    always @(posedge clk)
    begin
        if (rst) acc = 0;
        else if (ce) acc <= sum;
    end
    
    assign y = acc;
endmodule
