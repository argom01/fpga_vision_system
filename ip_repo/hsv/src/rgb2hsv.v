`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2026 10:13:58 PM
// Design Name: 
// Module Name: rgb2hsv
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


module rgb2hsv(
    input clk,
    input de_in,
    input hsync_in,
    input vsync_in,
    input [23:0]pixel_in,
    
    output de_out,
    output hsync_out,
    output vsync_out,
    output [23:0]pixel_out
    );
    
    wire [9:0] V;
    wire [9:0] S;
    wire [9:0] H;
    
    //normalize
    
    wire [15:0] R_div_output;
    wire R_scaled_ready;
    wire signed [9:0] R_scaled = {1'b0, R_div_output[8:0]};
    
    div_gen_0 R_div (
        .aclk(clk),
        .s_axis_divisor_tvalid(1),
        .s_axis_divisor_tdata(pixel_in[23:16]),
        .s_axis_dividend_tvalid(1),
        .s_axis_dividend_tdata(255),
        .m_axis_dout_tvalid(R_scaled_ready),
        .m_axis_dout_tdata(R_div_output)
        );
        
     wire [15:0] G_div_output;
     wire G_scaled_ready;
     wire signed [9:0] G_scaled = {1'b0, G_div_output[8:0]};
     
     div_gen_0 G_div (
        .aclk(clk),
        .s_axis_divisor_tvalid(1),
        .s_axis_divisor_tdata(pixel_in[15:8]),
        .s_axis_dividend_tvalid(1),
        .s_axis_dividend_tdata(255),
        .m_axis_dout_tvalid(G_scaled_ready),
        .m_axis_dout_tdata(G_div_output)
        );
        
    wire [15:0] B_div_output;
    wire B_scaled_ready;
    wire signed [9:0] B_scaled = {1'b0, B_div_output[8:0]};
    
    div_gen_0 B_div (
        .aclk(clk),
        .s_axis_divisor_tvalid(1),
        .s_axis_divisor_tdata(pixel_in[7:0]),
        .s_axis_dividend_tvalid(1),
        .s_axis_dividend_tdata(255),
        .m_axis_dout_tvalid(B_scaled_ready),
        .m_axis_dout_tdata(B_div_output)
        );
        
    //max value
    
    wire signed [9:0] max_val;
    wire [1:0] max_channel;
    
    rgb_max rgb_max (
        .clk(clk),
        .R(R_scaled),
        .G(G_scaled),
        .B(B_scaled),
        .max_val(max_val),
        .max_channel(max_channel)
        );
        
    assign V = max_val;
    
    //min value
    
    wire signed [9:0] min_val;
    
    rgb_min rgb_min (
        .clk(clk),
        .R(R_scaled),
        .G(G_scaled),
        .B(B_scaled),
        .min_val(min_val)
        );
    
    // S calculations
    
    wire signed [9:0] C;
        
    c_addsub_0 max_min_diff (
        .CLK(clk),
        .A(V),
        .B(min_val),
        .S(C)
        );
        
    wire signed [9:0] V_delayed;
    
    delay_line # (
        .N(10),
        .DELAY(2)
    ) V_delay (
        .clk(clk),
        .ce(1),
        .in_data(V),
        .out_data(V_delayed)
    );
    
    wire signed [31:0] C_div_V;
    wire C_div_V_ready;
    
    div_gen_2 C_div (
        .aclk(clk),
        .s_axis_divisor_tvalid(1),
        .s_axis_divisor_tdata({V_delayed[9], 6'd0, V_delayed[8:0]}),
        .s_axis_dividend_tvalid(1),
        .s_axis_dividend_tdata({C[9], 6'd0, C[8:0]}),
        .m_axis_dout_tvalid(C_div_V_ready),
        .m_axis_dout_tdata(C_div_V)
    );
    
    assign S = (V_delayed > 0) ? {C_div_V[31], C_div_V[10:2]} : 10'd0;
    
    // H calculations
    
    wire signed [9:0] GB_diff;
    wire signed [9:0] BR_diff;
    wire signed [9:0] RG_diff;
    
    wire signed [9:0] RGB_mux [2:0];
    assign RGB_mux[0] = GB_diff;
    assign RGB_mux[1] = BR_diff;
    assign RGB_mux[2] = RG_diff;
    
    c_addsub_0 GB_sub (
        .CLK(clk),
        .A(G_scaled),
        .B(B_scaled),
        .S(GB_diff)
        );
        
    c_addsub_0 BR_sub (
        .CLK(clk),
        .A(B_scaled),
        .B(R_scaled),
        .S(BR_diff)
        );
    
    c_addsub_0 RG_sub (
        .CLK(clk),
        .A(R_scaled),
        .B(G_scaled),
        .S(RG_diff)
        );
        
    wire signed [9:0] RGB_mux_del [2:0];
        
    delay_line # (
        .N(30),
        .DELAY(1)
        ) RGB_delay (
        .clk(clk),
        .ce(1),
        .in_data({RGB_mux[0], RGB_mux[1], RGB_mux[2]}),
        .out_data({RGB_mux_del[0], RGB_mux_del[1], RGB_mux_del[2]})
        );
        
    wire [1:0] max_channel_del_1;
    
    delay_line # (
        .N(2),
        .DELAY(2)
        ) chann_del1 (
        .clk(clk),
        .ce(1),
        .in_data(max_channel),
        .out_data(max_channel_del_1)
        );
        
    wire signed [31:0] RGB_div_out;
    wire RGB_div_ready;
        
    div_gen_2 RGB_div (
        .aclk(clk),
        .s_axis_divisor_tvalid(1),
        .s_axis_divisor_tdata({C[9], 6'd0, C[8:0]}),
        .s_axis_dividend_tvalid(1),
        .s_axis_dividend_tdata({RGB_mux_del[max_channel_del_1][9], 6'd0, RGB_mux_del[max_channel_del_1][8:0]}),
        .m_axis_dout_tvalid(RGB_div_ready),
        .m_axis_dout_tdata(RGB_div_out)
        );
     
    wire signed [15:0] H_1;
    
    mult_gen_0 mult_60 (
        .CLK(clk),
        .A({RGB_div_out[31], RGB_div_out[10:2]}),
        .P(H_1)
        );
        
    wire [1:0] max_channel_del_2;
    
    delay_line # (
        .N(2),
        .DELAY(17)
        ) max_chann_del2 (
        .clk(clk),
        .ce(1),
        .in_data(max_channel_del_1),
        .out_data(max_channel_del_2)
        );
        
    wire signed [17:0] H_2;
    wire [7:0] H_to_add [2:0];
    assign H_to_add[0] = 8'd0;
    assign H_to_add[1] = 8'd120;
    assign H_to_add[2] = 8'd240;
    
    c_addsub_1 H_add (
        .CLK(clk),
        .A(H_1),
        .B({H_to_add[max_channel_del_2], 8'd0}),
        .S(H_2)
        );
        
    wire signed [17:0] H_3;
    
    c_addsub_2 H_add_360 (
        .CLK(clk),
        .A(H_2),
        .S(H_3)
        );
        
    wire signed [17:0] H2_delayed;
        
    delay_line # (
        .N(18),
        .DELAY(2)
        ) H2_delay (
        .clk(clk),
        .ce(1),
        .in_data(H_2),
        .out_data(H2_delayed)
        );
        
    wire H_pos_div_ready;
    wire [17:0] H_pos;
    assign H_pos = (H2_delayed < 0) ? H_3 : H2_delayed;
    
    wire signed [31:0] H_div_out;
        
    div_gen_1 H_360_div (
        .aclk(clk),
        .s_axis_divisor_tvalid(1),
        .s_axis_divisor_tdata(360),
        .s_axis_dividend_tvalid(1),
        .s_axis_dividend_tdata({H_pos[17], 6'd0, H_pos[16:0]}),
        .m_axis_dout_tvalid(H_pos_div_ready),
        .m_axis_dout_tdata(H_div_out)
        );
    
    assign H = {H_div_out[31], H_div_out[8:0]};
    
    wire signed [9:0] S_sync;
    wire signed [9:0] V_sync;
    
    delay_line # (
        .N(10),
        .DELAY(35)
        ) delay_S (
        .clk(clk),
        .ce(1),
        .in_data(S),
        .out_data(S_sync)
        );
        
    delay_line # (
        .N(10),
        .DELAY(51)
        ) delay_V (
        .clk(clk),
        .ce(1),
        .in_data(V),
        .out_data(V_sync)
        );
    
    wire signed [17:0] H_scaled;
    wire signed [17:0] S_scaled;
    wire signed [17:0] V_scaled;
    
    mult_gen_1 H_scale (
        .CLK(clk),
        .A(H),
        .P(H_scaled)
        );
        
    mult_gen_1 S_scale (
        .CLK(clk),
        .A(S_sync),
        .P(S_scaled)
        );
        
    mult_gen_1 V_scale (
        .CLK(clk),
        .A(V_sync),
        .P(V_scaled)
        );
        
    assign pixel_out = {H_scaled[15:8], S_scaled[15:8], V_scaled[15:8]};
    
    // sync signals delay
    
    delay_line # (
        .N(3),
        .DELAY(70)
        ) sync_delay (
        .clk(clk),
        .ce(1),
        .in_data({de_in, hsync_in, vsync_in}),
        .out_data({de_out, hsync_out, vsync_out})
        );
    
endmodule
