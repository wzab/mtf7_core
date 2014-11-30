#should be always present after control FPGA is configured
create_clock -period 25.000 -name clk40_in [get_ports clk40_in]
#LHC clock
create_clock -period 25.000 -name lhc_clk [get_ports lhc_clk_p]
#generated in control FPGA
create_clock -period 8.000 -name clk_125M [get_ports clk_125M]
#Chip2Chip data clock
create_clock -period 2.500 -name ext_clk_in [get_ports ext_clk_in]
#GTH sync clock
create_clock -period 1.563 -name gt_sync_clk [get_ports gth_refclk_sync_p[0]]

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]



set_property MARK_DEBUG true [get_nets {m_axi_awaddr[2]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[6]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[11]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[22]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[7]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[28]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[30]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[31]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[4]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[19]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[29]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[21]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[15]}]
set_property MARK_DEBUG true [get_nets {m_axi_arlen[1]}]
set_property MARK_DEBUG true [get_nets {m_axi_awlen[4]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[18]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[9]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[17]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[22]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[1]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[25]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[31]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[13]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[6]}]
set_property MARK_DEBUG true [get_nets {m_axi_arlen[4]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[26]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[4]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[19]}]
set_property MARK_DEBUG true [get_nets {m_axi_arlen[6]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[7]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[16]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[0]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[11]}]
set_property MARK_DEBUG true [get_nets {m_axi_arlen[0]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[25]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[28]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[26]}]
set_property MARK_DEBUG true [get_nets {m_axi_awlen[0]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[30]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[15]}]
set_property MARK_DEBUG true [get_nets {m_axi_arlen[3]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[27]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[29]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[5]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[24]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[3]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[20]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[12]}]
set_property MARK_DEBUG true [get_nets {m_axi_awlen[7]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[20]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[14]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[0]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[5]}]
set_property MARK_DEBUG true [get_nets {m_axi_awlen[6]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[27]}]
set_property MARK_DEBUG true [get_nets {m_axi_arlen[7]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[23]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[3]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[14]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[9]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[13]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[18]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[2]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[8]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[24]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[8]}]
set_property MARK_DEBUG true [get_nets {m_axi_awlen[2]}]
set_property MARK_DEBUG true [get_nets {m_axi_awlen[5]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[23]}]
set_property MARK_DEBUG true [get_nets {m_axi_awlen[1]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[10]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[10]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[17]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[21]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[16]}]
set_property MARK_DEBUG true [get_nets {m_axi_arlen[2]}]
set_property MARK_DEBUG true [get_nets {m_axi_arlen[5]}]
set_property MARK_DEBUG true [get_nets {m_axi_araddr[12]}]
set_property MARK_DEBUG true [get_nets {m_axi_awlen[3]}]
set_property MARK_DEBUG true [get_nets {m_axi_awaddr[1]}]
set_property MARK_DEBUG true [get_nets m_axi_wvalid]
set_property MARK_DEBUG true [get_nets m_axi_rlast]
set_property MARK_DEBUG true [get_nets m_axi_awvalid]
set_property MARK_DEBUG true [get_nets m_axi_rvalid]
set_property MARK_DEBUG true [get_nets m_axi_wlast]
set_property MARK_DEBUG true [get_nets m_axi_rready]
set_property MARK_DEBUG true [get_nets m_axi_bready]
set_property MARK_DEBUG true [get_nets m_axi_wready]
set_property MARK_DEBUG true [get_nets m_axi_bvalid]
set_property MARK_DEBUG true [get_nets m_axi_arvalid]




