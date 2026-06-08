`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/06/2026 01:26:24 PM
// Design Name: 
// Module Name: sobel_filter_0
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


module sobel_0 #(
    parameter H_SIZE = 83   
)(
    input clk,
    input hsync_in,
    input vsync_in,
    input de_in,
    input [23:0] pixel_in,
    
    output hsync_out,
    output vsync_out,
    output de_out,
    output [23:0] pixel_out
    );
    
    reg [26:0] D11, D12, D13;
    reg [26:0] D21, D22, D23;
    reg [26:0] D31, D32, D33;
    
    wire [15:0] FIFO1_L, FIFO1_H, FIFO2_L, FIFO2_H;
    
    delayLineBRAM_WP BRAM_FIFO1_LOW (
        .clk(clk),
        .rst(0),
        .ce(1),
        .din(D13[15:0]),
        .dout(FIFO1_L),
        .h_size(H_SIZE - 5)
        );
        
    delayLineBRAM_WP BRAM_FIFO1_HIGH (
        .clk(clk),
        .rst(0),
        .ce(1),
        .din({5'b0, D13[26:16]}),
        .dout(FIFO1_H),
        .h_size(H_SIZE - 5)
        );
        
    delayLineBRAM_WP BRAM_FIFO2_LOW (
        .clk(clk),
        .rst(0),
        .ce(1),
        .din(D23[15:0]),
        .dout(FIFO2_L),
        .h_size(H_SIZE - 5)
        );
        
    delayLineBRAM_WP BRAM_FIFO2_HIGH (
        .clk(clk),
        .rst(0),
        .ce(1),
        .din({5'b0, D23[26:16]}),
        .dout(FIFO2_H),
        .h_size(H_SIZE - 5)
        );
        
    wire [26:0] FIFO1 = {FIFO1_H[10:0], FIFO1_L};
    wire [26:0] FIFO2 = {FIFO2_H[10:0], FIFO2_L};
    
    wire signed [9:0] P1_0, P2_0, P3_0, P4_0, P5_0, P6_0, P7_0, P8_0, P9_0;
    assign P1_0 = ~{1'b0, 1'b0, D11[23:16]} + 1;
    assign P2_0 = ~{1'b0, D12[23:16], 1'b0} + 1;
    assign P3_0 = ~{1'b0, 1'b0, D13[23:16]} + 1;
    
    assign P4_0 = 10'b0;
    assign P5_0 = 10'b0;
    assign P6_0 = 10'b0;

    assign P7_0 = {1'b0, 1'b0, D31[23:16]};
    assign P8_0 = {1'b0, D32[23:16], 1'b0};
    assign P9_0 = {1'b0, 1'b0, D33[23:16]};
    
    wire signed [9:0] P1_90, P2_90, P3_90, P4_90, P5_90, P6_90, P7_90, P8_90, P9_90;
    
    assign P1_90 = ~{1'b0, 1'b0, D11[23:16]} + 1;
    assign P2_90 = 10'b0;
    assign P3_90 = {1'b0, 1'b0, D13[23:16]};
    
    assign P4_90 = ~{1'b0, D21[23:16], 1'b0} + 1;
    assign P5_90 = 10'b0;
    assign P6_90 = {1'b0, D23[23:16], 1'b0};
    
    assign P7_90 = ~{1'b0, 1'b0, D31[23:16]} + 1;
    assign P8_90 = 10'b0;
    assign P9_90 = {1'b0, 1'b0, D33[23:16]};
    
    reg signed [11:0] S1_0, S2_0, S3_0, S1_90, S2_90, S3_90;
    reg signed [11:0] sum_0, sum_90;
    
    always @(posedge clk) begin
        D11 <= {vsync_in, hsync_in, de_in, pixel_in};
        D12 <= D11; D13 <= D12;
        S1_0 <= P1_0 + P2_0 + P3_0;
        S1_90 <= P1_90 + P2_90 + P3_90;
 
        D21 <= FIFO1;
        D22 <= D21; D23 <= D22;
        S2_0 <= P4_0 + P5_0 + P6_0;
        S2_90 <= P4_90 + P5_90 + P6_90;

        D31 <= FIFO2;
        D32 <= D31; D33 <= D32;
        S3_0 <= P7_0 + P8_0 + P9_0;
        S3_90 <= P7_90 + P8_90 + P9_90;
        
        sum_0 <= S1_0 + S2_0 + S3_0;
        sum_90 <= S1_90 + S2_90 + S3_90;
    end
    
    wire context_valid = D11[24] & D12[24] & D13[24] &
                         D21[24] & D22[24] & D23[24] &
                         D31[24] & D32[24] & D33[24];
    wire [23:0] pixel_in_sync;
    
    delay_line # (
        .N(24),
        .DELAY(2)
        ) sync1 (
        .clk(clk),
        .ce(1),
        .in_data(D22[23:0]),
        .out_data(pixel_in_sync)
        );
        
    wire [11:0] sum_abs_0 = sum_0 >= 0 ? sum_0 : ~sum_0 + 1;
    wire [11:0] sum_abs_90 = sum_90 >= 0 ? sum_90 : ~sum_90 + 1;

    wire sum_bin_0 = sum_abs_0 >= 127 ? 1'b1 : 1'b0;
    wire sum_bin_90 = sum_abs_90 >= 127 ? 1'b1 : 1'b0;
    
    wire [23:0] pixel_new = {24{sum_bin_0 | sum_bin_90}};
    
    wire hsync_sync, vsync_sync, de_sync, context_valid_sync;
    
    delay_line # (
        .N(4),
        .DELAY(2)
        ) sync2 (
        .clk(clk),
        .ce(1),
        .in_data({D22[25], D22[26], D22[24], context_valid}),
        .out_data({hsync_sync, vsync_sync, de_sync, context_valid_sync})
        );
    
    assign hsync_out = hsync_sync;
    assign vsync_out = vsync_sync;
    assign de_out = de_sync;
    assign pixel_out = context_valid_sync ? pixel_new : pixel_in_sync;
endmodule
