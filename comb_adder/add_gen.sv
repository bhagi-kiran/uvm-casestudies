class generator extends uvm_sequence #(transaction);
 `uvm_object_utils(generator)
 
 transaction t;
 integer i;
 int count = 10;
 
 function new(input string name = "generator");
  super.new();
 endfunction
 
 virtual task body();
  t = transaction::type_id::create("t");
 // repeat(10)
  for (i = 0; i < count; i++) begin
   `uvm_info("GEN", $sformatf("[PACKET] : %0d of %0d",i+1,count), UVM_NONE); //push down if doesnt work
   start_item(t);
   t.randomize();
   `uvm_info("GEN", $sformatf("DATA SENT TO DRIVER a : %0d, b : %0d",t.a,t.b), UVM_NONE);
   finish_item(t);
  end
 endtask
 
endclass
