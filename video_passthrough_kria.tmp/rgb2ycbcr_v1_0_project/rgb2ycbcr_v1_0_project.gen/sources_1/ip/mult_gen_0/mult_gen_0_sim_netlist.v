// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Tue Apr 21 10:16:24 2026
// Host        : DESKTOP-I43IRA7 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top mult_gen_0 -prefix
//               mult_gen_0_ mult_gen_0_sim_netlist.v
// Design      : mult_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010iclg225-1L
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mult_gen_0,mult_gen_v12_0_18,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_18,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module mult_gen_0
   (CLK,
    A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:b_intf:a_intf, ASSOCIATED_RESET sclr, ASSOCIATED_CLKEN ce, FREQ_HZ 10000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [17:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [17:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [35:0]P;

  wire [17:0]A;
  wire [17:0]B;
  wire CLK;
  wire [35:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "18" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "3" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "35" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  mult_gen_0_mult_gen_v12_0_18 U0
       (.A(A),
        .B(B),
        .CE(1'b1),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
C/5Mh/YfQK+xvzcE2CGtETuPBeLiyJko5tNa9mMrxf8GTM/0mqqMZ+vYDutRWwlkGLoBJ0ubJ2JM
hSYnF9uwe22zt9N5LFdSRZxMoN1o6c2PdIJyFX9QiG+G0k5olg9eEzsigfNpc9kE5brQ+zVlZ0BV
klXrD05hnhWq+ZJys/w=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
nhu9PWmxjSOqIMDTXJV+4qo0FPiBJCygcWuN/bfQzqY2oUKKM8378Fb2UT55vg8n4G10m17vIBgN
+Wy6buZC7GhxULhm+9qKdG61k/7yfhvEyQUBzudlOBUaIUk7ZAeE6SGH26C8h1WgBFSBJBshielG
kmSnefelvtJmMqQynpqanYQE+2/nM45zHVEXMtgEl8NM+ittmjnbmsjMG+VmkcpjTiitr8v+SSgM
RUwmbOuITmj1SaUWkm+IJTDW4bnipSqF0iXScNDVurlEpJm4oLvKdM1ottYIIcXR6+Fa5dGLRubI
LjYe8sQ49kCgXyYdFk4JbJANd3OdYx/U0839pw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
oLOGB6O+5m7WVYa3aB6L+szJIkfErI3K6c0Z4Xd6Cc9YLnPbUoTR/E3N7bfACANo1RtCR1KrgOT9
QRzSpMaWuUNpHkoBWkpOvvqpujGg7n+KNjtsXpeAJDMZq0hpkCFMyTIbglQJfVL4ds7LBIztVpT+
XPSPp0rHN6MvUs/o0sQ=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
b3H7uIeGCIVDgn3FEC671rtMncRXCjR9RBfw6OuWzlyF5wFk4ElX2tB2gwrWUb2Com7mmOGUcT8m
dWBnb4fgFyaI4CcP0cDJZ1RBfKHzHsnVnUtydmh17jwFjOhuG4oqUfxDBVOziYixuf8xqsPD1kIx
AAGgp8eCh/3TTWsXe8MqUHFhWLAFBHiM+g9tiFtJxHBAyX5v+8avU7rSRQOteILiCl/aE/ZTg1U1
TZRYZm9xCtpTek8kcIXycf8cf1vmkeYfjYqsPcKnLXjswHKcSvCTgJBvdf6/NU1hADbYz5krZkN6
cP43YF8Es6pXZ5MZxRyvAulHMEmC1vBKEV4L2Q==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
hNojWTRiv5xJXFjSuajQtOI6VJWjSVIasMceSy/iOADWwlykMyPQqJwBZv9vgyG2lsbPzupIZZOt
sY4+VQKC49eSzzBiqlXJuuRgTh4eG5Sj78MJPFi8Z4JHdANbBDjcsfEyFcFinPG8C+6ObqSWv3sT
fh66lPvK05YKvRong1DaI4yDI+LeF0XCXF9jXawejRWPqZyQQRofEUn3P6/HL3rOQ9WrwtOgLOh4
eld6oolD6hKjdN6z7BtfypoG1+c9GyXB8peQYSYy2mC/UhPM2He7IScIeEh8FKNZOETke8ShtPdd
8KijcT3YF0mZbR+JEAYmPRwljDtmkR1nmLPJ5g==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
vNoNhNOiLgedrjzCipcIWa66MfCSJrQLJjludHrumavTx1oA+4ROcs5sx9EIY16AxVabVb6PSj/B
6g7QMmhWOHO5XWCGsLGngpWlMaz7FPJIrMDMH0FqHULVZgn+ytshKF3OiHU9DKUfGAkx2o6xKR8J
v2jv+NfcjYrjtp1y5L007VCIwcNtkKJJXaDQjJxbYYOB0uzxwQIXRo+SEib+esXDvZD6Ikc55nl4
wE0bh+voYoBpOgDoGMiOgpg8YJnYWFS+aCT4aHJqb0+12fK4HJHyN34p2V9mna/PBHxQttZEjbwL
t5GBDgl9IiQOzvoyMMwa3D9yJPGWNEJTOJaUbw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
UWO1yL0EL8CXhMsuZN3v7pq9vqI3Hx8I4AdpxQRWS35PlhqAcAjYeBVG9msiPa5PzWiULLQfpvtc
jErP46XJGtGsEiYBMIv0Sy4sw0m1buhgPQC3ebkJgAk3bspWMUEsvYaN1IfFXabxN+RYANz3tJ2Y
oHgpnvvpm8OrlQUsgkwwn7FgVUGvBHoaj3vopWTMROl61+OL1aj+VLKQvwlZuA30e5yG7JAT159Y
e+xbMUxDz+W4RK0kPzZxnlU6X2HGieEEqGVzuAHvbaqUsRHZF294LqHX4u2WuTM74rvH69Kh5wL6
jYEYgCU9ma4gBAA98slrAnjNqn4bY2f9DG+now==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
iXm1XonW4ervg3D4DUJphNzJ6vN12GMfC70OgzuNrZ2kX9fFpWbL5IBPnCTMNnNWQy0GGe6hvPmb
j7EpeR3MIhJR5BcSdHMR4BVvSo0AEM+UmieNsuTc7dTw++8EucnKuLvloLldJo1b29DO+LZfqkGP
M9z2zkXfSVOqQRNGzxLR5gGJLHNfjxGz8MOIJ3HaDDAbO1eEgkWN9ZeesYwJrgERNSubcEhjLzl8
dVi5A1iTEa6WcsQ7XpUZkZTrHlM+/ZUnuZelrt2eHwx7m5XAZzHXbVz6YPrxLVx80IcJzqkykiEp
dMotGjzHWB0+tNy/gRFTUB5rpFt3LtF2+O9mZEf4nNluB9zmYqmvU9T4zeiID3NuEe4WOZjruJ0Q
gBPt5imaHECnAFxZ7QWVRp1rGkX8eS8I5qjfVJm8+pKqvjc1MGkAv2Vh4RG+n36yShUI44QIDYIY
zqj5fbexc27+CEmjJEFy/Cwik0yDg15IXyQYIkVLbBBdXfuQsGR6lI0A

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
e2TCE/IVroj0BoMutEWWgUoHdqmqHN4Vq1aGvl8tHLqPMgKPyusaF/EU/+MvsIWjDyZip1MmWOcx
jQu5Oy8IWt51LTRIQJ0x+kU2WDMNmZRHSdVAR8ORyzaV+63xJ+1FR21OuVBTsdN0zc5+xPOZn251
Ih7Dkw8u+guep7Yr4t3jgw+4crsiBVVM+5WJvUb5HgZZLCirWswHL2EOSwrlxmh1UfYzXoib6RPE
Ra/hqZSom0279kPBw6Fx+riPQZSw7jyFJal9sJMpp1RQHG0wo0DgA0V8Ot4NHxUc9Fwq4+hnCyfi
r2lvbn1yjpQbLFKBIZrlQAud1cQVbPc9abtdFA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
L3JaekweMV7T3i7w9Lp3aAisO3hLjJKyBciT4Bqv1xuU397SQW9MELMslHwUBa+w26Re+czGYbTN
RZjQztPZoq2krxlAE0qzjFPyQ/6OT56MvkuX3NUcYo5HcJ8VWlL7JyR0fahwzKZVa3sLagWn7ZcQ
gXA8rIf4FBsdZpcW8JlTN8+NS44wC8QgwzXHjJrAYvIAueIhTTuQqp7x6OzG9D6Td+JHFSPRxhuP
L/DQF4XPjt9IThgTmuDLHAFn6DvVtOlByDWlhsK8Cl46cYLf/q0PG/HJmY0D/A7dkhyNanf8zSSR
svj99MW64FLr/HSZ88xCQkUcnLqD1HJMWtIGTA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
KvlISYBvWjebqE6V2K0JGHiH3/sv/QeFu6HoKOqfqctZsjV5sat2n+kAjj+td3ghpu6WZ2ZWqOQ8
X7uZz5mHJtIll89mV+1WRL9pMwi7ffX3oOigbtkXw+b2JLixh0ybuC0p1q+5xjyjmt4CCZaUTRPv
IjXJcpZudAcc4cHIW9koj3wdemcWgcjHFHLbjSKvEKspFYfcgLwjHQ4XYq0xksVrbogpW7Y7agJL
I1H18g98/cgzSmw3G9p9iw8x1kq8fPVd67fDymoxyol7CbNqyxqbvH/MNj/c61zKUqbAle1qJyu+
DvcWhjqvwS1sOQ0nGbrL1zIge74L8sXJ7R/b6w==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 10944)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
