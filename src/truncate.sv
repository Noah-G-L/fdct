////////////////////////////////
// truncate.sv 
// written nlimpert@hmc.edu 20 April 2024
// modified: 
// Purpose: truncate an n bit value (2cp) into an m bit number
// verify: hey, will this actually give expected behaviour? 
// WIDTH IN MUST BE MORE THAN WIDTH OUT FOR THIS TO WORK!
//////////////////////

module truncate #(
  parameter WIDTH_IN = 16,
  parameter WIDTH_OUT = 8)(
  input  logic[WIDTH_IN-1:0] a,
  output logic[WIDTH_OUT-1:0] y
  );

  assign y = a[WIDTH_IN-1:WIDTH_IN-WIDTH_OUT];
endmodule