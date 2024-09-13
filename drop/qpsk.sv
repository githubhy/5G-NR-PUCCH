/*
Point  0: Real = 0101101010000010 (0.7071),     Imaginary = 0101101010000010 (0.7071)   (i % 2 == 0, b == 0)
Point  1: Real = 1010010101111110 (-0.7071),    Imaginary = 0101101010000010 (0.7071)   (i % 2 == 1, b == 0)
Point  2: Real = 0101101010000010 (0.7071),     Imaginary = 1010010101111110 (-0.7071)  (i % 2 == 1, b == 1)
Point  3: Real = 1010010101111110 (-0.7071),    Imaginary = 1010010101111110 (-0.7071)  (i % 2 == 0, b == 1)

Examble b[0,1,...] = 00 10 01 11
=> 0.7071+0.7071j, -0.7071+0.7071j, 0.7071-0.7071j, -0.7071-0.7071j
*/

module bpsk (
    input [1:0] i_b0b1,  //! Data bits b[0],b[1],...

    output [15:0] o_re,  //! Coresponding BPSK modulation complex point's real value (sfix16)
    output [15:0] o_im   //! Coresponding BPSK modulation complex point's imaginary value (sfix16)
);

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

  assign o_re  = re[i_b0b1];
  assign o_im  = im[i_b0b1];

endmodule
