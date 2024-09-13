`timescale 1ns / 1ps

module pucch1_spread_tb;

  // Parameters
  localparam VCD_FILE = "vcds/pucch1_spread_tb.vcd";

  localparam test_nSF = 4;
  localparam test_occi = 3;
  localparam test_get = 10;

  always @(posedge clk) begin
    if (o_valid) $display("nSF = %1d, occi = %1d,  wi_phi(%1d) = %1d", i_nSF, i_occi, pucch1_spread_dut.m, o_wi_phi);
  end

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
    integer nSF;
    integer occi;
    begin
      for (nSF = 1; nSF <= 7; nSF = nSF + 1) begin
        for (occi = 0; occi < nSF; occi = occi + 1) begin
          $display("TEST CASE: nSF = %1d, occi = %1d", nSF, occi);
          test_phi(nSF, occi, nSF);
          $display();
        end
      end
    end
  endtask  //automatic

  task automatic test_phi;
    input integer nSF;
    input integer occi;
    input integer get;
    begin
      @(negedge clk);
      i_nSF   = nSF;
      i_occi  = occi;
      i_start = 1;
      @(negedge clk);
      i_start = 0;
      i_next  = 1;
      repeat (get) @(negedge clk);
      i_next = 0;
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


  // Ports
  reg clk = 0;
  reg rst = 0;
  reg i_start = 0;
  reg i_next = 0;
  reg [2:0] i_nSF;
  reg [2:0] i_occi;
  wire [3:0] o_wi_phi;
  wire o_done;
  wire o_valid;

  pucch1_spread pucch1_spread_dut (
      .clk(clk),
      .rst(rst),

      .i_start(i_start),
      .i_next (i_next),

      .i_nSF (i_nSF),
      .i_occi(i_occi),

      .o_wi_phi(o_wi_phi),
      .o_done  (o_done),
      .o_valid (o_valid)
  );

endmodule
