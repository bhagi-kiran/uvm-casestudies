class agent extends uvm_agent;
 `uvm_component_utils(agent)
 
 function new(input string name = "agent", uvm_component parent = this);
  super.new(name, parent);
 endfunction
 
 uvm_sequencer #(transaction) seqr;
 driver drv;
 monitor mon;
 
 virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  seqr = uvm_sequencer #(transaction)::type_id::create("seqr", this);
  drv = driver::type_id::create("drv", this);
  mon = monitor::type_id::create("mon", this);
 endfunction
 
 virtual function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  drv.seq_item_port.connect(seqr.seq_item_export);
 endfunction
endclass
//doubt is there in this, clear it ||agent contains seqr, drv and mon and drv is connected to seqr and seqr to seqnce 
