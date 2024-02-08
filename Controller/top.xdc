## Clock signal
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

## Buttons
#set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS33} [get_ports rst]
set_property -dict {PACKAGE_PIN D9 IOSTANDARD LVCMOS33} [get_ports rst]

## LEDs
set_property -dict {PACKAGE_PIN H5 IOSTANDARD LVCMOS33} [get_ports en_set]

## Pmod Header JA
set_property -dict {PACKAGE_PIN G13 IOSTANDARD LVCMOS33} [get_ports dio]
set_property -dict {PACKAGE_PIN B11 IOSTANDARD LVCMOS33} [get_ports clk1]
set_property -dict {PACKAGE_PIN A11 IOSTANDARD LVCMOS33} [get_ports stb]
set_property -dict {PACKAGE_PIN D12 IOSTANDARD LVCMOS33} [get_ports data]


