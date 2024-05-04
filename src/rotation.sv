///////////////////////
//// Created By Noah Limpert Apr 25 2024
//// nlimpert@hmc.edu
//// Purpose: Execute the rotation in DCT datapath described by loeffler et. al 1989
//// Computation may be saved with truncation before creation of long products
///////////////////////

module rotation #(
    parameter WIDTH = 8,
    parameter A = 8'h00,
    parameter BMA = 8'h00, // NOTE THAT IF SIGNALS GROW LARGER THAN 32 this wont hold. 
    parameter NAPB = 8'h00
) (
    input logic [WIDTH-1:0] x0, x1,
    output logic [2*WIDTH-1:0] y0, y1
);
  // create necessary  constant 'input' signals
  logic [WIDTH-1:0] k0, k1; 
  logic [WIDTH-1:0] k2;  // needs to be wider, as k3 * (x0 + x1) 

  // create other signals 
  logic [WIDTH-1:0] sumx0x1;
  logic [WIDTH*2-1:0] p0, p1, p2;

  logic [WIDTH*2-1:0] ly0, ly1;

  // assign signals 
  // RIGHT NOW PARAMETERS ARE SIGNED INTS
  // WILL IT PROPERLY CAST to logic signal?
  assign k0 = BMA; // want the top WIDTH bits of signal
  assign k1 = NAPB; 
  assign k2 = A; // want the top WIDTH + 1


  // create / connect modules 
  // initial addition x0+x1
  adder #(WIDTH) sum0(x0, x1, sumx0x1);

  // Carry out Multiplications 
  param_mult #(WIDTH) mul0(k0, x1,  p0);
  param_mult #(WIDTH) mul1(k1, x0,  p1);
  param_mult #(WIDTH) mul3(k2, sumx0x1, p2);

  // Create  long pdts
  adder #(WIDTH*2) fsum0(p0, p2, y0); // If I truncate, change back
  adder #(WIDTH*2) fsum1(p1, p2, y1); // If I truncate, change back

  // truncate long pdts  FOR NOW , KEEP IT UNTRUNCATED for NOW
  // truncate #((WIDTH*2), (WIDTH)) trunc0(ly0, y0);
  // truncate #((WIDTH*2), (WIDTH)) trunc1(ly0, y1);

endmodule