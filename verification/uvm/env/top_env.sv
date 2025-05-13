`ifndef TOP_ENV_SV
`define TOP_ENV_SV

class top_env extends uvm_env;

  `uvm_component_utils(top_env)
  
  spi_uvc_agent  m_spi_agent;

  extern function new(string name, uvm_component parent);

  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass : top_env


function top_env::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


function void top_env::build_phase(uvm_phase phase);
  m_spi_agent = spi_uvc_agent::type_id::create("m_spi_agent", this);
endfunction : build_phase


function void top_env::connect_phase(uvm_phase phase);
endfunction : connect_phase


`endif // TOP_ENV_SV
