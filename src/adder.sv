///////////////////////////////////////////
// adder.sv
//
// Written: David_Harris@hmc.edu 2 October 2021
// Modified: nlimpert@hmc.edu 20 April 2024
//
// Purpose: Adder with defined behaviour on overflow and underflow --> In case of overflow, giv
//
////////////////////////////////////////////////////////////////////////////////////////////////

module adder #(parameter WIDTH=8) (
  input  logic [WIDTH-1:0] a, b,
  output logic [WIDTH-1:0] y
);
  // check somehow if it is going to overflow or underflow.
  assign y = a + b;
endmodule 
