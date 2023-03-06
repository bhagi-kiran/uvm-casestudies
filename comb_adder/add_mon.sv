class monitor extends uvm_monitor;
 `uvm_component_utils(monitor)
 
 function new(input string name = "monitor", uvm_component parent = this);
  super.new(name, parent);
 endfunction
 
 uvm_analysis_port #(transaction) send;
 transaction t;
 virtual add_if a_if;
 
 virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  t = transaction::type_id::create("t");
  send = new("send", this);
  if (!uvm_config_db #(virtual add_if)::get(this, "", "a_if", a_if))
  `uvm_error("MON", "UNABLE TO ACCESS INTERFACE")
 endfunction
 
 virtual task run_phase(uvm_phase phase);
  forever begin
   #10
   t.a = a_if.a;
   t.b = a_if.b;
   t.y = a_if.y;
   `uvm_info("MON", $sformatf("DATA SENT TO SCB: a: %0d, b: %0d and y: %0d",t.a,t.b,t.y), UVM_NONE)
   send.write(t);
  end
 endtask
endclass
