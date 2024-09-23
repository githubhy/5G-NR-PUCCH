/*
  atan(1/(2^0))/(2*pi) = 0.125000 (00010000000000000000)
  atan(1/(2^1))/(2*pi) = 0.073792 (00001001011100100000)
  atan(1/(2^2))/(2*pi) = 0.038990 (00000100111111011010)
  atan(1/(2^3))/(2*pi) = 0.019792 (00000010100010001001)
  atan(1/(2^4))/(2*pi) = 0.009934 (00000001010001011000)
  atan(1/(2^5))/(2*pi) = 0.004972 (00000000101000101111)
  atan(1/(2^6))/(2*pi) = 0.002487 (00000000010100011000)
  atan(1/(2^7))/(2*pi) = 0.001243 (00000000001010001100)
  atan(1/(2^8))/(2*pi) = 0.000622 (00000000000101000110)
  atan(1/(2^9))/(2*pi) = 0.000311 (00000000000010100011)
*/


module cordic_rot (
    input clk,
    input rst,

    input signed [POINT_SZ-1:0] i_re,     //! sfix16_En15
    input signed [POINT_SZ-1:0] i_im,     //! sfix16_En15
    input signed [ANGLE_SZ-1:0] i_angle,  //! sfix20_En19
    input                       i_valid,
    input                       i_en,

    output signed [POINT_SZ-1:0] o_re,    //! sfix16_En15
    output signed [POINT_SZ-1:0] o_im,    //! sfix16_En15
    output                       o_valid
);

  localparam ITERATIONS = 10;
  localparam POINT_SZ = 16;
  localparam ANGLE_SZ = 20;

  reg [POINT_SZ-1:0] x_i;  // re
  reg [POINT_SZ-1:0] y_i;  // im
  reg [ANGLE_SZ-1:0] z_i;  // angle

  localparam COUNTER_SZ = $clog2(ITERATIONS);
  reg [COUNTER_SZ-1:0] iteration_index;


  wire signed [ANGLE_SZ-1:0] lut_angles[0:ITERATIONS-1];  // sfix34_En30

  assign lut_angles[00] = 'sb00010000000000000000;  // atan(1/(2^0))/(2*pi) = 0.125000 (00010000000000000000)
  assign lut_angles[01] = 'sb00001001011100100000;  // atan(1/(2^1))/(2*pi) = 0.073792 (00001001011100100000)
  assign lut_angles[02] = 'sb00000100111111011010;  // atan(1/(2^2))/(2*pi) = 0.038990 (00000100111111011010)
  assign lut_angles[03] = 'sb00000010100010001001;  // atan(1/(2^3))/(2*pi) = 0.019792 (00000010100010001001)
  assign lut_angles[04] = 'sb00000001010001011000;  // atan(1/(2^4))/(2*pi) = 0.009934 (00000001010001011000)
  assign lut_angles[05] = 'sb00000000101000101111;  // atan(1/(2^5))/(2*pi) = 0.004972 (00000000101000101111)
  assign lut_angles[06] = 'sb00000000010100011000;  // atan(1/(2^6))/(2*pi) = 0.002487 (00000000010100011000)
  assign lut_angles[07] = 'sb00000000001010001100;  // atan(1/(2^7))/(2*pi) = 0.001243 (00000000001010001100)
  assign lut_angles[08] = 'sb00000000000101000110;  // atan(1/(2^8))/(2*pi) = 0.000622 (00000000000101000110)
  assign lut_angles[09] = 'sb00000000000010100011;  // atan(1/(2^9))/(2*pi) = 0.000311 (00000000000010100011)

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
      end else begin
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
  end

  wire done = (iteration_index == ITERATIONS);
  wire add_sub = (z_i < i_angle);  // 1 = add, 0 = sub
  //   wire [POINT_SZ-1:0] tan_i = ((1'b1, {(POINT_SZ - 2) {1'b0}}) >> iteration_index);

  assign o_valid = done;
  assign o_re = x_i;
  assign o_im = y_i;

endmodule
