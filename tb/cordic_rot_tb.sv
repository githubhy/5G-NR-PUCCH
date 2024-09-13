`timescale 1ns / 1ps

`define ICARUS
`define VCD_FILE "vcds/cordic_rot_tb.vcd"

module cordic_rot_tb;

  // Parameters
  localparam CLK_PERIOD = 10;

  localparam ITERATIONS = 16;
  localparam POINT_SZ = 16;
  localparam ANGLE_SZ = 34;

  // Ports
  reg clk = 0;
  reg rst = 0;
  reg [POINT_SZ-1:0] i_re;
  reg [POINT_SZ-1:0] i_im;
  reg [ANGLE_SZ-1:0] i_angle;
  reg i_valid = 0;
  reg i_en = 0;
  wire [POINT_SZ-1:0] o_re;
  wire [POINT_SZ-1:0] o_im;
  wire o_valid;

  cordic_rot cordic_rot_dut (
      .clk(clk),
      .rst(rst),

      .i_re   (i_re),
      .i_im   (i_im),
      .i_angle(i_angle),
      .i_valid(i_valid),
      .i_en   (i_en),

      .o_re   (o_re),
      .o_im   (o_im),
      .o_valid(o_valid)
  );

  initial begin
    begin
      $finish;
    end
  end

  task automatic test_rot;
    input [POINT_SZ-1:0] re;
    input [POINT_SZ-1:0] im;
    input [ANGLE_SZ-1:0] angle;
    begin
      @(negedge clk);
      i_re    = re;
      i_im    = im;
      i_angle = angle;
    end
  endtask  //automatic

  always #(CLK_PERIOD / 2) clk = !clk;

endmodule
