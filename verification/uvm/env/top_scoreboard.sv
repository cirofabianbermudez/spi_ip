`ifndef TOP_SCOREBOARD_SV
`define TOP_SCOREBOARD_SV

class top_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(top_scoreboard)

  `uvm_analysis_imp_decl(_spi)
  uvm_analysis_imp_spi #(spi_uvc_sequence_item, top_scoreboard) spi_imp_export;

  int unsigned m_num_passed;
  int unsigned m_num_failed;

  spi_uvc_sequence_item m_spi_queue[$];

  extern function new(string name, uvm_component parent);

  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern function void report_phase(uvm_phase phase);

  extern function void write_spi(input spi_uvc_sequence_item t);

endclass : top_scoreboard


function top_scoreboard::new(string name, uvm_component parent);
  super.new(name, parent);
  m_num_passed = 0;
  m_num_failed = 0;
endfunction : new


function void top_scoreboard::build_phase(uvm_phase phase);
  spi_imp_export = new("spi_imp_export", this);
endfunction : build_phase


function void top_scoreboard::write_spi(input spi_uvc_sequence_item t);
  spi_uvc_sequence_item received_trans;
  received_trans = spi_uvc_sequence_item::type_id::create("received_trans");
  received_trans.do_copy(t);
  m_spi_queue.push_back(received_trans);
endfunction : write_spi


task top_scoreboard::run_phase(uvm_phase phase);
  string s;

  forever begin
    
    wait( m_spi_queue.size() == 2);

    foreach(m_spi_queue[i]) begin
      if (m_spi_queue[i].m_data == m_spi_queue[i].m_data_mosi) begin
        m_num_passed++;
      end else begin
        m_num_failed++;
      end
    end
    
    if (m_spi_queue[0].m_data_mosi == (m_spi_queue[1].m_data_miso - 8'd1)) begin
      m_num_passed++;
    end else begin
      m_num_failed++;
    end

    foreach (m_spi_queue[i]) begin
      s = {s, $sformatf("\nTRANS[%3d]: \n", i) ,m_spi_queue[i].convert2string(), "\n"};
    end
    `uvm_info(get_type_name(), s, UVM_DEBUG)
    s = "";
    
    m_spi_queue.pop_front();
  end

endtask : run_phase


function void top_scoreboard::report_phase(uvm_phase phase);
  // string s;
  // foreach (m_spi_queue[i]) begin
  //   s = {s, $sformatf("\nTRANS[%3d]: \n", i) ,m_spi_queue[i].convert2string(), "\n"};
  // end
  // `uvm_info(get_type_name(), s, UVM_DEBUG)
  `uvm_info(get_type_name(), $sformatf("PASSED = %3d, FAILED = %3d", m_num_passed, m_num_failed), UVM_DEBUG)
endfunction : report_phase

`endif // TOP_SCOREBOARD_SV
