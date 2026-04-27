onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+lut_binary  -L xilinx_vip -L xpm -L dist_mem_gen_v8_0_13 -L xil_defaultlib -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.lut_binary xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure

do {lut_binary.udo}

run 1000ns

endsim

quit -force
