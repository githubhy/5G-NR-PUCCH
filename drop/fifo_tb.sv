`timescale 1ns / 1ps

module fifo_tb;

  // Parameters
  localparam DATA_WIDTH = 8;
  localparam DATA_LENGTH = 10;
  localparam VCD_FILE = "vcds/fifo_tb.vcd";

  // Ports
  reg clk = 0;
  reg rst = 0;
  reg [DATA_WIDTH-1:0] i_data;
  reg i_push = 0;
  reg i_pop = 0;
  wire [DATA_WIDTH-1:0] o_data;
  wire o_valid;
  wire o_full;
  wire o_empty;

  fifo #(
      .DATA_WIDTH (DATA_WIDTH),
      .DATA_LENGTH(DATA_LENGTH)
  ) fifo_dut (
      .clk(clk),
      .rst(rst),
      .i_data(i_data),
      .i_push(i_push),
      .i_pop(i_pop),
      .o_data(o_data),
      .o_valid(o_valid),
      .o_full(o_full),
      .o_empty(o_empty)
  );

  initial begin
    begin
      $dumpfile(VCD_FILE);
      $dumpvars;
      reset(3);
      test();
      nop_clk(10);
      $finish;
    end
  end


  task automatic test;
    begin
      i_push = 1;
      repeat (12) push($urandom);
      repeat (12) pop();
      repeat (8) push($urandom);
      repeat (4) pop();
      repeat (2) push_pop($urandom);
    end
  endtask  //automatic

  task automatic push;
    input integer data;
    begin
      i_data = data;
      i_push = 1;
      @(negedge clk);
      i_push = 0;
    end
  endtask  //automatic

  task automatic pop;
    begin
      i_pop = 1;
      @(negedge clk);
      i_pop = 0;
    end
  endtask  //automatic

  task automatic push_pop;
    input integer data;
    begin
      i_data = data;
      i_push = 1;
      i_pop  = 1;
      @(negedge clk);
      i_push = 0;
      i_pop  = 0;
    end
  endtask  //automatic

  task automatic reset;
    input integer clks;
    begin
      rst = 1;
      repeat (clks) @(negedge clk);
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
