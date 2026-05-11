`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2026 08:45:04 PM
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
        input [12:0]a,
        input ce,
        input rst,
        input clk,
        
        output [20:0]y
    );
    
    wire [20:0] sum;
    reg [20:0] acc = 0;
    
    c_addsub_1 adder (
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
