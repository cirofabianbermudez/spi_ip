`ifndef SPI_UVC_DRIVER_SV
`define SPI_UVC_DRIVER_SV

class spi_uvc_driver extends uvm_driver #(spi_uvc_sequence_item);

  `uvm_component_utils(spi_uvc_driver)

  virtual spi_uvc_if     vif;
  spi_uvc_config         m_config;

  extern function new(string name, uvm_component parent);

  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task do_drive();
  extern task cmd_read();
  extern task cmd_write();

endclass : spi_uvc_driver


function spi_uvc_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


function void spi_uvc_driver::build_phase(uvm_phase phase);
  if (!uvm_config_db#(virtual spi_uvc_if)::get(get_parent(), "", "vif", vif)) begin
    `uvm_fatal(get_name(), "Could not retrieve spi_uvc_if from config db")
  end

  if (!uvm_config_db#(spi_uvc_config)::get(get_parent(), "", "config", m_config)) begin
    `uvm_fatal(get_name(), "Could not retrieve spi_uvc_config from config db")
  end
endfunction : build_phase


task spi_uvc_driver::run_phase(uvm_phase phase);
  forever begin
    seq_item_port.get_next_item(req);
    do_drive();
    seq_item_port.item_done();
  end
endtask : run_phase


task spi_uvc_driver::cmd_write();
  @(vif.cb_drv);
  vif.cb_drv.din_i   <= req.m_data;
  vif.cb_drv.start_i <= 1'b1;
  @(vif.cb_drv);
  vif.cb_drv.start_i <= 1'b0;
endtask : cmd_write


task spi_uvc_driver::cmd_read();
  @(vif.cb_drv);
  vif.cb_drv.din_i   <= 'd0;
  vif.cb_drv.start_i <= 1'b1;
  @(vif.cb_drv);
  vif.cb_drv.start_i <= 1'b0;
endtask : cmd_read


task spi_uvc_driver::do_drive();
  `uvm_info(get_type_name(), {"\n ------ DRIVER (SPI UVC) ------", req.convert2string()}, UVM_DEBUG)
  if (req.m_cmd == SPI_UVC_WRITE) begin
    cmd_write();
  end else begin
    cmd_read();
  end

  // Wait for the end of the transaction
  wait (vif.spi_done_tick_o != 1);
  @(vif.cb_drv iff (vif.spi_done_tick_o == 1));
endtask : do_drive

`endif // SPI_UVC_DRIVER_SV
