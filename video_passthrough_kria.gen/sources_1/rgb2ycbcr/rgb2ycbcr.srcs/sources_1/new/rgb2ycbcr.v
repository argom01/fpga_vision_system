`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2026 09:59:00 AM
// Design Name: 
// Module Name: rgb2ycbcr
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


module rgb2ycbcr(
    input clk,
    
    input hsync_in,
    input vsync_in,
    input de_in,
    
    input [23:0]pixel_in,
    
    output hsync_out,
    output vsync_out,
    output de_out,
    
    output [23:0]pixel_out
    );
    
    wire signed [17:0] YR_coef = 18'b001001100100010111;
    wire signed [17:0] YG_coef = 18'b010010110010001011;
    wire signed [17:0] YB_coef = 18'b000011101001011110;
    
    wire signed [17:0] CbR_coef = 18'b111010100110011011;
    wire signed [17:0] CbG_coef = 18'b110101011001100101;
    wire signed [17:0] CbB_coef = 18'b010000000000000000;
    
    wire signed [17:0] CrR_coef = 18'b010000000000000000;
    wire signed [17:0] CrG_coef = 18'b110010100110100010;
    wire signed [17:0] CrB_coef = 18'b111101011001011110;
    
    wire signed [17:0] R = {10'd0, pixel_in[23:16]};
    wire signed [17:0] G = {10'd0, pixel_in[15:8]};
    wire signed [17:0] B = {10'd0, pixel_in[7:0]};
    
    wire signed [35:0] YR_out;
    wire signed [35:0] YG_out;
    wire signed [35:0] YB_out;

    mult_gen_0 mult_YR (
        .CLK(clk),
        .A(R),
        .B(YR_coef),
        .P(YR_out)
        );
        
    mult_gen_0 mult_YG (
        .CLK(clk),
        .A(G),
        .B(YG_coef),
        .P(YG_out)
        );
        
    mult_gen_0 mult_YB (
        .CLK(clk),
        .A(B),
        .B(YB_coef),
        .P(YB_out)
        );
        
    wire signed [35:0] CbR_out;
    wire signed [35:0] CbG_out;
    wire signed [35:0] CbB_out;

    mult_gen_0 mult_CbR (
        .CLK(clk),
        .A(R),
        .B(CbR_coef),
        .P(CbR_out)
        );
        
    mult_gen_0 mult_CbG (
        .CLK(clk),
        .A(G),
        .B(CbG_coef),
        .P(CbG_out)
        );
    
    mult_gen_0 mult_CbB (
        .CLK(clk),
        .A(B),
        .B(CbB_coef),
        .P(CbB_out)
        );
        
    wire signed [35:0] CrR_out;
    wire signed [35:0] CrG_out;
    wire signed [35:0] CrB_out;
        
    mult_gen_0 mult_CrR (
        .CLK(clk),
        .A(R),
        .B(CrR_coef),
        .P(CrR_out)
        );
        
    mult_gen_0 mult_CrG (
        .CLK(clk),
        .A(G),
        .B(CrG_coef),
        .P(CrG_out)
        );
        
    mult_gen_0 mult_CrB (
        .CLK(clk),
        .A(B),
        .B(CrB_coef),
        .P(CrB_out)
        );
        
    wire signed [35:0] YB_out_delay;
    
    delay_line # (
        .N(36),
        .DELAY(2)
        ) YB_delay 
        (
        .clk(clk),
        .ce(1),
        .in_data(YB_out),
        .out_data(YB_out_delay)
        );
        
    wire signed [8:0] Y_out1;
    wire signed [8:0] Y_out2;
    wire signed [8:0] Y;
        
    c_addsub_0 add_Y1 (
        .CLK(clk),
        .A({YR_out[35], YR_out[24:17]}),
        .B({YG_out[35], YG_out[24:17]}),
        .S(Y_out1)
        );
    
    c_addsub_0 add_Y2 (
        .CLK(clk),
        .A(Y_out1),
        .B({YB_out_delay[35], YB_out_delay[24:17]}),
        .S(Y_out2)
        );
        
    c_addsub_0 add_Y3 (
        .CLK(clk),
        .A(Y_out2),
        .B(0),
        .S(Y)
        );
        
    wire signed [35:0] CbB_out_delay;
    
    delay_line # (
        .N(36),
        .DELAY(2)
        ) CbB_delay (
        .clk(clk),
        .ce(1),
        .in_data(CbB_out),
        .out_data(CbB_out_delay)
        );
        
    wire signed [8:0] Cb_out1;
    wire signed [8:0] Cb_out2;
    wire signed [8:0] Cb;
    
    c_addsub_0 add_Cb1 (
        .CLK(clk),
        .A({CbR_out[35], CbR_out[24:17]}),
        .B({CbG_out[35], CbG_out[24:17]}),
        .S(Cb_out1)
        );
    
    c_addsub_0 add_Cb2 (
        .CLK(clk),
        .A(Cb_out1),
        .B({CbB_out_delay[35], CbB_out_delay[24:17]}),
        .S(Cb_out2)
        );
        
    c_addsub_0 add_Cb3 (
        .CLK(clk),
        .A(Cb_out2),
        .B(128),
        .S(Cb)
        );
        
    wire signed [35:0] CrB_out_delay;
    
    delay_line # (
        .N(36),
        .DELAY(2)
        ) CrB_delay (
        .clk(clk),
        .ce(1),
        .in_data(CrB_out),
        .out_data(CrB_out_delay)
        );
        
    wire signed [8:0] Cr_out1;
    wire signed [8:0] Cr_out2;
    wire signed [8:0] Cr;
        
    c_addsub_0 add_Cr1 (
        .CLK(clk),
        .A({CrR_out[35], CrR_out[24:17]}),
        .B({CrG_out[35], CrG_out[24:17]}),
        .S(Cr_out1)
        );
        
    c_addsub_0 add_Cr2 (
        .CLK(clk),
        .A(Cr_out1),
        .B({CrB_out_delay[35], CrB_out_delay[24:17]}),
        .S(Cr_out2)
        );
        
    c_addsub_0 add_Cr3 (
        .CLK(clk),
        .A(Cr_out2),
        .B(128),
        .S(Cr)
        );
    
    assign pixel_out = {Y[7:0], Cb[7:0], Cr[7:0]};
    
    delay_line # (
        .N(3),
        .DELAY(9)
        ) sync_delay (
        .clk(clk),
        .ce(1),
        .in_data({hsync_in, vsync_in, de_in}),
        .out_data({hsync_out, vsync_out, de_out})
        );
        
endmodule
