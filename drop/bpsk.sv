/*
Point  0: Real = 0101101010000010, Imaginary = 0101101010000010
Point  1: Real = 1010010101111110, Imaginary = 1010010101111110
*/

module bpsk (
    input i_b,

    output [15:0] o_re,  // sfix16
    output [15:0] o_im   // sfix16
);

  wire [15:0] re[0:1];
  wire [15:0] im[0:1];

  assign re[0] = 16'b0101101010000010;
  assign re[1] = 16'b1010010101111110;

  assign im[0] = 16'b0101101010000010;
  assign im[1] = 16'b1010010101111110;

  assign o_re  = re[i_b];
  assign o_im  = im[i_b];

endmodule
