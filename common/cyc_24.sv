/*
The 24 equally spaced points on the complex unit circle in 16-bit fixed-point are:
   1.0000 + 0.0000i
   0.9659 + 0.2588i
   0.8660 + 0.5000i
   0.7071 + 0.7071i
   0.5000 + 0.8660i
   0.2588 + 0.9659i
   0.0000 + 1.0000i
  -0.2588 + 0.9659i
  -0.5000 + 0.8660i
  -0.7071 + 0.7071i
  -0.8660 + 0.5000i
  -0.9659 + 0.2588i
  -1.0000 + 0.0000i
  -0.9659 - 0.2588i
  -0.8660 - 0.5000i
  -0.7071 - 0.7071i
  -0.5000 - 0.8660i
  -0.2588 - 0.9659i
   0.0000 - 1.0000i
   0.2588 - 0.9659i
   0.5000 - 0.8660i
   0.7071 - 0.7071i
   0.8660 - 0.5000i
   0.9659 - 0.2588i

Point  1: Real = 0111111111111111, Imaginary = 0000000000000000
Point  2: Real = 0111101110100011, Imaginary = 0010000100100001
Point  3: Real = 0110111011011010, Imaginary = 0100000000000000
Point  4: Real = 0101101010000010, Imaginary = 0101101010000010
Point  5: Real = 0100000000000000, Imaginary = 0110111011011010
Point  6: Real = 0010000100100001, Imaginary = 0111101110100011
Point  7: Real = 0000000000000000, Imaginary = 0111111111111111
Point  8: Real = 1101111011011111, Imaginary = 0111101110100011
Point  9: Real = 1100000000000000, Imaginary = 0110111011011010
Point 10: Real = 1010010101111110, Imaginary = 0101101010000010
Point 11: Real = 1001000100100110, Imaginary = 0100000000000000
Point 12: Real = 1000010001011101, Imaginary = 0010000100100001
Point 13: Real = 1000000000000000, Imaginary = 0000000000000000
Point 14: Real = 1000010001011101, Imaginary = 1101111011011111
Point 15: Real = 1001000100100110, Imaginary = 1100000000000000
Point 16: Real = 1010010101111110, Imaginary = 1010010101111110
Point 17: Real = 1100000000000000, Imaginary = 1001000100100110
Point 18: Real = 1101111011011111, Imaginary = 1000010001011101
Point 19: Real = 0000000000000000, Imaginary = 1000000000000000
Point 20: Real = 0010000100100001, Imaginary = 1000010001011101
Point 21: Real = 0100000000000000, Imaginary = 1001000100100110
Point 22: Real = 0101101010000010, Imaginary = 1010010101111110
Point 23: Real = 0110111011011010, Imaginary = 1100000000000000
Point 24: Real = 0111101110100011, Imaginary = 1101111011011111
*/
module cyc_24 (
    input [4:0] i_point_index,  //! i_point_index/24 of a cycle (0-23)

    output signed [15:0] o_point_re,  //! Coresponding complex point's real value (sfix16)
    output signed [15:0] o_point_im   //! Coresponding complex point's imaginary value (sfix16)
);

  wire signed [15:0] point_im[0:23];
  wire signed [15:0] point_re[0:23];

  assign point_re[0]  = 'b0111111111111111;
  assign point_re[1]  = 'b0111101110100011;
  assign point_re[2]  = 'b0110111011011010;
  assign point_re[3]  = 'b0101101010000010;
  assign point_re[4]  = 'b0100000000000000;
  assign point_re[5]  = 'b0010000100100001;
  assign point_re[6]  = 'b0000000000000000;
  assign point_re[7]  = 'b1101111011011111;
  assign point_re[8]  = 'b1100000000000000;
  assign point_re[9]  = 'b1010010101111110;
  assign point_re[10] = 'b1001000100100110;
  assign point_re[11] = 'b1000010001011101;
  assign point_re[12] = 'b1000000000000000;
  assign point_re[13] = 'b1000010001011101;
  assign point_re[14] = 'b1001000100100110;
  assign point_re[15] = 'b1010010101111110;
  assign point_re[16] = 'b1100000000000000;
  assign point_re[17] = 'b1101111011011111;
  assign point_re[18] = 'b0000000000000000;
  assign point_re[19] = 'b0010000100100001;
  assign point_re[20] = 'b0100000000000000;
  assign point_re[21] = 'b0101101010000010;
  assign point_re[22] = 'b0110111011011010;
  assign point_re[23] = 'b0111101110100011;

  assign point_im[0]  = 'b0000000000000000;
  assign point_im[1]  = 'b0010000100100001;
  assign point_im[2]  = 'b0100000000000000;
  assign point_im[3]  = 'b0101101010000010;
  assign point_im[4]  = 'b0110111011011010;
  assign point_im[5]  = 'b0111101110100011;
  assign point_im[6]  = 'b0111111111111111;
  assign point_im[7]  = 'b0111101110100011;
  assign point_im[8]  = 'b0110111011011010;
  assign point_im[9]  = 'b0101101010000010;
  assign point_im[10] = 'b0100000000000000;
  assign point_im[11] = 'b0010000100100001;
  assign point_im[12] = 'b0000000000000000;
  assign point_im[13] = 'b1101111011011111;
  assign point_im[14] = 'b1100000000000000;
  assign point_im[15] = 'b1010010101111110;
  assign point_im[16] = 'b1001000100100110;
  assign point_im[17] = 'b1000010001011101;
  assign point_im[18] = 'b1000000000000000;
  assign point_im[19] = 'b1000010001011101;
  assign point_im[20] = 'b1001000100100110;
  assign point_im[21] = 'b1010010101111110;
  assign point_im[22] = 'b1100000000000000;
  assign point_im[23] = 'b1101111011011111;

  assign o_point_re   = point_re[i_point_index];
  assign o_point_im   = point_im[i_point_index];

endmodule
