###############################################################################
# Created by write_sdc
# Mon Feb 16 00:25:36 2026
###############################################################################
current_design FIFO
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 10.0000 [get_ports {clk}]
set_clock_transition 0.1500 [get_clocks {clk}]
set_clock_uncertainty 0.2500 clk
set_propagated_clock [get_clocks {clk}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {din[0]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {din[1]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {din[2]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {din[3]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {din[4]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {din[5]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {din[6]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {din[7]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rd_en}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {reset_n}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {wr_en}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {dout[0]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {dout[1]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {dout[2]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {dout[3]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {dout[4]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {dout[5]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {dout[6]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {dout[7]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {empty}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {full}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {empty}]
set_load -pin_load 0.0334 [get_ports {full}]
set_load -pin_load 0.0334 [get_ports {dout[7]}]
set_load -pin_load 0.0334 [get_ports {dout[6]}]
set_load -pin_load 0.0334 [get_ports {dout[5]}]
set_load -pin_load 0.0334 [get_ports {dout[4]}]
set_load -pin_load 0.0334 [get_ports {dout[3]}]
set_load -pin_load 0.0334 [get_ports {dout[2]}]
set_load -pin_load 0.0334 [get_ports {dout[1]}]
set_load -pin_load 0.0334 [get_ports {dout[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {clk}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {rd_en}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reset_n}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wr_en}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {din[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {din[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {din[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {din[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {din[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {din[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {din[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {din[0]}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_transition 0.7500 [current_design]
set_max_fanout 10.0000 [current_design]
