`timescale 1ns / 1ps

/*
    MATLAB          testbench
    4.0000      [ 0] alpha =  4/12 cyc
    4.0000      [ 1] alpha =  4/12 cyc
         0      [ 2] alpha =  0/12 cyc
   11.0000      [ 3] alpha = 11/12 cyc
    5.0000      [ 4] alpha =  5/12 cyc
    7.0000      [ 5] alpha =  7/12 cyc
    8.0000      [ 6] alpha =  8/12 cyc
   11.0000      [ 7] alpha = 11/12 cyc
    3.0000      [ 8] alpha =  3/12 cyc
   10.0000      [ 9] alpha = 10/12 cyc
   10.0000      [10] alpha = 10/12 cyc
    6.0000      [11] alpha =  6/12 cyc
    1.0000      [12] alpha =  1/12 cyc
   10.0000      [13] alpha = 10/12 cyc
*/

module cyc_12_alpha_generator_tb;

  // Parameters
  localparam VCD_FILE = "vcds/cyc_12_alpha_generator_tb.vcd";

  localparam test_m0 = 5;
  localparam test_mcs = 0;
  localparam test_nslot = 3;
  localparam test_nid = 512;

  // Ports
  reg        clk = 0;
  reg        rst = 0;
  reg        i_start = 0;
  reg        i_get = 0;
  reg  [3:0] i_m0;
  reg  [3:0] i_mcs;
  reg  [7:0] i_nslot;
  reg  [9:0] i_nid;
  wire       o_can_get;
  wire [4:0] o_cyc_12_alpha;
  wire       o_valid;

  cyc_12_alpha_generator cyc_12_alpha_generator_dut (
      .clk(clk),
      .rst(rst),
      .i_start(i_start),
      .i_get(i_get),
      .i_m0(i_m0),
      .i_mcs(i_mcs),
      .i_nslot(i_nslot),
      .i_nid(i_nid),
      .o_can_get(o_can_get),
      .o_cyc_12_alpha(o_cyc_12_alpha),
      .o_valid(o_valid)
  );

  initial begin
    begin
      $dumpfile(VCD_FILE);
      $dumpvars;
      reset(3);
      test(test_m0, test_mcs, test_nslot, test_nid);
      nop_clk(100);
      $finish;
    end
  end

  always @(posedge clk) begin
    if (o_valid) $display("[%2d] alpha = %2d/12 cyc", cyc_12_alpha_generator_dut.c_seq_gen_control_dut.get_count, o_cyc_12_alpha);
  end

  task automatic test;
    input integer m0;
    input integer mcs;
    input integer nslot;
    input integer nid;
    begin
      @(negedge clk);
      i_m0    = m0;
      i_mcs   = mcs;
      i_nslot = nslot;
      i_nid   = nid;

      i_start = 1;
      @(negedge clk);
      i_start = 0;

      @(posedge o_valid);

      //   repeat (2) @(posedge clk);

      i_get = 1;
      repeat (14 - 1) @(posedge clk);
      i_get = 0;

      //   repeat (10) @(posedge clk);

      //   i_get = 1;
      //   repeat (2) @(posedge clk);
      //   i_get = 0;
    end
  endtask  //automatic

  task automatic reset;
    input integer clks;
    begin
      rst = 1;
      repeat (clks) @(posedge clk);
      rst = 0;
    end
  endtask  //automatic

  task automatic nop_clk;
    input integer clks;
    begin
      repeat (clks) @(posedge clk);
    end
  endtask  //automatic

  localparam CLK_PERIOD = 10;
  always #(CLK_PERIOD / 2) clk <= !clk;

  integer clk_count = 0;
  localparam MAX_CLK = 200;

  always @(posedge clk) begin
    clk_count <= clk_count + 1;
    if (clk_count > MAX_CLK) begin
      $display("MAX CLK");
      $finish;
    end
  end

endmodule
