# Clock signal
set_property -dict { PACKAGE_PIN H16    IOSTANDARD LVCMOS33 } [get_ports { pin_sysclk }]; #IO_L13P_T2_MRCC_35 Sch=SYSCLK
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { pin_sysclk }];#set


##Pmod Header JA
#set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { ja_p[1] }]; #IO_L17P_T2_34 Sch=JA1_P
set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { pin_vga_red1 }]; #IO_L17N_T2_34 Sch=JA1_N
#set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports { ja_p[2] }]; #IO_L7P_T1_34 Sch=JA2_P
#set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { ja_n[2] }]; #IO_L7N_T1_34 Sch=JA2_N
#set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { ja_p[3] }]; #IO_L12P_T1_MRCC_34 Sch=JA3_P
set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports { pin_vga_blue1 }]; #IO_L12N_T1_MRCC_34 Sch=JA3_N
#set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { ja_p[4] }]; #IO_L22P_T3_34 Sch=JA4_P
#set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { ja_n[4] }]; #IO_L22N_T3_34 Sch=JA4_N

##Pmod Header JB
set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS33 } [get_ports { pin_vga_green1 }]; #IO_L8N_T1_34 Sch=JB1_N
#set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports { jb_p[1] }]; #IO_L8P_T1_34 Sch=JB1_P
#set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { jb_n[2] }]; #IO_L1N_T0_34 Sch=JB2_N
#set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { jb_p[2] }]; #IO_L1P_T0_34 Sch=JB2_P
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports { pin_vga_vsync_n }]; #IO_L18N_T2_34 Sch=JB3_N
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { pin_vga_hsync_n }]; #IO_L18P_T2_34 Sch=JB3_P
#set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { jb_n[4] }]; #IO_L4N_T0_34 Sch=JB4_N
#set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { jb_p[4] }]; #IO_L4P_T0_34 Sch=JB4_P


#ChipKit Digital I/O Low
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { pin_trig }]; #IO_L5P_T0_34 Sch=CK_IO0
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { pin_echo }]; #IO_L2N_T0_34 Sch=CK_IO1
set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports { servo_control }]; #IO_L3P_T0_DQS_PUDC_B_34 Sch=CK_IO2
set_property -dict { PACKAGE_PIN M20  IOSTANDARD LVCMOS33 } [get_ports { start }]; #IO_L7N_T1_AD2N_35 Sch=SW0
