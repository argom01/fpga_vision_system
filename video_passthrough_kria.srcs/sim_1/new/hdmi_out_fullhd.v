`timescale 1ns / 1ps
module hdmi_out_full_hd
(
  input hdmi_clk,
  input hdmi_vs,
  input hdmi_de,
  input [31:0] hdmi_data,
  output [3:0] sw_out
);
//-----------------------------------------------
integer fm1=0;

reg [3:0] sw = 4'b0000;
assign sw_out = sw;

// TK invert du to Zybo
wire w_hdmi_vs_i = !hdmi_vs;
reg [7:0]vsc=8'h0;
reg vse=1;
//-----------------------------------------------
initial
begin
  //fm1 = $fopen("outA.ppm","wb");  
end
//-----------------------------------------------
always @(posedge hdmi_clk)
begin
  vse<=w_hdmi_vs_i;
  
  if((w_hdmi_vs_i==1'b0)&&(vse==1'b1))
  begin
    $fclose(fm1);
        sw <= sw + 1;

    //$stop;
  end
  
  if((w_hdmi_vs_i==1'b1)&&(vse==1'b0))
  begin
  
    fm1 = $fopen({"out_",vsc[5:0]/10+8'h30,vsc[5:0]%10+8'h30,".ppm"},"wb");

     $display("out%d.ppm saved",vsc);
     
     // Updated header to specify Full HD (1920x1080) resolution metadata
     $fwrite(fm1,"P6%c1920 1080%c255\n",10,10);
   

     vsc<=vsc+1;
  end else
  begin
    if(hdmi_de)
     begin
       //just for good debugging
       $fwrite(fm1,"%c",{hdmi_data[23:16]});
       $fwrite(fm1,"%c",{hdmi_data[15:8]});
       $fwrite(fm1,"%c",{hdmi_data[7:0]});
     end
  end
end
//-----------------------------------------------
endmodule