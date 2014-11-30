### Bank 0 voltage selector ###
set_property CFGBVS GND [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]

# CNT<71>
set_property PACKAGE_PIN AU25 [get_ports clk_125M]
set_property IOSTANDARD LVCMOS12 [get_ports clk_125M]

set_property PACKAGE_PIN AU18 [get_ports clk40_in]
set_property IOSTANDARD LVCMOS12 [get_ports clk40_in]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk40_in]

# must go to clock pin on core FPGA
# CNT<73>
set_property PACKAGE_PIN BB23 [get_ports ext_clk_out]
set_property IOSTANDARD LVCMOS12 [get_ports ext_clk_out]
set_property DRIVE 8 [get_ports ext_clk_out]
set_property SLEW FAST [get_ports ext_clk_out]

set_property PACKAGE_PIN AV27 [get_ports lhc_clk_p]
set_property IOSTANDARD LVDS [get_ports lhc_clk_p]
set_property PACKAGE_PIN AV28 [get_ports lhc_clk_n]
set_property IOSTANDARD LVDS [get_ports lhc_clk_n]
set_property PACKAGE_PIN AW30 [get_ports ttc_data_p]
set_property IOSTANDARD LVDS [get_ports ttc_data_p]
set_property PACKAGE_PIN AW31 [get_ports ttc_data_n]
set_property IOSTANDARD LVDS [get_ports ttc_data_n]

# must be a clock pin
# CNT<99>
set_property PACKAGE_PIN AT21 [get_ports ext_clk_in]
set_property IOSTANDARD LVCMOS12 [get_ports ext_clk_in]
# CNT<86>
set_property PACKAGE_PIN AW24 [get_ports {ext_data_out[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_out[0]}]
set_property DRIVE 8 [get_ports {ext_data_out[0]}]
set_property SLEW FAST [get_ports {ext_data_out[0]}]
# CNT<87>
set_property PACKAGE_PIN AR22 [get_ports {ext_data_out[1]}]
set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_out[1]}]
set_property DRIVE 8 [get_ports {ext_data_out[1]}]
set_property SLEW FAST [get_ports {ext_data_out[1]}]
# CNT<88>
set_property PACKAGE_PIN AV23 [get_ports {ext_data_out[2]}]
set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_out[2]}]
set_property DRIVE 8 [get_ports {ext_data_out[2]}]
set_property SLEW FAST [get_ports {ext_data_out[2]}]
# CNT<89>
set_property PACKAGE_PIN BA20 [get_ports {ext_data_out[3]}]
set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_out[3]}]
set_property DRIVE 8 [get_ports {ext_data_out[3]}]
set_property SLEW FAST [get_ports {ext_data_out[3]}]
# CNT<90>
set_property PACKAGE_PIN BB22 [get_ports {ext_data_out[4]}]
set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_out[4]}]
set_property DRIVE 8 [get_ports {ext_data_out[4]}]
set_property SLEW FAST [get_ports {ext_data_out[4]}]
# CNT<91>
set_property PACKAGE_PIN AY18 [get_ports {ext_data_out[5]}]
set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_out[5]}]
set_property DRIVE 8 [get_ports {ext_data_out[5]}]
set_property SLEW FAST [get_ports {ext_data_out[5]}]
# CNT<92>
set_property PACKAGE_PIN AW19 [get_ports {ext_data_out[6]}]
set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_out[6]}]
set_property DRIVE 8 [get_ports {ext_data_out[6]}]
set_property SLEW FAST [get_ports {ext_data_out[6]}]
# CNT<93>
set_property PACKAGE_PIN BA21 [get_ports {ext_data_out[7]}]
set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_out[7]}]
set_property DRIVE 8 [get_ports {ext_data_out[7]}]
set_property SLEW FAST [get_ports {ext_data_out[7]}]
# CNT<94>
set_property PACKAGE_PIN AY23 [get_ports {ext_data_out[8]}]
set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_out[8]}]
set_property DRIVE 8 [get_ports {ext_data_out[8]}]
set_property SLEW FAST [get_ports {ext_data_out[8]}]
# CNT<95>
#set_property PACKAGE_PIN AV22 [get_ports {ext_data_out[9]}]
#set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_out[9]}]
#set_property DRIVE 8 [get_ports {ext_data_out[9]}]
#set_property SLEW FAST [get_ports {ext_data_out[9]}]
## CNT<96>
#set_property PACKAGE_PIN AY19 [get_ports {ext_data_out[10]}]
#set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_out[10]}]
#set_property DRIVE 8 [get_ports {ext_data_out[10]}]
#set_property SLEW FAST [get_ports {ext_data_out[10]}]
## CNT<97>
#set_property PACKAGE_PIN AY21 [get_ports {ext_data_out[11]}]
#set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_out[11]}]
#set_property DRIVE 8 [get_ports {ext_data_out[11]}]
#set_property SLEW FAST [get_ports {ext_data_out[11]}]
## CNT<98>
#set_property PACKAGE_PIN AW20 [get_ports {ext_data_out[12]}]
#set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_out[12]}]
#set_property DRIVE 8 [get_ports {ext_data_out[12]}]
#set_property SLEW FAST [get_ports {ext_data_out[12]}]
## CNT<68>
#set_property PACKAGE_PIN AU21 [get_ports {ext_data_out[13]}]
#set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_out[13]}]
#set_property DRIVE 8 [get_ports {ext_data_out[13]}]
#set_property SLEW FAST [get_ports {ext_data_out[13]}]

