`include "uvm_macros.svh"

`include "add_if.sv"
`include "add.sv"
////////////////////////////////////////////////////////////////////////////////////
package my_seq_library;
 import uvm_pkg::*;
`include "add_tr.sv"
`include "add_gen.sv"
endpackage: my_seq_library
////////////////////////////////////////////////////////////////////////////////////
package my_pkg;
 import uvm_pkg::*;
 import my_seq_library::*;
`include "add_drv.sv"
`include "add_mon.sv"
`include "add_agt.sv"
`include "add_scb.sv"
`include "add_env.sv"
`include "add_test.sv"
endpackage: my_pkg
////////////////////////////////////////////////////////////////////////////////////
module add_tb;
 import uvm_pkg::*;
 import my_pkg::*;
 
 add_if a_if();
 //add ins1(.a(a_if.a), .b(a_if.b), .y(a_if.y));
 add ins1(.aif(a_if));
 initial begin
  uvm_config_db #(virtual add_if)::set(null, "uvm_test_top.en.agt*", "a_if",a_if);
  run_test("test");
 end
endmodule
////////////////////////////////////////////////////////////////////////////////////
