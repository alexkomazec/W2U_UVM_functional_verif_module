//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : wb2uart_test_base.sv
// Developer  : Aleksandar Komazec
// Date       :
// Description:
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef WB2UART_TEST_BASE_SV
`define WB2UART_TEST_BASE_SV

class wb2uart_test_base extends uvm_test;

  // registration macro
  `uvm_component_utils(wb2uart_test_base)

  // component instance
  wb2uart_env_top m_wb2uart_env_top;

  // configuration instance
  wb2uart_top_cfg m_cfg;

  // fields
  int m_number_of_data_bits;
  int m_number_of_stop_bits;
  int m_parity_enable;
  int m_parity_type;
  int m_baud_rate;
  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  // end_of_elaboration phase
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  // set default configuration
  extern virtual function void set_default_configuration();

endclass : wb2uart_test_base 

// constructor
function wb2uart_test_base::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void wb2uart_test_base::build_phase(uvm_phase phase);
  super.build_phase(phase);

  // create component
  m_wb2uart_env_top = wb2uart_env_top::type_id::create("m_wb2uart_env_top", this);

  // create and set configuration
  m_cfg = wb2uart_top_cfg::type_id::create("m_cfg", this);
  set_default_configuration();

  // set configuration in DB
  uvm_config_db#(wb2uart_top_cfg)::set(this, "m_wb2uart_env_top", "m_cfg", m_cfg);

  // enable monitor item recording
  set_config_int("*", "recording_detail", 1);

  // define verbosity
  uvm_top.set_report_verbosity_level_hier(UVM_HIGH);
endfunction : build_phase

// end_of_elaboration phase
function void wb2uart_test_base::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);

  // allow additional time before stopping
  uvm_test_done.set_drain_time(this, 10us);
endfunction : end_of_elaboration_phase

// set default configuration
function void wb2uart_test_base::set_default_configuration();
  // define default configuration
  // configuration for tx agent
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_is_active     = UVM_ACTIVE;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_has_checks    = 1;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_has_coverage  = 1;

`ifdef RANDOMIZE_CONFIG 
  m_number_of_data_bits = $urandom_range(8, 5);
  case(m_number_of_data_bits)
    5:  begin
          m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_data_bits = FIVE_E;
          m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_data_bits = FIVE_E;
        end

    6:  begin
          m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_data_bits = SIX_E;
          m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_data_bits = SIX_E;
        end

    7:  begin
          m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_data_bits = SEVEN_E;
          m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_data_bits = SEVEN_E;
        end

    8:  begin
          m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_data_bits = EIGHT_E;
          m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_data_bits = EIGHT_E;
        end

    default: begin
              m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_data_bits = EIGHT_E;
              m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_data_bits = EIGHT_E;
            end
  endcase

  m_number_of_stop_bits = $urandom_range(3, 1);
  case(m_number_of_stop_bits)
  1:  begin
        m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_stop_bits = ONE_E;
        m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_stop_bits = ONE_E;
      end

  2:  begin
        m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_stop_bits = ONE_AND_HALF_E;
        m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_stop_bits = ONE_AND_HALF_E;
      end

  3:  begin
        m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_stop_bits = TWO_E;
        m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_stop_bits = TWO_E;
      end

  default: begin
            m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_stop_bits = TWO_E;
            m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_stop_bits = TWO_E;
          end
  endcase

  m_parity_enable = $urandom_range(2, 1);
  case(m_parity_enable)
    1:  begin
          m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_enable       = NO_PARITY_E;
          m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_enable       = NO_PARITY_E;
        end

    2:  begin
          m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_enable       = PARITY_E;
          m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_enable       = PARITY_E;
        end

    default: begin
              m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_enable       = PARITY_E;
              m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_enable       = PARITY_E;
            end
  endcase

  m_parity_type = $urandom_range(2, 1);
  case(m_parity_type)
    1:  begin
          m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_type         = EVEN_E;
          m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_type         = EVEN_E;
        end

    2:  begin
          m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_type         = ODD_E;
          m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_type         = ODD_E;
        end

    default: begin
              m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_type         = ODD_E;
              m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_type         = ODD_E;
            end
  endcase

  m_baud_rate = $urandom_range(8, 1);
  case(m_baud_rate)
    1:  begin
          m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_baud_rate           = BAUD_RATE_1200_E;
          m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_baud_rate           = BAUD_RATE_1200_E;
        end

    2:  begin
          m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_baud_rate           = BAUD_RATE_2400_E;
          m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_baud_rate           = BAUD_RATE_2400_E;
        end

    3:  begin
          m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_baud_rate           = BAUD_RATE_4800_E;
          m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_baud_rate           = BAUD_RATE_4800_E;
        end

    4:  begin
          m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_baud_rate           = BAUD_RATE_9600_E;
          m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_baud_rate           = BAUD_RATE_9600_E;
        end

    5:  begin
          m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_baud_rate           = BAUD_RATE_19200_E;
          m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_baud_rate           = BAUD_RATE_19200_E;
        end

    6:  begin
          m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_baud_rate           = BAUD_RATE_38400_E;
          m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_baud_rate           = BAUD_RATE_38400_E;
        end

    7:  begin
          m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_baud_rate           = BAUD_RATE_57600_E;
          m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_baud_rate           = BAUD_RATE_57600_E;
        end

    8:  begin
          m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_baud_rate           = BAUD_RATE_115200_E;
          m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_baud_rate           = BAUD_RATE_115200_E;
        end

    default: begin
          m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_baud_rate           = BAUD_RATE_115200_E;
          m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_baud_rate           = BAUD_RATE_115200_E;
            end
  endcase
`else
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_data_bits = EIGHT_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_stop_bits = ONE_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_enable       = PARITY_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_type         = EVEN_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_baud_rate           = BAUD_RATE_115200_E;

  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_data_bits = EIGHT_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_stop_bits = ONE_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_enable       = PARITY_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_type         = EVEN_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_baud_rate           = BAUD_RATE_115200_E;
`endif

  // configuration for rx agent
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_has_checks    = 1;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_has_coverage  = 1;

  m_cfg.m_wishbone_uvc_cfg.m_agent_cfg.m_is_active = UVM_ACTIVE;
  m_cfg.m_wishbone_uvc_cfg.m_agent_cfg.m_has_checks = 1;
  m_cfg.m_wishbone_uvc_cfg.m_agent_cfg.m_has_coverage = 1;

endfunction : set_default_configuration

`endif // TEST_UART_UVC_BASE_SV
