# This XDC is used only for OOC mode of synthesis, implementation
# User should update the correct clock period before proceeding further
create_clock -name m_aclk -period 10 -waveform {0 5} [get_ports m_aclk]
set_property HD.CLK_SRC BUFGCTRL_X0Y0 [get_ports m_aclk]
create_clock -name axi_c2c_selio_rx_clk_in -period 2.500 -waveform {0  1.250} [get_ports axi_c2c_selio_rx_clk_in]
create_clock -name idelay_ref_clk -period 5 [get_ports idelay_ref_clk]
set_property HD.CLK_SRC BUFGCTRL_X0Y3 [get_ports idelay_ref_clk]
