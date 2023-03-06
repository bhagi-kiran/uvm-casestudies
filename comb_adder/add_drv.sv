class driver extends uvm_driver #(transaction);
 `uvm_component_utils(driver)
 
 function new(input string name = "driver", uvm_component parent = null);
  super.new(name, parent);
 endfunction
 //we need data container to receive stimulus, so
 transaction tc;
 //we need to get an access to interface
 virtual add_if a_if;
 
 virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  tc = transaction::type_id::create("tc");
  //we'll get access to interface in build_phase itself
  if(!uvm_config_db #(virtual add_if)::get(this, "", "a_if", a_if))
  `uvm_error("DRV", "UNABLE TO ACCESS UVM_CONFIG_DB");
  //adv is it will automatically call fatal and stops sim
 endfunction
 
 virtual task run_phase(uvm_phase phase);
  forever begin
  //special port thru which we'll be communicating with sequencer
  //sending req to seq that driver is ready to accept new data
  seq_item_port.get_next_item(tc);
  //after getting data, applying it to dut
  //triggering interface, use only <=
  a_if.a <= tc.a;
  a_if.b <= tc.b;
  `uvm_info("DRV", $sformatf("TRIGGERING DUT a: %0d, b: %0d",tc.a, tc.b), UVM_NONE)
  seq_item_port.item_done();
  //sending ack to sequencer then to sequence
  #10;
  //each applied at an interval of 10 nsec
  end
 endtask
endclass
