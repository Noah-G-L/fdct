///////////////////////
// created by: Noah Limpert Apr 25 2024
// nlimpert@hmc.edu
// Purpose: carry out an 8 point 1-D dct. 
// implementation: DCT datapath described by loeffler et. al 1989
// 4 pipeline stages. 

module fdct(
    input logic clk, reset,
    input logic [7:0] i_x [7:0],
    output logic [7:0] i_y
  );
  //////////////////////////////////////////////////////////////////////
  /// Stage 1 
  /////////////////////////////////////////////////////////////////////
  ////////// Stage 1 signals  
  logic [8:0] o_1 [7:0]; // output of stage 1 
  logic [8:0] i_2 [7:0]; // inputs of stage 2
  logic [10:0] o_2 [7:0]; //  outputs of stage 2 
  logic [10:0] i_3 [7:0]; // input of stage 3


  ////////// Stage 1 operation 
  adder #(8) a1_0(i_x[0], i_x[7], o_1[0]);
  adder #(8) a1_1(i_x[1], i_x[6], o_1[1]);
  adder #(8) a1_2(i_x[2], i_x[5], o_1[2]);
  adder #(8) a1_3(i_x[3], i_x[4], o_1[3]);
  sub   #(8) s1_4(i_x[3], i_x[4], o_1[4]);
  sub   #(8) s1_5(i_x[2], i_x[5], o_1[5]);
  sub   #(8) s1_6(i_x[1], i_x[6], o_1[6]);
  sub   #(8) s1_7(i_x[0], i_x[7], o_1[7]);

  ///////// Stage 1 registers 
  flopr #(9) ff1_0(clk, reset, o_1[0], i_2[0]);
  flopr #(9) ff1_1(clk, reset, o_1[1], i_2[1]);
  flopr #(9) ff1_2(clk, reset, o_1[2], i_2[2]);
  flopr #(9) ff1_3(clk, reset, o_1[3], i_2[3]);
  flopr #(9) ff1_4(clk, reset, o_1[4], i_2[4]);
  flopr #(9) ff1_5(clk, reset, o_1[5], i_2[5]);
  flopr #(9) ff1_6(clk, reset, o_1[6], i_2[6]);
  flopr #(9) ff1_7(clk, reset, o_1[7], i_2[7]);
  
  //////////////////////////////////////////////////////////////////////
  /// Stage 2
  //////////////////////////////////////////////////////////////////////
  ////////// Stage 2 signals  
 
  

  ////////// Stage 2 Operation 
  adder #(9) a2_0(i_x[0], i_x[3], o_2[0][9:0]);
  adder #(9) a2_1(i_x[1], i_x[2], o_2[1][9:0]);
  sub   #(9) s2_2(i_x[1], i_x[2], o_2[2][9:0]);
  sub   #(9) s2_3(i_x[0], i_x[3], o_2[3][9:0]);

  rotation #(9, 32'h0, 32'h0, 32'h0) r2_4_7(i_2[4], i_2[7], o_2[4], o_2[7]);
  rotation #(9, 32'h0, 32'h0, 32'h0) r2_5_6(i_2[5], i_2[6], o_2[5], o_2[6]);
  ///////// Stage 2 registers 
  flopr #(11) ff2_0(clk, reset, {o_2[0][10],o_2[0][9:0]}, i_3[0]);
  flopr #(11) ff2_1(clk, reset, {o_2[1][10],o_2[1][9:0]}, i_3[1]);
  flopr #(11) ff2_2(clk, reset, {o_2[2][10],o_2[2][9:0]}, i_3[2]);
  flopr #(11) ff2_3(clk, reset, {o_2[3][10],o_2[3][9:0]}, i_3[3]);
  flopr #(11) ff2_4(clk, reset, o_2[4], i_3[4]);
  flopr #(11) ff2_5(clk, reset, o_2[5], i_3[5]);
  flopr #(11) ff2_6(clk, reset, o_2[6], i_3[6]);
  flopr #(11) ff2_7(clk, reset, o_2[7], i_3[7]);

  //////////////////////////////////////////////////////////////////////
  /// Stage 3
  //////////////////////////////////////////////////////////////////////
  ////////// Stage 3 signals  


  ////////// Stage 3 Operation 

  ///////// Stage 3 registers 

//////////////////////////////////////////////////////////////////////
/// Stage 4
//////////////////////////////////////////////////////////////////////
////////// Stage 4 signals  

////////// Stage 4 Operation 

///////// Stage 4 registers 


endmodule