class test extends uvm_test;
 `uvm_component_utils(test)
 
 function new(input string name = "test", uvm_component parent = null);
  super.new(name, parent);
 endfunction
 
 generator gen;
 env en;
 
 virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  gen = generator::type_id::create("gen");
  en = env::type_id::create("en", this);
 endfunction
 
 virtual task run_phase(uvm_phase phase);
  phase.raise_objection(this);
  gen.start(en.agt.seqr);
  #50 //post edit
  phase.drop_objection(this);
 endtask
endclass
 