create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 4 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER true [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 4096 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 1 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk40_out_OBUF]]
set_property port_width 32 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {m_axi_araddr[0]} {m_axi_araddr[1]} {m_axi_araddr[2]} {m_axi_araddr[3]} {m_axi_araddr[4]} {m_axi_araddr[5]} {m_axi_araddr[6]} {m_axi_araddr[7]} {m_axi_araddr[8]} {m_axi_araddr[9]} {m_axi_araddr[10]} {m_axi_araddr[11]} {m_axi_araddr[12]} {m_axi_araddr[13]} {m_axi_araddr[14]} {m_axi_araddr[15]} {m_axi_araddr[16]} {m_axi_araddr[17]} {m_axi_araddr[18]} {m_axi_araddr[19]} {m_axi_araddr[20]} {m_axi_araddr[21]} {m_axi_araddr[22]} {m_axi_araddr[23]} {m_axi_araddr[24]} {m_axi_araddr[25]} {m_axi_araddr[26]} {m_axi_araddr[27]} {m_axi_araddr[28]} {m_axi_araddr[29]} {m_axi_araddr[30]} {m_axi_araddr[31]}]]
create_debug_port u_ila_0 probe
set_property port_width 8 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {m_axi_arlen[0]} {m_axi_arlen[1]} {m_axi_arlen[2]} {m_axi_arlen[3]} {m_axi_arlen[4]} {m_axi_arlen[5]} {m_axi_arlen[6]} {m_axi_arlen[7]}]]
create_debug_port u_ila_0 probe
set_property port_width 8 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {m_axi_awlen[0]} {m_axi_awlen[1]} {m_axi_awlen[2]} {m_axi_awlen[3]} {m_axi_awlen[4]} {m_axi_awlen[5]} {m_axi_awlen[6]} {m_axi_awlen[7]}]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {ipb_sl2/ii_din_i[0]} {ipb_sl2/ii_din_i[1]} {ipb_sl2/ii_din_i[2]} {ipb_sl2/ii_din_i[3]} {ipb_sl2/ii_din_i[4]} {ipb_sl2/ii_din_i[5]} {ipb_sl2/ii_din_i[6]} {ipb_sl2/ii_din_i[7]} {ipb_sl2/ii_din_i[8]} {ipb_sl2/ii_din_i[9]} {ipb_sl2/ii_din_i[10]} {ipb_sl2/ii_din_i[11]} {ipb_sl2/ii_din_i[12]} {ipb_sl2/ii_din_i[13]} {ipb_sl2/ii_din_i[14]} {ipb_sl2/ii_din_i[15]} {ipb_sl2/ii_din_i[16]} {ipb_sl2/ii_din_i[17]} {ipb_sl2/ii_din_i[18]} {ipb_sl2/ii_din_i[19]} {ipb_sl2/ii_din_i[20]} {ipb_sl2/ii_din_i[21]} {ipb_sl2/ii_din_i[22]} {ipb_sl2/ii_din_i[23]} {ipb_sl2/ii_din_i[24]} {ipb_sl2/ii_din_i[25]} {ipb_sl2/ii_din_i[26]} {ipb_sl2/ii_din_i[27]} {ipb_sl2/ii_din_i[28]} {ipb_sl2/ii_din_i[29]} {ipb_sl2/ii_din_i[30]} {ipb_sl2/ii_din_i[31]}]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {ipb_sl2/ii_dout_i[0]} {ipb_sl2/ii_dout_i[1]} {ipb_sl2/ii_dout_i[2]} {ipb_sl2/ii_dout_i[3]} {ipb_sl2/ii_dout_i[4]} {ipb_sl2/ii_dout_i[5]} {ipb_sl2/ii_dout_i[6]} {ipb_sl2/ii_dout_i[7]} {ipb_sl2/ii_dout_i[8]} {ipb_sl2/ii_dout_i[9]} {ipb_sl2/ii_dout_i[10]} {ipb_sl2/ii_dout_i[11]} {ipb_sl2/ii_dout_i[12]} {ipb_sl2/ii_dout_i[13]} {ipb_sl2/ii_dout_i[14]} {ipb_sl2/ii_dout_i[15]} {ipb_sl2/ii_dout_i[16]} {ipb_sl2/ii_dout_i[17]} {ipb_sl2/ii_dout_i[18]} {ipb_sl2/ii_dout_i[19]} {ipb_sl2/ii_dout_i[20]} {ipb_sl2/ii_dout_i[21]} {ipb_sl2/ii_dout_i[22]} {ipb_sl2/ii_dout_i[23]} {ipb_sl2/ii_dout_i[24]} {ipb_sl2/ii_dout_i[25]} {ipb_sl2/ii_dout_i[26]} {ipb_sl2/ii_dout_i[27]} {ipb_sl2/ii_dout_i[28]} {ipb_sl2/ii_dout_i[29]} {ipb_sl2/ii_dout_i[30]} {ipb_sl2/ii_dout_i[31]}]]
create_debug_port u_ila_0 probe
set_property port_width 3 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {ipb_sl2/bus_state[0]} {ipb_sl2/bus_state[1]} {ipb_sl2/bus_state[2]}]]
create_debug_port u_ila_0 probe
set_property port_width 16 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {ipb_sl2/ii_addr_i[0]} {ipb_sl2/ii_addr_i[1]} {ipb_sl2/ii_addr_i[2]} {ipb_sl2/ii_addr_i[3]} {ipb_sl2/ii_addr_i[4]} {ipb_sl2/ii_addr_i[5]} {ipb_sl2/ii_addr_i[6]} {ipb_sl2/ii_addr_i[7]} {ipb_sl2/ii_addr_i[8]} {ipb_sl2/ii_addr_i[9]} {ipb_sl2/ii_addr_i[10]} {ipb_sl2/ii_addr_i[11]} {ipb_sl2/ii_addr_i[12]} {ipb_sl2/ii_addr_i[13]} {ipb_sl2/ii_addr_i[14]} {ipb_sl2/ii_addr_i[15]}]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {ipb_master_out[ipb_addr][0]} {ipb_master_out[ipb_addr][1]} {ipb_master_out[ipb_addr][2]} {ipb_master_out[ipb_addr][3]} {ipb_master_out[ipb_addr][4]} {ipb_master_out[ipb_addr][5]} {ipb_master_out[ipb_addr][6]} {ipb_master_out[ipb_addr][7]} {ipb_master_out[ipb_addr][8]} {ipb_master_out[ipb_addr][9]} {ipb_master_out[ipb_addr][10]} {ipb_master_out[ipb_addr][11]} {ipb_master_out[ipb_addr][12]} {ipb_master_out[ipb_addr][13]} {ipb_master_out[ipb_addr][14]} {ipb_master_out[ipb_addr][15]} {ipb_master_out[ipb_addr][16]} {ipb_master_out[ipb_addr][17]} {ipb_master_out[ipb_addr][18]} {ipb_master_out[ipb_addr][19]} {ipb_master_out[ipb_addr][20]} {ipb_master_out[ipb_addr][21]} {ipb_master_out[ipb_addr][22]} {ipb_master_out[ipb_addr][23]} {ipb_master_out[ipb_addr][24]} {ipb_master_out[ipb_addr][25]} {ipb_master_out[ipb_addr][26]} {ipb_master_out[ipb_addr][27]} {ipb_master_out[ipb_addr][28]} {ipb_master_out[ipb_addr][29]} {ipb_master_out[ipb_addr][30]} {ipb_master_out[ipb_addr][31]}]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {ipb_master_out[ipb_wdata][0]} {ipb_master_out[ipb_wdata][1]} {ipb_master_out[ipb_wdata][2]} {ipb_master_out[ipb_wdata][3]} {ipb_master_out[ipb_wdata][4]} {ipb_master_out[ipb_wdata][5]} {ipb_master_out[ipb_wdata][6]} {ipb_master_out[ipb_wdata][7]} {ipb_master_out[ipb_wdata][8]} {ipb_master_out[ipb_wdata][9]} {ipb_master_out[ipb_wdata][10]} {ipb_master_out[ipb_wdata][11]} {ipb_master_out[ipb_wdata][12]} {ipb_master_out[ipb_wdata][13]} {ipb_master_out[ipb_wdata][14]} {ipb_master_out[ipb_wdata][15]} {ipb_master_out[ipb_wdata][16]} {ipb_master_out[ipb_wdata][17]} {ipb_master_out[ipb_wdata][18]} {ipb_master_out[ipb_wdata][19]} {ipb_master_out[ipb_wdata][20]} {ipb_master_out[ipb_wdata][21]} {ipb_master_out[ipb_wdata][22]} {ipb_master_out[ipb_wdata][23]} {ipb_master_out[ipb_wdata][24]} {ipb_master_out[ipb_wdata][25]} {ipb_master_out[ipb_wdata][26]} {ipb_master_out[ipb_wdata][27]} {ipb_master_out[ipb_wdata][28]} {ipb_master_out[ipb_wdata][29]} {ipb_master_out[ipb_wdata][30]} {ipb_master_out[ipb_wdata][31]}]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {m_axi_awaddr[0]} {m_axi_awaddr[1]} {m_axi_awaddr[2]} {m_axi_awaddr[3]} {m_axi_awaddr[4]} {m_axi_awaddr[5]} {m_axi_awaddr[6]} {m_axi_awaddr[7]} {m_axi_awaddr[8]} {m_axi_awaddr[9]} {m_axi_awaddr[10]} {m_axi_awaddr[11]} {m_axi_awaddr[12]} {m_axi_awaddr[13]} {m_axi_awaddr[14]} {m_axi_awaddr[15]} {m_axi_awaddr[16]} {m_axi_awaddr[17]} {m_axi_awaddr[18]} {m_axi_awaddr[19]} {m_axi_awaddr[20]} {m_axi_awaddr[21]} {m_axi_awaddr[22]} {m_axi_awaddr[23]} {m_axi_awaddr[24]} {m_axi_awaddr[25]} {m_axi_awaddr[26]} {m_axi_awaddr[27]} {m_axi_awaddr[28]} {m_axi_awaddr[29]} {m_axi_awaddr[30]} {m_axi_awaddr[31]}]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {ipb_master_in[ipb_rdata][0]} {ipb_master_in[ipb_rdata][1]} {ipb_master_in[ipb_rdata][2]} {ipb_master_in[ipb_rdata][3]} {ipb_master_in[ipb_rdata][4]} {ipb_master_in[ipb_rdata][5]} {ipb_master_in[ipb_rdata][6]} {ipb_master_in[ipb_rdata][7]} {ipb_master_in[ipb_rdata][8]} {ipb_master_in[ipb_rdata][9]} {ipb_master_in[ipb_rdata][10]} {ipb_master_in[ipb_rdata][11]} {ipb_master_in[ipb_rdata][12]} {ipb_master_in[ipb_rdata][13]} {ipb_master_in[ipb_rdata][14]} {ipb_master_in[ipb_rdata][15]} {ipb_master_in[ipb_rdata][16]} {ipb_master_in[ipb_rdata][17]} {ipb_master_in[ipb_rdata][18]} {ipb_master_in[ipb_rdata][19]} {ipb_master_in[ipb_rdata][20]} {ipb_master_in[ipb_rdata][21]} {ipb_master_in[ipb_rdata][22]} {ipb_master_in[ipb_rdata][23]} {ipb_master_in[ipb_rdata][24]} {ipb_master_in[ipb_rdata][25]} {ipb_master_in[ipb_rdata][26]} {ipb_master_in[ipb_rdata][27]} {ipb_master_in[ipb_rdata][28]} {ipb_master_in[ipb_rdata][29]} {ipb_master_in[ipb_rdata][30]} {ipb_master_in[ipb_rdata][31]}]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {axi_ipbus_bridge/addr[0]} {axi_ipbus_bridge/addr[1]} {axi_ipbus_bridge/addr[2]} {axi_ipbus_bridge/addr[3]} {axi_ipbus_bridge/addr[4]} {axi_ipbus_bridge/addr[5]} {axi_ipbus_bridge/addr[6]} {axi_ipbus_bridge/addr[7]} {axi_ipbus_bridge/addr[8]} {axi_ipbus_bridge/addr[9]} {axi_ipbus_bridge/addr[10]} {axi_ipbus_bridge/addr[11]} {axi_ipbus_bridge/addr[12]} {axi_ipbus_bridge/addr[13]} {axi_ipbus_bridge/addr[14]} {axi_ipbus_bridge/addr[15]} {axi_ipbus_bridge/addr[16]} {axi_ipbus_bridge/addr[17]} {axi_ipbus_bridge/addr[18]} {axi_ipbus_bridge/addr[19]} {axi_ipbus_bridge/addr[20]} {axi_ipbus_bridge/addr[21]} {axi_ipbus_bridge/addr[22]} {axi_ipbus_bridge/addr[23]} {axi_ipbus_bridge/addr[24]} {axi_ipbus_bridge/addr[25]} {axi_ipbus_bridge/addr[26]} {axi_ipbus_bridge/addr[27]} {axi_ipbus_bridge/addr[28]} {axi_ipbus_bridge/addr[29]} {axi_ipbus_bridge/addr[30]} {axi_ipbus_bridge/addr[31]}]]
create_debug_port u_ila_0 probe
set_property port_width 2 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list {axi_ipbus_bridge/bus_state[0]} {axi_ipbus_bridge/bus_state[1]}]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list axi_c2c_link_status]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list axi_c2c_multi_bit_error]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list ipb_sl2/ii_opern_i]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list ipb_sl2/ii_stroben_i]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list ipb_sl2/ii_writen_i]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list {ipb_master_in[ipb_ack]}]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list {ipb_master_in[ipb_err]}]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list {ipb_master_out[ipb_strobe]}]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list {ipb_master_out[ipb_write]}]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe22]
connect_debug_port u_ila_0/probe22 [get_nets [list m_axi_arvalid]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe23]
connect_debug_port u_ila_0/probe23 [get_nets [list m_axi_awvalid]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe24]
connect_debug_port u_ila_0/probe24 [get_nets [list m_axi_bready]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe25]
connect_debug_port u_ila_0/probe25 [get_nets [list m_axi_bvalid]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe26]
connect_debug_port u_ila_0/probe26 [get_nets [list m_axi_rlast]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe27]
connect_debug_port u_ila_0/probe27 [get_nets [list m_axi_rready]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe28]
connect_debug_port u_ila_0/probe28 [get_nets [list m_axi_rvalid]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe29]
connect_debug_port u_ila_0/probe29 [get_nets [list m_axi_wlast]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe30]
connect_debug_port u_ila_0/probe30 [get_nets [list m_axi_wready]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe31]
connect_debug_port u_ila_0/probe31 [get_nets [list m_axi_wvalid]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk40_out_OBUF]