# CNT<67>
#set_property PACKAGE_PIN AW21 [get_ports core_phase_inc]
#set_property IOSTANDARD LVCMOS12 [get_ports core_phase_inc]

# CNT<72>
set_property PACKAGE_PIN BA25 [get_ports {ext_data_in[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_in[0]}]
# CNT<74>
set_property PACKAGE_PIN AY24 [get_ports {ext_data_in[1]}]
set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_in[1]}]
# CNT<75>
set_property PACKAGE_PIN AU23 [get_ports {ext_data_in[2]}]
set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_in[2]}]
# CNT<76>
set_property PACKAGE_PIN AU22 [get_ports {ext_data_in[3]}]
set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_in[3]}]
# CNT<77>
set_property PACKAGE_PIN AW25 [get_ports {ext_data_in[4]}]
set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_in[4]}]
# CNT<78>
set_property PACKAGE_PIN AW26 [get_ports {ext_data_in[5]}]
set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_in[5]}]
# CNT<79>
set_property PACKAGE_PIN BD26 [get_ports {ext_data_in[6]}]
set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_in[6]}]
# CNT<80>
set_property PACKAGE_PIN BC25 [get_ports {ext_data_in[7]}]
set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_in[7]}]
# CNT<81>
set_property PACKAGE_PIN AT23 [get_ports {ext_data_in[8]}]
set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_in[8]}]
## CNT<82>
#set_property PACKAGE_PIN AW22 [get_ports {ext_data_in[9]}]
#set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_in[9]}]
## CNT<83>
#set_property PACKAGE_PIN AU26 [get_ports {ext_data_in[10]}]
#set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_in[10]}]
## CNT<84>
#set_property PACKAGE_PIN AU27 [get_ports {ext_data_in[11]}]
#set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_in[11]}]
## CNT<85>
#set_property PACKAGE_PIN AN23 [get_ports {ext_data_in[12]}]
#set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_in[12]}]
## CNT<69>
#set_property PACKAGE_PIN BC23 [get_ports {ext_data_in[13]}]
#set_property IOSTANDARD LVCMOS12 [get_ports {ext_data_in[13]}]

### GTH clocking ports ###
set_property PACKAGE_PIN BB8 [get_ports gth_refclk_sync_p[0]]
set_property PACKAGE_PIN BB7 [get_ports gth_refclk_sync_n[0]]
set_property PACKAGE_PIN AH8 [get_ports gth_refclk_sync_p[1]]
set_property PACKAGE_PIN AH7 [get_ports gth_refclk_sync_n[1]]
set_property PACKAGE_PIN R10 [get_ports gth_refclk_sync_p[2]]
set_property PACKAGE_PIN R9 [get_ports gth_refclk_sync_n[2]]
set_property PACKAGE_PIN G10 [get_ports gth_refclk_sync_p[3]]
set_property PACKAGE_PIN G9 [get_ports gth_refclk_sync_n[3]]
set_property PACKAGE_PIN AT37 [get_ports gth_refclk_sync_p[4]]
set_property PACKAGE_PIN AT38 [get_ports gth_refclk_sync_n[4]]
set_property PACKAGE_PIN AH37 [get_ports gth_refclk_sync_p[5]]
set_property PACKAGE_PIN AH38 [get_ports gth_refclk_sync_n[5]]

