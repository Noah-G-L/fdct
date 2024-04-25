///////////////////////
//// Created By Noah Limpert Apr 25 2024
//// nlimpert@hmc.edu
//// Purpose: Execute the rotation in DCT datapath described by loeffler et. al 1989
//// Computation may be saved with truncation before creation of long products
///////////////////////

module rotatation #(
    parameter WIDTH = 8,
    parameter A = 32'h0,
    parameter BMA = 32'h0, // NOTE THAT IF SIGNALS GROW LARGER THAN 32 this wont hold. 
    parameter NAPB = 32'h0
) (
    input logic [WIDTH-1:0] x0, x1,
    output logic [WIDTH+1:0] y0, y1
);
  // create necessary  constant 'input' signals
  logic [WIDTH-1:0] k0, k1; 
  logic [WIDTH:0] k2;  // needs to be wider, as k3 * (x0 + x1) 

  // create other signals 
  logic [WIDTH:0] sumx0x1;
  logic [WIDTH*2-1:0] p0, p1;
  logic [(WIDTH+1)*2:0] p2;

  logic [(WIDTH+1)*2+1:0] ly0, ly1;

  // assign signals 
  assign k0 = BMA[32:32-WIDTH]; // want the top WIDTH bits of signal
  assign k1 = NAPB[32:32-WITH]; 
  assign k2 = A[32:31-WIDTH]; // want the top WIDTH + 1


  // create / connect modules 
  // initial addition x0+x1
  adder #(WIDTH) sum0(x0, x1, sumx0x1);

  // Carry out Multiplications 
  param_mult #(WIDTH) mul0(k0, x1,  p0);
  param_mult #(WIDTH) mul1(k1, x0,  p1);
  param_mult #(WIDTH+1) mul3(k2, sumx0x1, p2);

  // Create  long pdts, sign extend p0 and p1 so that they are same width as p2 
  adder #((WIDTH+1)*2+1) fsum0({p0[WIDTH*2-1], p0}, p2, ly0);
  adder #((WIDTH+1)*2+1) fsum1({p1[WIDTH*2-1], p1}, p2, ly1);

  // truncate long pdts 
  truncate #(((WIDTH+1)*2+1), (WIDTH+2)) trunc0(ly0, y0)
  truncate #(((WIDTH+1)*2+1), (WIDTH+2)) trunc1(ly0, y1)


endmodule