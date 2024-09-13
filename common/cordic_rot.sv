/*
i =  0, atan(1/(2^ 0)) in binary: 0000110010010000111111011010101001 (0.7853981634)
i =  1, atan(1/(2^ 1)) in binary: 0000011101101011000110011100000101 (0.4636476090)
i =  2, atan(1/(2^ 2)) in binary: 0000001111101011011011101011111101 (0.2449786631)
i =  3, atan(1/(2^ 3)) in binary: 0000000111111101010110111010100111 (0.1243549945)
i =  4, atan(1/(2^ 4)) in binary: 0000000011111111101010101101110111 (0.0624188100)
i =  5, atan(1/(2^ 5)) in binary: 0000000001111111111101010101011100 (0.0312398334)
i =  6, atan(1/(2^ 6)) in binary: 0000000000111111111111101010101011 (0.0156237286)
i =  7, atan(1/(2^ 7)) in binary: 0000000000011111111111111101010101 (0.0078123411)
i =  8, atan(1/(2^ 8)) in binary: 0000000000001111111111111111101011 (0.0039062301)
i =  9, atan(1/(2^ 9)) in binary: 0000000000000111111111111111111101 (0.0019531225)
i = 10, atan(1/(2^10)) in binary: 0000000000000100000000000000000000 (0.0009765622)
i = 11, atan(1/(2^11)) in binary: 0000000000000010000000000000000000 (0.0004882812)
i = 12, atan(1/(2^12)) in binary: 0000000000000001000000000000000000 (0.0002441406)
i = 13, atan(1/(2^13)) in binary: 0000000000000000100000000000000000 (0.0001220703)
i = 14, atan(1/(2^14)) in binary: 0000000000000000010000000000000000 (0.0000610352)
i = 15, atan(1/(2^15)) in binary: 0000000000000000001000000000000000 (0.0000305176)
*/


module cordic_rot (
    input clk,
    input rst,

    input signed [POINT_SZ-1:0] i_re,     // sfix16_En15
    input signed [POINT_SZ-1:0] i_im,     // sfix16_En15
    input signed [ANGLE_SZ-1:0] i_angle,  // sfix34_En30
    input                       i_valid,
    input                       i_en,

    output signed [POINT_SZ-1:0] o_re,    // sfix16_En15
    output signed [POINT_SZ-1:0] o_im,    // sfix16_En15
    output                       o_valid
);

  localparam ITERATIONS = 16;
  localparam POINT_SZ = 16;
  localparam ANGLE_SZ = 34;

  //   reg  [POINT_SZ-1:0] i_res     [0:ITERATIONS-1];
  //   reg  [POINT_SZ-1:0] i_ims     [0:ITERATIONS-1];
  //   reg  [ANGLE_SZ-1:0] i_angles  [0:ITERATIONS-1];
  //   reg                 valids    [0:ITERATIONS-1];

  reg [POINT_SZ-1:0] x_i;  // re
  reg [POINT_SZ-1:0] y_i;  // im
  reg [ANGLE_SZ-1:0] z_i;  // angle

  localparam COUNTER_SZ = $clog2(ITERATIONS);
  reg [COUNTER_SZ-1:0] iteration_index;


  wire [ANGLE_SZ-1:0] lut_angles[0:ITERATIONS-1];

  assign lut_angles[00] = 'sb0000110010010000111111011010101001;  // (0.7853981634)
  assign lut_angles[01] = 'sb0000011101101011000110011100000101;  // (0.4636476090)
  assign lut_angles[02] = 'sb0000001111101011011011101011111101;  // (0.2449786631)
  assign lut_angles[03] = 'sb0000000111111101010110111010100111;  // (0.1243549945)
  assign lut_angles[04] = 'sb0000000011111111101010101101110111;  // (0.0624188100)
  assign lut_angles[05] = 'sb0000000001111111111101010101011100;  // (0.0312398334)
  assign lut_angles[06] = 'sb0000000000111111111111101010101011;  // (0.0156237286)
  assign lut_angles[07] = 'sb0000000000011111111111111101010101;  // (0.0078123411)
  assign lut_angles[08] = 'sb0000000000001111111111111111101011;  // (0.0039062301)
  assign lut_angles[09] = 'sb0000000000000111111111111111111101;  // (0.0019531225)
  assign lut_angles[10] = 'sb0000000000000100000000000000000000;  // (0.0009765622)
  assign lut_angles[11] = 'sb0000000000000010000000000000000000;  // (0.0004882812)
  assign lut_angles[12] = 'sb0000000000000001000000000000000000;  // (0.0002441406)
  assign lut_angles[13] = 'sb0000000000000000100000000000000000;  // (0.0001220703)
  assign lut_angles[14] = 'sb0000000000000000010000000000000000;  // (0.0000610352)
  assign lut_angles[15] = 'sb0000000000000000001000000000000000;  // (0.0000305176)

  //   integer pipe_index;
  always @(posedge clk, posedge rst) begin
    if (rst) begin
      iteration_index <= 0;
    end else begin
      if (i_en) begin
        iteration_index <= 0;
        x_i <= i_re;
        y_i <= i_im;
        z_i <= i_angle;
        // pipe push
        // i_res[0]    <= i_re;
        // i_ims[0]    <= i_im;
        // i_angles[0] <= i_angle;

        // pipe shift
        // for (pipe_index = 0; pipe_index < ITERATIONS; pipe_index = pipe_index + 1) begin : pipe_shift
        //   i_res[pipe_index+1] <= i_re[pipe_index];
        // end
      end
    end
  end

  wire done = (iteration_index == ITERATIONS);
  wire add_sub = (z_i < i_angle);  // 1 = add, 0 = sub
  //   wire [POINT_SZ-1:0] tan_i = ((1'b1, {(POINT_SZ - 2) {1'b0}}) >> iteration_index);

  always @(posedge clk) begin
    if (!done) begin
      if (add_sub) begin : add
        x_i <= x_i - (y_i >> iteration_index);
        y_i <= y_i + (x_i >> iteration_index);
        z_i <= z_i + lut_angles[iteration_index];
      end else begin : sub
        x_i <= x_i + (y_i >> iteration_index);
        y_i <= y_i - (x_i >> iteration_index);
        z_i <= z_i - lut_angles[iteration_index];
      end
    end
  end

  assign o_valid = done;

endmodule
