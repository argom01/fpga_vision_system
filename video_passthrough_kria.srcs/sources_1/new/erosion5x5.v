`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2026 04:25:42 AM
// Design Name: 
// Module Name: erosion5x5
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


module erosion5x5 # (
    parameter H_SIZE = 83   
)(
    input clk,
    input hsync_in,
    input vsync_in,
    input de_in,
    input mask,
    
    output hsync_out,
    output vsync_out,
    output de_out,
    output [23:0] pixel_out
    );
    
    reg [3:0] D11, D12, D13, D14, D15;
    reg [3:0] D21, D22, D23, D24, D25;
    reg [3:0] D31, D32, D33, D34, D35;
    reg [3:0] D41, D42, D43, D44, D45;
    reg [3:0] D51, D52, D53, D54, D55;
    
    wire [3:0] FIFO1, FIFO2, FIFO3, FIFO4;
    
    delayLineBRAM_WP BRAM_FIFO (
        .clk(clk),
        .rst(0),
        .ce(1),
        .din({D15, D25, D35, D45}),
        .dout({FIFO1, FIFO2, FIFO3, FIFO4}),
        .h_size(H_SIZE - 5)
        );
    
    reg min;
    
    always @(posedge clk) begin
        D11 <= {vsync_in, hsync_in, de_in, mask};
        D12 <= D11; D13 <= D12; D14 <= D13; D15 <= D14;
        
        D21 <= FIFO1;
        D22 <= D21; D23 <= D22; D24 <= D23; D25 <= D24;

        D31 <= FIFO2;
        D32 <= D31; D33 <= D32; D34 <= D33; D35 <= D34;
        
        D41 <= FIFO3;
        D42 <= D41; D43 <= D42; D44 <= D43; D45 <= D44;
        
        D51 <= FIFO4;
        D52 <= D51; D53 <= D52; D54 <= D53; D55 <= D54;
        
        min <= D11[0] & D12[0] & D13[0] & D14[0] & D15[0] &
               D21[0] & D22[0] & D23[0] & D24[0] & D25[0] &
               D31[0] & D32[0] & D33[0] & D34[0] & D35[0] &
               D41[0] & D42[0] & D43[0] & D44[0] & D45[0] &
               D51[0] & D52[0] & D53[0] & D54[0] & D55[0];
    end
    
    wire context_valid = D11[1] & D12[1] & D13[1] & D14[1] & D15[1] &
                     D21[1] & D22[1] & D23[1] & D24[1] & D25[1] &
                     D31[1] & D32[1] & D33[1] & D34[1] & D35[1] &
                     D41[1] & D42[1] & D43[1] & D44[1] & D45[1] &
                     D51[1] & D52[1] & D53[1] & D54[1] & D55[1];
    
    wire mask_new = min;
    
    wire hsync_sync, vsync_sync, de_sync, context_valid_sync;
    
    delay_line # (
        .N(4),
        .DELAY(1)
        ) sync (
        .clk(clk),
        .ce(1),
        .in_data({D33[2], D33[3], D33[1], context_valid}),
        .out_data({hsync_sync, vsync_sync, de_sync, context_valid_sync})
        );
    
    assign hsync_out = hsync_sync;
    assign vsync_out = vsync_sync;
    assign de_out = de_sync;
    assign pixel_out = context_valid_sync ? {24{mask_new}} : {24{1'b0}};
endmodule
