create_clock -name clk -period 10 [get_ports clk]
set_input_delay 1 -clock clk [get_ports din]
set_output_delay 1 -clock clk [get_ports dout]
