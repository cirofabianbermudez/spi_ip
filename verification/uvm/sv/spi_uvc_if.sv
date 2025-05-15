`ifndef SPI_UVC_IF_SV
`define SPI_UVC_IF_SV

interface spi_uvc_if (
    input logic clk_i,
    input logic rst_i
);

  // SPI signals
  logic [7:0]  din_i;
  logic        start_i;
  logic [7:0]  dout_o;
  logic        spi_done_tick_o;
  logic        ready_o;
  logic        sclk_o;
  logic        miso_i;
  logic        mosi_o;
  
  // Default values
  initial begin
    din_i   = 'd0;
    start_i = 'd0;
    miso_i  = 'd0;
  end
  
  clocking cb_drv @(posedge clk_i);
    default output #2ns;
    output  din_i;
    output  start_i;
    output  miso_i;
  endclocking : cb_drv


  clocking cb_mon @(posedge clk_i);
    default input #1ns;
    input dout_o;
    input spi_done_tick_o;
    input ready_o;
    input sclk_o;
    input mosi_o;
    input miso_i;
  endclocking : cb_mon

endinterface : spi_uvc_if


`endif // SPI_UVC_IF_SV
