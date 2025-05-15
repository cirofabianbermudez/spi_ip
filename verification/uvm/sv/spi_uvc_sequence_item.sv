`ifndef SPI_UVC_SEQUENCE_ITEM_SV
`define SPI_UVC_SEQUENCE_ITEM_SV

class spi_uvc_sequence_item extends uvm_sequence_item;

  `uvm_object_utils(spi_uvc_sequence_item)
  
  // Transaction variables
  rand byte           m_data;
  rand spi_uvc_cmd_e  m_cmd;
  
  // Readout variables
  byte                m_data_mosi;
  byte                m_data_miso;

  extern function new(string name = "");
  
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);
  extern function string convert2string();

endclass : spi_uvc_sequence_item


function spi_uvc_sequence_item::new(string name = "");
  super.new(name);
endfunction : new


function void spi_uvc_sequence_item::do_copy(uvm_object rhs);
  spi_uvc_sequence_item rhs_;
  if (!$cast(rhs_, rhs)) `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  super.do_copy(rhs);
  m_data      = rhs_.m_data;
  m_cmd       = rhs_.m_cmd;
  m_data_mosi = rhs_.m_data_mosi;
  m_data_miso = rhs_.m_data_miso;
endfunction : do_copy


function bit spi_uvc_sequence_item::do_compare(uvm_object rhs, uvm_comparer comparer);
  bit result;
  spi_uvc_sequence_item rhs_;
  if (!$cast(rhs_, rhs)) `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  result = super.do_compare(rhs, comparer);
  result &= (m_data_mosi == rhs_.m_data_mosi);
  result &= (m_data_miso == rhs_.m_data_miso);
  return result;
endfunction : do_compare


function void spi_uvc_sequence_item::do_print(uvm_printer printer);
  if (printer.knobs.sprint == 0) `uvm_info(get_type_name(), convert2string(), UVM_MEDIUM)
  else printer.m_string = convert2string();
endfunction : do_print


function string spi_uvc_sequence_item::convert2string();
  string s;
  string cmd_str;
  s = super.convert2string();
  cmd_str = (m_cmd == SPI_UVC_WRITE) ? "SPI_UVC_WRITE" : "SPI_UVC_READ";
  $sformat(s, {s, "\n", "TRANSACTION INFORMATION (SPI UVC):"});
  $sformat(s, {s, "\n", "m_cmd = %10s, m_data = %4d"}, cmd_str, m_data);
  $sformat(s, {s, "\n", "m_data_mosi = %5d, m_data_miso = %5d\n"}, m_data_mosi, m_data_miso);
  return s;
endfunction : convert2string

`endif // SPI_UVC_SEQUENCE_ITEM_SV
