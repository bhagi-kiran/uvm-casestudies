class scoreboard extends uvm_scoreboard;
 `uvm_component_utils(scoreboard)
 
 function new(input string name = "scoreboard", uvm_component parent = null);
  super.new(name, parent);
 endfunction
 
 transaction tr;
 uvm_analysis_imp #(transaction, scoreboard) receive;
 
 virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  tr = transaction::type_id::create("tr");
  receive = new("receive", this);
 endfunction
 
 virtual function void write(transaction t);
  tr = t;
  `uvm_info("SCB", $sformatf("DATA RECEIVED FROM MONITOR: a: %0d, b: %0d, and y: %0d",tr.a,tr.b,tr.y),UVM_NONE)
  
  if (tr.y == tr.a + tr.b)
  `uvm_info("SCB", "TEST PASSED", UVM_NONE)
  else
  `uvm_info("SCB", "TEST FAILED", UVM_NONE)
 endfunction
  
endclass
