///////////////////////////////////////////
// adder.sv
//
// Written: David_Harris@hmc.edu 2 October 2021
// Modified: nlimpert@hmc.edu 20 April 2024
//
// Purpose: Adder that perserves output in case of overflow
//
////////////////////////////////////////////////////////////////////////////////////////////////

`include "wally-config.vh"

module adder #(parameter WIDTH=8) (
  input  logic [WIDTH-1:0] a, b,
  output logic [WIDTH:0] y
);

  assign y = a + b;
endmodule 
