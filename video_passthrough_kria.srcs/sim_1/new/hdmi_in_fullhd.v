`timescale 1ns / 1ps
module hdmi_in_full_hd
(
  //hdmi outputs
  output reg hdmi_clk,
  output hdmi_de,
  output hdmi_hs,
  output hdmi_vs,
  //image data
  output [7:0]hdmi_r,
  output [7:0]hdmi_g,
  output [7:0]hdmi_b
); 
//-----------------------------------------------
// Standard Full HD 1920x1080 @ 60Hz Timing
  //horizontal
  parameter hr=1920; //resolution
  parameter hbp=148; //back porch
  parameter hfp=88;  //front porch
  parameter hs=44;   //sync len
  //vertical
  parameter vr=1080; //resolution
  parameter vbp=36;  //back porch
  parameter vfp=4;   //front porch
  parameter vs=5;    //sync len
//-----------------------------------------------
  reg line=1'b0;
  reg vsync=1'b1;
  reg hsync=1'b1;
  reg enab=1'b0;
  reg eenab=1'b0;
  reg h_enable=1'b0;
  reg v_enable=1'b0;
  
  // Expanded counters to 12 bits to handle maximum target values (2200 and 1125)
  reg [11:0]hcounter=0;
  reg [11:0]vcounter=1080+1; // vr + 1
//-----------------------------------------------
  reg [7:0]red;
  reg [7:0]green;
  reg [7:0]blue;
  
//-----------------------------------------------
initial
begin
  while(1)
  begin
    #1 hdmi_clk=1'b0;
    #1 hdmi_clk=1'b1;
  end
end  
//-----------------------------------------------
integer rgbfile,i,v,clo,cle,wl,x;
reg [7:0] char_header;
integer space_count;

//-----------------------------------------------
always @(posedge hdmi_clk)
begin
  hcounter<=hcounter+1;
  
  eenab<=enab;

  if(hcounter==(hr+hbp)) begin
    hsync<=1'b0;
  end
  if(hcounter==(hr+hbp+hs)) begin
    hsync<=1'b1;
    line<=1'b0;
  end

  if(hcounter<hr) 
      h_enable<=1'b1;
  else 
        h_enable<=1'b0;
  
  if(vcounter<vr) 
        v_enable<=1'b1;
  else 
        v_enable<=1'b0;
        
  if((v_enable==1'b1)&&(h_enable==1'b1))
        enab<=1'b1;
  else 
        enab<=1'b0;
                
  if(hcounter==(hr+hbp+hs+hfp)) 
  begin
    hcounter<=0;
    line<=1'b1;
  end
end
//-----------------------------------------------
//TB only

always @(posedge hdmi_clk)
begin
  if(enab)
  begin
    red<=$fgetc(rgbfile);
    green<=$fgetc(rgbfile);
    blue<=$fgetc(rgbfile);
  end
end
//TB end
//-----------------------------------------------
reg [7:0]vsc=0;

always @(posedge line)
begin
  vcounter<=vcounter+1;
  if(vcounter==(vr+vbp))
  begin  
    vsync<=1'b0;
    //TB only
    vsc=vsc+1;

    rgbfile = $fopen("C:/Users/hhhh/rekonfigi/video_passthrough_kria/dlon2_fhd.ppm","rb");

    // Dynamic PPM Header Parser:
    // PPM headers (P6\nWidth Height\nMaxVal\n) have 3 whitespace breaks before binary data.
    // This dynamically reads characters until it safely skips the header info.
    space_count = 0;
    while (space_count < 3) begin
      char_header = $fgetc(rgbfile);
      // Check for space (8'h20), carriage return (8'h0D), or newline (8'h0A)
      if (char_header == 8'h20 || char_header == 8'h0A || char_header == 8'h0D) begin
        space_count = space_count + 1;
      end
    end
    //TB end
  end
  if(vcounter==(vr+vbp+vs)) vsync<=1'b1;
  if(vcounter==(vr+vbp+vs+vfp)) vcounter<=0;
end
//-----------------------------------------------

assign hdmi_r=red;
assign hdmi_g=green;
assign hdmi_b=blue;

assign hdmi_de=eenab;
// +TK Changed to negative for Zybo
assign hdmi_hs=!hsync;
assign hdmi_vs=!vsync;
//-----------------------------------------------
endmodule