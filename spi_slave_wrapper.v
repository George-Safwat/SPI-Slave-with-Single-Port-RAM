module spi_wrapper(MOSI,MISO,SS_n,clk,rst_n);
input MOSI,clk,rst_n,SS_n;
output MISO;

wire [9:0] rx_data;
wire rx_valid;
wire tx_valid;
wire [7:0] tx_data;

spi spi1(.MOSI(MOSI),.MISO(MISO),.clk(clk), .SS_n(SS_n),
 .rst_n(rst_n), .rx_valid(rx_valid), .tx_valid(tx_valid),
  .rx_data(rx_data), .tx_data(tx_data));

ram #(.MEM_DEPTH(256), .ADDR_SIZE(8)) ram1(.din(rx_data), 
.rx_valid(rx_valid), .tx_valid(tx_valid), 
.clk(clk), .rst_n(rst_n), .dout(tx_data));



endmodule