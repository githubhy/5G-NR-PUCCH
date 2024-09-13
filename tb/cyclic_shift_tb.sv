`timescale 1ns / 1ps

module cyclic_shift_tb;

  // Parameters
  localparam VCD_FILE = "vcds/cyclic_shift_tb.vcd";

  // Ports
  reg  [15:0] i_sum_params;
  reg  [ 4:0] i_n;
  wire [15:0] o_cyc_part_24;

  cyclic_shift cyclic_shift_dut (
      .i_sum_params(i_sum_params),
      .i_n(i_n),
      .o_cyc_part_24(o_cyc_part_24)
  );

  initial begin
    begin
      $dumpfile(VCD_FILE);
      $dumpvars;
      $finish;
    end
  end


endmodule
