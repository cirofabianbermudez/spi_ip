`ifndef SPI_UVC_IF_SV
`define SPI_UVC_IF_SV

interface spi_uvc_if (
    input logic clk_i
);

  import spi_uvc_pkg::*;

  // SPI signals
  logic [7:0]  din_i;
  logic        start_i;
  logic [7:0]  dout_o;
  logic        spi_done_tick_o;
  logic        ready_o;
  logic        sclk_o;
  logic        mosi_o;

  // Drive by the slave
  logic        miso_i;
  
  clocking cb_drv @(posedge clk_i);
    default input #1ns output #5ns;
    output  din_i;
    output  start_i;
  endclocking : cb_drv


  clocking cb_mon @(posedge clk_i);
    default input #1ns output #5ns;
    input dout_o;
    input spi_done_tick_o;
    input ready_o;
    input sclk_o;
    input mosi_o;
    input miso_i;
  endclocking : cb_mon

  // Default values
  initial begin
    din_i   = 'd0;
    start_i = 'd0;
  end

endinterface : spi_uvc_if


`endif // SPI_UVC_IF_SV
