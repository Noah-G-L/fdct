///////////////////////////////////////////
// sub.sv
//
// Written: nlimpert@hmc.edu 20 April 2024
//
// Purpose Subtract Unit: SUBTRACTOR that perserves output in case of overflow
//
////////////////////////////////////////////////////////////////////////////////////////////////

module sub #(parameter WIDTH=8) (
  input  logic [WIDTH-1:0] a, b,
  output logic [WIDTH:0] y
);
  logic [WIDTH-1:0] nb;
  
  assign nb = ~b+1;
  assign y = a + nb;
endmodule 
