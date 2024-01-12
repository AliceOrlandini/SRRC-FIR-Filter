

set_property IOSTANDARD LVCMOS33 [get_ports {x[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {x[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {x[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {x[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {x[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {x[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {x[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {x[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {x[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {x[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {x[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {x[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {x[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {x[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {x[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {x[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports enable]
set_property IOSTANDARD LVCMOS33 [get_ports resetn]

create_clock -period 31.000 -name FIR_Clock -waveform {0.000 15.500} [list [get_ports clk] [get_ports clk]]



