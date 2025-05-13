`ifndef SPI_UVC_AGENT_SV
`define SPI_UVC_AGENT_SV

class spi_uvc_agent extends uvm_agent;

  `uvm_component_utils(spi_uvc_agent)

  extern function new(string name, uvm_component parent);

  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass : spi_uvc_agent


function spi_uvc_agent::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


function void spi_uvc_agent::build_phase(uvm_phase phase);
endfunction : build_phase


function void spi_uvc_agent::connect_phase(uvm_phase phase);
endfunction : connect_phase

`endif // SPI_UVC_AGENT_SV