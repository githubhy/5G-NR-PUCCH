`timescale 1ns / 1ps

`define PULSE #(PULSE_TIME);
`define PRE_PULSE #(CLK_PERIOD/2-PULSE_TIME/2);

module c_seq_gen_tb;

  // Parameters

  localparam nGenBit = 8;

  // (0): nid = 512, nslot = 3, 
  // (1): nid = 100, nslot = 2, 
  // (2): nid = 512, nslot = 0
  // (3): nid = 512
  localparam testCase = 0;


  localparam PRBS_TEST_FILE =  //
  (nGenBit == 1) ?  //

  ((testCase == 0) ? "tb/c_seq_gen/prbs_c_seq_gen_nid512_nslot3_nGenBit1.txt" :  //
  (testCase == 1) ? "tb/c_seq_gen/prbs_c_seq_gen_nid100_nslot2_nGenBit1.txt" :  //
  (testCase == 2) ? "tb/c_seq_gen/prbs_c_seq_gen_nid512_nslot0_nGenBit1.txt" : "") :  //

  (nGenBit == 8) ?  //

  ((testCase == 0) ? "tb/c_seq_gen/prbs_c_seq_gen_nid512_nslot3_nGenBit8.txt" :  //
  (testCase == 1) ? "tb/c_seq_gen/prbs_c_seq_gen_nid100_nslot2_nGenBit8.txt" :  //
  (testCase == 2) ? "tb/c_seq_gen/prbs_c_seq_gen_nid512_nslot0_nGenBit8.txt" : "") :  //

  "";

  localparam NCS_TEST_FILE =  //
  (testCase == 0) ? "tb/c_seq_gen/ncs_c_seq_gen_nid512_nslot3.txt" :  //
  (testCase == 1) ? "tb/c_seq_gen/ncs_c_seq_gen_nid100_nslot2.txt" :  //
  (testCase == 2) ? "tb/c_seq_gen/ncs_c_seq_gen_nid512_nslot0.txt" :  //
  "";

  // input Initial value
  localparam CINIT =  //
  (testCase == 0) ? 512 :  //
  (testCase == 1) ? 100 :  //
  (testCase == 2) ? 512 :  //
  0;

  localparam nslot =  //
  (testCase == 0) ? 3 :  //
  (testCase == 1) ? 2 :  //
  (testCase == 2) ? 0 :  //
  0;

  // nslot: Slot number in radio frame. It is in range 0 to 159 for normal 
  // cyclic prefix for different numerologies. For extended cyclic prefix,
  // it is in range 0 to 39, as specified in TS 38.211 Section 4.3.2.

  localparam nSlotSymb = 14;
  localparam startIndex = nSlotSymb * 8 * nslot;  // Start getting from this index
  localparam N = 14 * 8;  // Number of bits to get
  localparam nBitNeed = startIndex + N;

  // Ports
  reg                clk = 0;
  reg                rst = 0;
  reg                i_en = 0;
  reg                i_load = 0;
  reg  [       30:0] i_init;
  wire [nGenBit-1:0] o_seq_bit;
  wire               o_valid;

  reg  [nGenBit-1:0] o_seq_bit_test[0:(N/nGenBit)-1];
  reg  [        7:0] ncs_test      [      0:(N/8)-1];



  initial begin
    $readmemb(PRBS_TEST_FILE, o_seq_bit_test);
    $readmemh(NCS_TEST_FILE, ncs_test);
  end

  c_seq_gen #(
      .nGenBit(nGenBit)
  ) c_seq_gen_dut (
      .clk(clk),
      .rst(rst),

      .i_en  (i_en),
      .i_load(i_load),
      .i_init(i_init),

      .o_seq_bit(o_seq_bit),
      .o_valid  (o_valid)
  );

  initial begin
    begin
      $dumpfile("vcds/c_seq_gen_tb.vcd");
      $dumpvars;
      reset(3);
      test(CINIT, (nBitNeed / nGenBit));
      // test({16'd56789, 5'b0, 10'd512}, 100);
      #(CLK_PERIOD * 10);

      $finish;
    end
  end

  task automatic test;
    input [30:0] init;
    input integer clks;

    integer nbit;
    integer getbit;
    integer ncs_index;
    integer seq_index;
    reg [7:0] ncs;
    reg pass;
    begin
      nbit = 0;
      getbit = 0;
      ncs_index = 0;
      seq_index = 0;
      pass = 1;
      $display("init = %31b (%1d) in %1d clk cycles", init, init, clks);
      // @(posedge clk);
      i_init = init;
      i_load = 1;
      i_en   = 1;
      @(posedge clk);
      i_load = 0;
      repeat (clks + 1) begin
        // if (o_valid) begin  // begin if
        // $display("[%3d] x1: %b  x2: %b  c: %b", nbit, c_seq_gen_dut.x1_seq_gen_dut.o_seq_bit, c_seq_gen_dut.x2_seq_gen_dut.o_seq_bit, o_seq_bit);
        if (nbit > startIndex) begin
          if (nGenBit == 1) begin
            ncs = {ncs[6:0], o_seq_bit};
          end else if (nGenBit == 8) begin
            ncs = o_seq_bit;
          end

          if (o_seq_bit == o_seq_bit_test[seq_index]) begin
            $display("[%3d] %1b OK", nbit, o_seq_bit);
          end else begin
            $display("[%3d] %1b FAILED! Expected %1d (%b), got %1d (%b)", nbit, o_seq_bit, seq_index, o_seq_bit_test[seq_index], o_seq_bit_test[seq_index], o_seq_bit, o_seq_bit);
            pass = 0;
          end
          seq_index = seq_index + 1;

          if (nGenBit == 1) begin
            if ((getbit + 1) % 8 == 0) begin
              if (ncs == ncs_test[ncs_index]) begin
                $display("ncs = %3d (%b). OK", ncs, ncs);
              end else begin
                $display("ncs = %3d (%b). FAILED! Value missmatch at nsc index = %1d. Expected %1d (%b), got %1d (%b)", ncs, ncs, ncs_index, ncs_test[ncs_index], ncs_test[ncs_index], ncs, ncs);
                pass = 0;
              end
              $display();
              ncs_index = ncs_index + 1;
            end
          end else if (nGenBit == 8) begin
            if (ncs == ncs_test[ncs_index]) begin
              $display("ncs = %3d (%b). OK", ncs, ncs);
            end else begin
              $display("ncs = %3d (%b). FAILED! Value missmatch at nsc index = %1d. Expected %1d (%b), got %1d (%b)", ncs, ncs, ncs_index, ncs_test[ncs_index], ncs_test[ncs_index], ncs, ncs);
              pass = 0;
            end
            $display();
            ncs_index = ncs_index + 1;
          end else begin
            $display("Only support checking ncs with nGenBit = 1 or 8");
          end

          getbit = getbit + nGenBit;
          // end  // end if
        end else begin
          $display("[%3d] %1b (%1d) GEN", nbit, o_seq_bit, o_seq_bit);
        end
        nbit = nbit + nGenBit;
        @(posedge clk);
      end
      i_en = 0;
      $display("[%s] Tested c(n) sequence generator with cinit = %1d, n = %1d. Ref: Matlab nrPRBS Generate PRBS sequence test file.", pass ? "PASSED" : "FAILED", init, clks);
    end
  endtask  //automatic


  task automatic reset;
    input integer clks;
    begin
      rst = 1;
      repeat (clks) begin
        @(posedge clk);
      end
      rst = 0;
    end
  endtask  //automatic

  localparam CLK_PERIOD = 10;
  localparam PULSE_TIME = 2;
  always #(CLK_PERIOD / 2) clk = !clk;

endmodule


