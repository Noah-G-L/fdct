///////////////////////////////////////////
// mul.sv
// Written: nlimpert@hmc.edu 20 April 2024
// Inspired by teaching and textbook of David_Harris@hmc.edu 
// Purpose: parametized Integer multiplication
////////////////////////////////////////////////////////////////////////////////////////////////
module param_mult #(parameter WIDTH = 8) (
    input  logic [WIDTH-1:0] a, b,
    output logic [2*WIDTH-1:0] y
);

  // Create Signals
  logic [WIDTH*2-1:0] PP1, PP2, PP3, PP4; // partial products 
  logic [WIDTH*2-1:0] PP, PA, PB, PM;

  // Compute P' PA, PB, Pm
  assign PP = {{(WIDTH+1){1'b0}}, a[WIDTH-2:0]} * {{(WIDTH+1){1'b0}}, b[WIDTH-2:0]};
  assign PA = {(WIDTH*2){b[WIDTH-1]}} & {{(2){1'b0}}, a[WIDTH-2:0], {(WIDTH-1){1'b0}}};
  assign PB = {(WIDTH*2){a[WIDTH-1]}} & {{(2){1'b0}}, b[WIDTH-2:0], {(WIDTH-1){1'b0}}};
  assign PM ={{(WIDTH*2-1){1'b0}}, a[WIDTH-1]} & {{(WIDTH*2-1){1'b0}}, b[WIDTH-1]};

  // Compute partial products 
  assign PP1 = PP;
  assign PP2 = PA ^ {{(2){1'b0}}, {(WIDTH-1){1'b1}}, {(WIDTH-1){1'b0}}};
  assign PP3 = PB ^ {{(2){1'b0}}, {(WIDTH-1){1'b1}}, {(WIDTH-1){1'b0}}};
  assign PP4 = (PM << (WIDTH*2-2)) + ({{(WIDTH*2-1){1'b0}},1'b1} << (WIDTH*2-1)) + ({{(WIDTH*2-1){1'b0}},1'b1} << WIDTH);

  // Add up Partia products implying CSAs and CPA 
  assign y = PP1 + PP2 + PP3 + PP4;

endmodule