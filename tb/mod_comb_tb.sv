`timescale 1ns / 1ps


module mod_comb_tb;

  localparam mod = 24;

  // Parameters
  localparam CLK_PERIOD = 10;
  localparam I_TEST_FILE = "tb/mod_comb/input.txt";
  localparam O_TEST_FILE =  //
  (mod == 12) ? "tb/mod_comb/mod_12_output.txt" :  //
  (mod == 30) ? "tb/mod_comb/mod_30_output.txt" :  //
  (mod == 24) ? "tb/mod_comb/mod_24_output.txt" :  //
  "";

  localparam DIVIDER =  //
  (mod == 12) ? 12 :  //
  (mod == 30) ? 30 :  //
  (mod == 24) ? 24 : 0;

  localparam ONE_DIV_DIVIDER =  //
  (mod == 12) ? 34'h2AAAAAAAA :  //
  (mod == 30) ? 34'h111111111 :  //
  (mod == 24) ? 34'h155555555 :  //
  0;

  // Ports
  reg [15:0] i_dividend;
  wire [15:0] o_result;

  reg [15:0] i_test[0:(2**16)-1];
  reg [15:0] o_test[0:(2**16)-1];

  initial begin
    $readmemh(I_TEST_FILE, i_test);
    $readmemh(O_TEST_FILE, o_test);

    $dumpfile("vcds/mod_comb_tb.vcd");
    $dumpvars;
  end

  mod_comb #(
      .DIVIDER(DIVIDER),
      .ONE_DIV_DIVIDER(ONE_DIV_DIVIDER)
  ) mod_comb_dut (
      .i_dividend(i_dividend),
      .o_result  (o_result)
  );

  integer i;
  reg ok;
  initial begin
    begin
      ok = 1;
      for (i = 0; i < (2 ** 16); i = i + 1) begin
        i_dividend = i_test[i];
        #CLK_PERIOD;
        if (o_result == o_test[i]) begin
          $display("[  OK  ] %d mod %1d = %d", i_dividend, DIVIDER, o_result);
        end else begin
          ok = 0;
          $display("[FAILED] %d mod %1d = %d", i_dividend, DIVIDER, o_result);
        end
      end
      $display("%s", ok ? "PASSED" : "FAILED");
      $finish;
    end
  end


endmodule
