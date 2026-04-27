`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2026 01:02:52 PM
// Design Name: 
// Module Name: delay_line
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


module delay #
(
    parameter N = 4
)
(
    input clk,
    input ce,
    input [N-1:0]d,
    output [N-1:0]q
);
    reg [N-1:0]val=0;
    always @(posedge clk)
    begin
        if (ce) val <= d;
        else val<=val;
    end
    assign q=val;
    
endmodule

module delay_line #
(
    parameter N = 4,
    parameter DELAY = 4
)
(
    input clk,
    input ce,
    input [N-1:0]in_data,
    output [N-1:0]out_data
);
    
wire [N-1:0] t_data [DELAY:0];

assign t_data[0] = in_data;

genvar i;
generate
    if (DELAY == 0)
    begin
        assign out_data = in_data;
    end else
    for (i = 0; i < DELAY; i = i + 1)
    begin
        delay # (.N(N)) delay_i
        (
            .clk(clk),
            .ce(ce),
            .d(t_data[i]),
            .q(t_data[i + 1])
        );      
    end
endgenerate

assign out_data = t_data[DELAY];
endmodule
