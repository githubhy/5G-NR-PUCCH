`timescale 1ns / 1ps

module c_seq_gen_control_tb;

  // Parameters
  localparam VCD_FILE = "vcds/c_seq_gen_control_tb.vcd";

  localparam test_init = 512;
  localparam test_threshold = 14 * 3;
  localparam test_get = 1;
  //   localparam test_start_get = 14 * 3 + 10;
  localparam test_start_get = 0;


  initial begin
    begin
      $dumpfile(VCD_FILE);
      $dumpvars;
      reset(3);
      test({16'd56789, 5'd0, 10'd512}, 0, 100);
      nop_clk(10);

      // test(test_init, test_threshold, test_get);
      // nop_clk(10);
      //   test_get_in_between(test_init, test_threshold, test_start_get, test_get);
      //   nop_clk(10);
      // test_get_after_gen_done(test_init, test_threshold, test_start_get, test_get);
      // nop_clk(10);
      $finish;
    end
  end

  /* ncs (nid = 512, nslot = 3)
   239      
   107      
   223      
     6      
    24      
     2      
     3      
    66      
   238      
   125      
   209      
   145      
    44      
   233      
  */


  // Ports
  localparam nGenBit = 2;
  reg clk = 0;
  reg rst = 0;
  reg i_start = 0;
  reg i_get = 0;
  reg [30:0] i_init;
  reg [15:0] i_threshold;
  wire [nGenBit-1:0] o_gen_bit;
  wire o_valid;
  wire o_gen_done;

  c_seq_gen_control #(
      .nGenBit(nGenBit)
  ) c_seq_gen_control_dut (
      .clk(clk),
      .rst(rst),

      .i_start    (i_start),
      .i_get      (i_get),
      .i_init     (i_init),
      .i_threshold(i_threshold),

      .o_gen_bit(o_gen_bit),
      .o_valid   (o_valid),
      .o_gen_done(o_gen_done)
  );

  always @(posedge clk) begin
    if (o_valid) $display("[%3d] o_gen_bit = %3d (%b)", c_seq_gen_control_dut.get_count, o_gen_bit, o_gen_bit);
  end

  task automatic test;
    input integer init;
    input integer threshold;
    input integer get;
    begin
      @(negedge clk);
      i_init      = init;
      i_threshold = threshold;
      i_start     = 1;
      @(negedge clk);
      i_start = 0;
      @(posedge o_valid);
      i_get = 1;
      repeat (get) @(negedge clk);
      i_get = 0;
    end
  endtask  //automatic

  task automatic test_get_in_between;
    input integer init;
    input integer threshold;
    input integer start_get;
    input integer get;
    begin
      $display("test_get_in_between");
      @(negedge clk);
      i_init      = init;
      i_threshold = threshold;

      i_start     = 1;
      @(negedge clk);
      i_start = 0;

      repeat (start_get) @(negedge clk);

      i_get = 1;
      repeat (get) @(negedge clk);
      i_get = 0;
    end
  endtask  //automatic

  task automatic test_get_after_gen_done;
    input integer init;
    input integer threshold;
    input integer start_get;
    input integer get;
    begin
      $display("test_get_after_gen_done");
      @(negedge clk);
      i_init      = init;
      i_threshold = threshold;

      i_start     = 1;
      @(negedge clk);
      i_start = 0;

      @(posedge o_valid);

      // repeat (1) @(posedge clk);

      i_get = 1;
      repeat (2) @(posedge clk);
      i_get = 0;

      repeat (10) @(posedge clk);

      i_get = 1;
      repeat (2) @(posedge clk);
      i_get = 0;
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
  localparam MAX_CLK = 500;

  always @(posedge clk) begin
    clk_count <= clk_count + 1;
    if (clk_count > MAX_CLK) begin
      $display("MAX CLK");
      $finish;
    end
  end

endmodule
