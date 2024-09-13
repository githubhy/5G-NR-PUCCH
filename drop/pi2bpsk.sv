/*
Point  0: Real = 0101101010000010 (0.7071),     Imaginary = 0101101010000010 (0.7071)   (i % 2 == 0, b == 0) => mapping: b * 2 + (i % 2)
Point  1: Real = 1010010101111110 (-0.7071),    Imaginary = 0101101010000010 (0.7071)   (i % 2 == 1, b == 0)
Point  2: Real = 1010010101111110 (-0.7071),    Imaginary = 1010010101111110 (-0.7071)  (i % 2 == 0, b == 1)
Point  3: Real = 0101101010000010 (0.7071),     Imaginary = 1010010101111110 (-0.7071)  (i % 2 == 1, b == 1)
*/

module bpsk (
    input        i_b,
    input [15:0] i_index,

    output [15:0] o_re,  // sfix16
    output [15:0] o_im   // sfix16
);

  wire is_even_index = i_index[0];
  wire [1:0] b_x2 = {i_b, 1'b0};

  wire [15:0] re[0:3];
  wire [15:0] im[0:3];

  assign re[0] = 16'b0101101010000010;
  assign re[1] = 16'b1010010101111110;
  assign re[2] = 16'b1010010101111110;
  assign re[3] = 16'b0101101010000010;

  assign im[0] = 16'b0101101010000010;
  assign im[1] = 16'b0101101010000010;
  assign im[2] = 16'b1010010101111110;
  assign im[3] = 16'b1010010101111110;

  assign o_re  = re[b_x2+is_even_index];
  assign o_im  = im[b_x2+is_even_index];

endmodule