### GTH transceiver ports ###
# It shouldn't be necessary to specify all pins. Placement of only one rx/tx pair
#constrains the whole quad and all it's inputs
#GTH 111
set_property PACKAGE_PIN AV8 [get_ports gth_rxp[0]]
set_property PACKAGE_PIN AV7 [get_ports gth_rxn[0]]
set_property PACKAGE_PIN AU6 [get_ports gth_rxp[1]]
set_property PACKAGE_PIN AU5 [get_ports gth_rxn[1]]
set_property PACKAGE_PIN AR6 [get_ports gth_rxp[2]]
set_property PACKAGE_PIN AR5 [get_ports gth_rxn[2]]
set_property PACKAGE_PIN AP8 [get_ports gth_rxp[3]]
set_property PACKAGE_PIN AP7 [get_ports gth_rxn[3]]
#GTH 112
set_property PACKAGE_PIN AN6 [get_ports gth_rxp[4]]
set_property PACKAGE_PIN AN5 [get_ports gth_rxn[4]]
set_property PACKAGE_PIN AM4 [get_ports gth_rxp[5]]
set_property PACKAGE_PIN AM3 [get_ports gth_rxn[5]]
set_property PACKAGE_PIN AM8 [get_ports gth_rxp[6]]
set_property PACKAGE_PIN AM7 [get_ports gth_rxn[6]]
set_property PACKAGE_PIN AL6 [get_ports gth_rxp[7]]
set_property PACKAGE_PIN AL5 [get_ports gth_rxn[7]]
#GTH 113
set_property PACKAGE_PIN AK8 [get_ports gth_rxp[8]]
set_property PACKAGE_PIN AK7 [get_ports gth_rxn[8]]
set_property PACKAGE_PIN AJ6 [get_ports gth_rxp[9]]
set_property PACKAGE_PIN AJ5 [get_ports gth_rxn[9]]
set_property PACKAGE_PIN AG6 [get_ports gth_rxp[10]]
set_property PACKAGE_PIN AG5 [get_ports gth_rxn[10]]
set_property PACKAGE_PIN AE6 [get_ports gth_rxp[11]]
set_property PACKAGE_PIN AE5 [get_ports gth_rxn[11]]
#GTH 211
set_property PACKAGE_PIN AV37 [get_ports gth_rxp[12]]
set_property PACKAGE_PIN AV38 [get_ports gth_rxn[12]]
set_property PACKAGE_PIN AU39 [get_ports gth_rxp[13]]
set_property PACKAGE_PIN AU40 [get_ports gth_rxn[13]]
set_property PACKAGE_PIN AR39 [get_ports gth_rxp[14]]
set_property PACKAGE_PIN AR40 [get_ports gth_rxn[14]]
set_property PACKAGE_PIN AP37 [get_ports gth_rxp[15]]
set_property PACKAGE_PIN AP38 [get_ports gth_rxn[15]]
#GTH 212
set_property PACKAGE_PIN AN39 [get_ports gth_rxp[16]]
set_property PACKAGE_PIN AN40 [get_ports gth_rxn[16]]
set_property PACKAGE_PIN AM41 [get_ports gth_rxp[17]]
set_property PACKAGE_PIN AM42 [get_ports gth_rxn[17]]
set_property PACKAGE_PIN AM37 [get_ports gth_rxp[18]]
set_property PACKAGE_PIN AM38 [get_ports gth_rxn[18]]
set_property PACKAGE_PIN AL39 [get_ports gth_rxp[19]]
set_property PACKAGE_PIN AL40 [get_ports gth_rxn[19]]
#GTH 213
set_property PACKAGE_PIN AK37 [get_ports gth_rxp[20]]
set_property PACKAGE_PIN AK38 [get_ports gth_rxn[20]]
set_property PACKAGE_PIN AJ39 [get_ports gth_rxp[21]]
set_property PACKAGE_PIN AJ40 [get_ports gth_rxn[21]]
set_property PACKAGE_PIN AG39 [get_ports gth_rxp[22]]
set_property PACKAGE_PIN AG40 [get_ports gth_rxn[22]]
set_property PACKAGE_PIN AE39 [get_ports gth_rxp[23]]
set_property PACKAGE_PIN AE40 [get_ports gth_rxn[23]]

# CNT<70>
set_property PACKAGE_PIN BA24 [get_ports m_aresetn]
set_property IOSTANDARD LVCMOS12 [get_ports m_aresetn]

set_property PACKAGE_PIN AK29 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[0]}]

set_property PACKAGE_PIN AL28 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[1]}]

set_property PACKAGE_PIN AL29 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[2]}]

set_property PACKAGE_PIN AR27 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[3]}]
#OSY
set_property PACKAGE_PIN AM27 [get_ports clk40_out]
set_property IOSTANDARD LVCMOS18 [get_ports clk40_out]
#WOF
set_property PACKAGE_PIN AK28 [get_ports clk200_out]
set_property IOSTANDARD LVCMOS18 [get_ports clk200_out]
#RDY
#set_property PACKAGE_PIN AM28 [get_ports clk125_out]
#set_property IOSTANDARD LVCMOS18 [get_ports clk125_out]

