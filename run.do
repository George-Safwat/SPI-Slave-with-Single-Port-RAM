vlib work
vlog spi.v ram.v spi_tb.v spi_slave_wrapper.v
vsim -voptargs=+acc work.spi_tb
add wave -position insertpoint  \
sim:/spi_tb/spi_wrapper1/spi1/MOSI \
sim:/spi_tb/spi_wrapper1/spi1/clk \
sim:/spi_tb/spi_wrapper1/spi1/rst_n \
sim:/spi_tb/spi_wrapper1/spi1/SS_n \
sim:/spi_tb/spi_wrapper1/spi1/MISO \
sim:/spi_tb/spi_wrapper1/spi1/rx_valid \
sim:/spi_tb/spi_wrapper1/spi1/rx_data \
sim:/spi_tb/spi_wrapper1/spi1/tx_valid \
sim:/spi_tb/spi_wrapper1/spi1/tx_data \
sim:/spi_tb/spi_wrapper1/spi1/counter_bits \
sim:/spi_tb/spi_wrapper1/spi1/data_out_counter \
sim:/spi_tb/spi_wrapper1/spi1/data_in_counter \
sim:/spi_tb/spi_wrapper1/spi1/cs \
sim:/spi_tb/spi_wrapper1/spi1/ns \
sim:/spi_tb/spi_wrapper1/ram1/din \
sim:/spi_tb/spi_wrapper1/ram1/clk \
sim:/spi_tb/spi_wrapper1/ram1/rst_n \
sim:/spi_tb/spi_wrapper1/ram1/rx_valid \
sim:/spi_tb/spi_wrapper1/ram1/tx_valid \
sim:/spi_tb/spi_wrapper1/ram1/dout \
sim:/spi_tb/spi_wrapper1/ram1/hold_wraddr \
sim:/spi_tb/spi_wrapper1/ram1/hold_rdaddr \
sim:/spi_tb/spi_wrapper1/ram1/mem
run -all

