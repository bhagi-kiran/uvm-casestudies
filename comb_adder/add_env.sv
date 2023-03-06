class env extends uvm_env;
 `uvm_component_utils(env)
 
 function new(input string name = "env", uvm_component parent = this);
  super.new(name, parent);
 endfunction
 
 scoreboard scb;
 agent agt;
 
 virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  scb = scoreboard::type_id::create("scb", this);
  agt = agent::type_id::create("agt", this);
 endfunction
 
 virtual function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  agt.mon.send.connect(scb.receive);
 endfunction
endclass
