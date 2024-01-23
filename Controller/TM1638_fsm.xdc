#xc7a35ticsg324-1l

## This file is a general .xdc for the Arty A7-35 Rev. D and Rev. E
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports clk]
create_clock -period 10.000 -name clk_pin -waveform {0.000 5.000} -add [get_ports clk]

## Buttons
set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS33} [get_ports rst]

## Pmod Header JA
## pin6 (vcc) gnd .. pin1
##pin12(vcc) gnd .. pin 7
set_property -dict {PACKAGE_PIN G13 IOSTANDARD LVCMOS33} [get_ports dio]
set_property -dict {PACKAGE_PIN B11 IOSTANDARD LVCMOS33} [get_ports clk1]
set_property -dict {PACKAGE_PIN A11 IOSTANDARD LVCMOS33} [get_ports stb]
##set_property -dict { PACKAGE_PIN D12   IOSTANDARD LVCMOS33 } [get_ports { JA[3] }]; #IO_L6P_T0_15 Sch=ja[4]
##set_property -dict { PACKAGE_PIN D13   IOSTANDARD LVCMOS33 } [get_ports { JA[4] }]; #IO_L6N_T0_VREF_15 Sch=ja[7]
##set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS33 } [get_ports { JA[5] }]; #IO_L10P_T1_AD11P_15 Sch=ja[8]
##set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS33 } [get_ports { JA[6] }]; #IO_L10N_T1_AD11N_15 Sch=ja[9]
##set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { JA[7] }]; #IO_25_15 Sch=ja[10]







create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 4 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER true [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 131072 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 3 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {state[0]} {state[1]} {state[2]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 1 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list clk1_OBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 1 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list dio_OBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 1 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list stb_OBUF]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_IBUF_BUFG]
