////////////////////////////////
// negative.sv 
// written nlimpert@hmc.edu 20 April 2024
// modified: 
// Purpose: invert a two's complement value/
//////////////////////

module negative #(parameter WIDTH = 8) (
    input  logic [WIDTH-1:0] a,
    output logic [WIDTH-1:0] y
);

  assign y = ~a + 1;
endmodule