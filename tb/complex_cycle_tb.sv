`timescale 1ns / 1ps
`define VCD_FILE "vcds/complex_cycle_tb.vcd"
`define i_point_index_test_file "tb/complex_cycle/complex_cycle_i.txt"
`define o_point_re_test_file "tb/complex_cycle/complex_cycle_o_re.txt"
`define o_point_im_test_file "tb/complex_cycle/complex_cycle_o_im.txt"

module complex_cycle_tb;

  // Parameters

  // Ports
  reg         [ 4:0] i_point_index;  // unit 0-23
  wire signed [15:0] o_point_re;     // sfix16_En15
  wire signed [15:0] o_point_im;     // sfix16_En15

  complex_cycle complex_cycle_dut (
      .i_point_index(i_point_index),
      .o_point_re   (o_point_re),
      .o_point_im   (o_point_im)
  );

  reg [ 4:0] i_point_index_test [0:23];
  reg [15:0] o_point_re_test    [0:23];
  reg [15:0] o_point_im_test    [0:23];

  wire real point_re = o_point_re;
  wire real point_im = o_point_im;

  integer point_index;
  reg pass;

  initial begin
    $dumpfile(`VCD_FILE);
    $dumpvars;
    $readmemh(`i_point_index_test_file, i_point_index_test);
    $readmemb(`o_point_re_test_file, o_point_re_test);
    $readmemb(`o_point_im_test_file, o_point_im_test);
    // Begin test 0-23 point index
    pass = 1;
    for (point_index = 0; point_index < 24; point_index = point_index + 1) begin
        i_point_index = point_index;
        #1;
        if((o_point_re != o_point_re_test[point_index]) || (o_point_im != o_point_im_test[point_index])) begin
            $display("Failed at %d index", point_index);
            pass = 0;
        end
        $display("%02d/24 of a cycle => %1.4f + j%2.4f", i_point_index, point_re / (2 ** 15), point_im / (2 ** 15));
    end
    $display("[%s] Tested all 24 points", pass ? "PASSED" : "FAILED");
    $finish;
  end


endmodule
