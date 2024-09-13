`timescale 1ns / 1ps

/* PUCCH1
Base seq cyc 24
    15
     9
     9
     3
    15
     9
    21
     3
     9
    15
     9
    15

## PUCCH 1 y = d * r

### nPUCCHSym = 4
PUCCH1 d + alpha * n + r = ( 3 +  8 *  0 + 15) mod 24 = 18. (00.0000 + -1.0000i)       0.0000 - 1.0000i
PUCCH1 d + alpha * n + r = ( 3 +  8 *  1 +  9) mod 24 = 20. (00.5000 + -0.8660i)       0.5000 - 0.8660i
PUCCH1 d + alpha * n + r = ( 3 +  8 *  2 +  9) mod 24 =  4. (00.5000 + 00.8660i)       0.5000 + 0.8660i
PUCCH1 d + alpha * n + r = ( 3 +  8 *  3 +  3) mod 24 =  6. (00.0000 + 01.0000i)       0.0000 + 1.0000i
PUCCH1 d + alpha * n + r = ( 3 +  8 *  4 + 15) mod 24 =  2. (00.8660 + 00.5000i)       0.8660 + 0.5000i
PUCCH1 d + alpha * n + r = ( 3 +  8 *  5 +  9) mod 24 =  4. (00.5000 + 00.8660i)       0.5000 + 0.8660i
PUCCH1 d + alpha * n + r = ( 3 +  8 *  6 + 21) mod 24 =  0. (01.0000 + 00.0000i)       1.0000 - 0.0000i
PUCCH1 d + alpha * n + r = ( 3 +  8 *  7 +  3) mod 24 = 14. (-0.8660 + -0.5000i)      -0.8660 - 0.5000i
PUCCH1 d + alpha * n + r = ( 3 +  8 *  8 +  9) mod 24 =  4. (00.5000 + 00.8660i)       0.5000 + 0.8660i
PUCCH1 d + alpha * n + r = ( 3 +  8 *  9 + 15) mod 24 = 18. (00.0000 + -1.0000i)      -0.0000 - 1.0000i
PUCCH1 d + alpha * n + r = ( 3 +  8 * 10 +  9) mod 24 = 20. (00.5000 + -0.8660i)       0.5000 - 0.8660i
PUCCH1 d + alpha * n + r = ( 3 +  8 * 11 + 15) mod 24 = 10. (-0.8660 + 00.5000i)      -0.8660 + 0.5000i
PUCCH1 d + alpha * n + r = ( 3 + 22 *  0 + 15) mod 24 = 18. (00.0000 + -1.0000i)       0.0000 - 1.0000i
PUCCH1 d + alpha * n + r = ( 3 + 22 *  1 +  9) mod 24 = 10. (-0.8660 + 00.5000i)      -0.8660 + 0.5000i
PUCCH1 d + alpha * n + r = ( 3 + 22 *  2 +  9) mod 24 =  8. (-0.5000 + 00.8660i)      -0.5000 + 0.8660i
PUCCH1 d + alpha * n + r = ( 3 + 22 *  3 +  3) mod 24 =  0. (01.0000 + 00.0000i)       1.0000 - 0.0000i
PUCCH1 d + alpha * n + r = ( 3 + 22 *  4 + 15) mod 24 = 10. (-0.8660 + 00.5000i)      -0.8660 + 0.5000i
PUCCH1 d + alpha * n + r = ( 3 + 22 *  5 +  9) mod 24 =  2. (00.8660 + 00.5000i)       0.8660 + 0.5000i
PUCCH1 d + alpha * n + r = ( 3 + 22 *  6 + 21) mod 24 = 12. (-1.0000 + 00.0000i)      -1.0000 + 0.0000i
PUCCH1 d + alpha * n + r = ( 3 + 22 *  7 +  3) mod 24 = 16. (-0.5000 + -0.8660i)      -0.5000 - 0.8660i
PUCCH1 d + alpha * n + r = ( 3 + 22 *  8 +  9) mod 24 = 20. (00.5000 + -0.8660i)       0.5000 - 0.8660i
PUCCH1 d + alpha * n + r = ( 3 + 22 *  9 + 15) mod 24 =  0. (01.0000 + 00.0000i)       1.0000 - 0.0000i
PUCCH1 d + alpha * n + r = ( 3 + 22 * 10 +  9) mod 24 = 16. (-0.5000 + -0.8660i)      -0.5000 - 0.8660i
PUCCH1 d + alpha * n + r = ( 3 + 22 * 11 + 15) mod 24 = 20. (00.5000 + -0.8660i)       0.5000 - 0.8660i
*/

/* PUCCH0
PUCCH 0. [symStart nPUCCHSym] = [ 2  2]
ack = 2 (2 bit), sr = 1 (1 bit)
m0, nslot, nid = 5, 3, 512
occi = 0

PUCCH0 alpha * n + r = (14 *  0 + 15) mod 24 = 15. (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
PUCCH0 alpha * n + r = (14 *  1 +  9) mod 24 = 23. (00.9659 + -0.2588i)        0.9659 - 0.2588i
PUCCH0 alpha * n + r = (14 *  2 +  9) mod 24 = 13. (-0.9659 + -0.2588i)       -0.9659 - 0.2588i
PUCCH0 alpha * n + r = (14 *  3 +  3) mod 24 = 21. (00.7071 + -0.7071i)        0.7071 - 0.7071i
PUCCH0 alpha * n + r = (14 *  4 + 15) mod 24 = 23. (00.9659 + -0.2588i)        0.9659 - 0.2588i
PUCCH0 alpha * n + r = (14 *  5 +  9) mod 24 =  7. (-0.2588 + 00.9659i)       -0.2588 + 0.9659i
PUCCH0 alpha * n + r = (14 *  6 + 21) mod 24 =  9. (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
PUCCH0 alpha * n + r = (14 *  7 +  3) mod 24 =  5. (00.2588 + 00.9659i)        0.2588 + 0.9659i
PUCCH0 alpha * n + r = (14 *  8 +  9) mod 24 =  1. (00.9659 + 00.2588i)        0.9659 + 0.2588i
PUCCH0 alpha * n + r = (14 *  9 + 15) mod 24 = 21. (00.7071 + -0.7071i)        0.7071 - 0.7071i
PUCCH0 alpha * n + r = (14 * 10 +  9) mod 24 =  5. (00.2588 + 00.9659i)        0.2588 + 0.9659i
PUCCH0 alpha * n + r = (14 * 11 + 15) mod 24 =  1. (00.9659 + 00.2588i)        0.9659 + 0.2588i
PUCCH0 alpha * n + r = (12 *  0 + 15) mod 24 = 15. (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
PUCCH0 alpha * n + r = (12 *  1 +  9) mod 24 = 21. (00.7071 + -0.7071i)        0.7071 - 0.7071i
PUCCH0 alpha * n + r = (12 *  2 +  9) mod 24 =  9. (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
PUCCH0 alpha * n + r = (12 *  3 +  3) mod 24 = 15. (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
PUCCH0 alpha * n + r = (12 *  4 + 15) mod 24 = 15. (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
PUCCH0 alpha * n + r = (12 *  5 +  9) mod 24 = 21. (00.7071 + -0.7071i)        0.7071 - 0.7071i
PUCCH0 alpha * n + r = (12 *  6 + 21) mod 24 = 21. (00.7071 + -0.7071i)        0.7071 - 0.7071i
PUCCH0 alpha * n + r = (12 *  7 +  3) mod 24 = 15. (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
PUCCH0 alpha * n + r = (12 *  8 +  9) mod 24 =  9. (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
PUCCH0 alpha * n + r = (12 *  9 + 15) mod 24 =  3. (00.7071 + 00.7071i)        0.7071 + 0.7071i
PUCCH0 alpha * n + r = (12 * 10 +  9) mod 24 =  9. (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
PUCCH0 alpha * n + r = (12 * 11 + 15) mod 24 =  3. (00.7071 + 00.7071i)        0.7071 + 0.7071i
*/

// PUCCH 0 get nPUCCHSym(1-2) of alpha(s), starting from symStart(0-10)

module pucch_tb;

  // Parameters
  localparam VCD_FILE = "vcds/pucch_tb.vcd";

  localparam test_pucch_format = 0;

  localparam test_symStart = 2;
  localparam test_nPUCCHSym = 2;  // nPUCCHSym = 5 => nSF = floor(nPUCCHSym/2) = 2

  localparam test_ack = 3;
  localparam test_lenACK = 2;
  localparam test_sr = 1;
  localparam test_lenSR = 1;

  localparam test_m0 = 5;
  //   localparam test_mcs = 0;
  localparam test_nslot = 3;
  localparam test_nid = 512;

  localparam test_occi = 0;

  initial begin
    begin
      $dumpfile(VCD_FILE);
      $dumpvars;
      reset(3);
      test(test_pucch_format,  //
           test_symStart, test_nPUCCHSym,  //
           test_ack, test_lenACK, test_sr, test_lenSR,  //
           test_m0, test_nslot, test_nid,  //
           test_occi);
      $finish;
      nop_clk(100);
    end
  end

  always @(posedge clk) begin
    if (o_valid) begin
        case (i_pucch_format)
            0: begin
                $display("PUCCH0 alpha * n + r = (%2d * %2d + %2d) mod 24 = %2d. (%07.4f + %07.4fi)",  //
               pucch_dut.alpha_cyc_24, pucch_dut.base_seq_n, pucch_dut.base_seq_cyc_24, pucch_dut.point_cyc_24,//
               o_pucch_re / (2**15), o_pucch_im / (2**15));
            end
            1: begin
                $display("PUCCH1 d + alpha * n + r = (%2d + %2d * %2d + %2d) mod 24 = %2d. (%07.4f + %07.4fi)",  //
               pucch_dut.cyc_24_modulation, pucch_dut.alpha_cyc_24, pucch_dut.base_seq_n, pucch_dut.base_seq_cyc_24, pucch_dut.point_cyc_24,//
               o_pucch_re / (2**15), o_pucch_im / (2**15));
            end
            default: begin
                
            end
        endcase
    end
    if(o_done) begin
        nop_clk(10);
        $finish;
    end
  end

  task automatic test;
    input integer pucch_format;
    input integer symStart, nPUCCHSym;
    input integer ack, lenACK, sr, lenSR;
    input integer m0, nslot, nid;
    input integer occi;
    begin
      @(negedge clk);
      i_pucch_format = pucch_format;
      i_symStart     = symStart;
      i_nPUCCHSym    = nPUCCHSym;
      i_ack          = ack;
      i_lenACK       = lenACK;
      i_sr           = sr;
      i_lenSR        = lenSR;
      i_m0           = m0;
      //   i_mcs          = mcs;
      i_nslot        = nslot;
      i_nid          = nid;
      i_occi         = occi;

      i_start        = 1;
      @(negedge clk);
      i_start = 0;

      @(posedge o_done);
      $display();
      $display("PUCCH %1d. [symStart nPUCCHSym] = [%2d %2d]", pucch_format, symStart, symStart);
      $display("ack = %1d (%1d bit), sr = %1d (%1d bit)", ack, lenACK, sr, lenSR);
      $display("m0, nslot, nid = %1d, %1d, %1d", m0, nslot, nid);
      $display("occi = %1d", occi);
      $display("mcs = %1d", pucch_dut.mcs);
    end
  endtask  //automatic

  // Ports
  reg clk = 0;
  reg rst = 0;
  reg [2:0] i_pucch_format;
  reg i_start = 0;
  reg [3:0] i_symStart;
  reg [3:0] i_nPUCCHSym;
  reg [1:0] i_ack;
  reg [1:0] i_lenACK;
  reg i_sr;
  reg i_lenSR;
  reg [3:0] i_m0;
//   reg [3:0] i_mcs;
  reg [7:0] i_nslot;
  reg [9:0] i_nid;
  reg [2:0] i_occi;
  wire real o_pucch_re;
  wire real o_pucch_im;
  wire o_valid;
  wire o_done;

  pucch pucch_dut (
      .clk(clk),
      .rst(rst),

      .i_pucch_format(i_pucch_format),

      .i_start(i_start),

      .i_symStart (i_symStart),
      .i_nPUCCHSym(i_nPUCCHSym),

      .i_ack   (i_ack),
      .i_lenACK(i_lenACK),
      .i_sr    (i_sr),
      .i_lenSR (i_lenSR),

      .i_m0   (i_m0),
      //   .i_mcs  (i_mcs),
      .i_nslot(i_nslot),
      .i_nid  (i_nid),

      .i_occi(i_occi),

      .o_pucch_re(o_pucch_re),
      .o_pucch_im(o_pucch_im),
      .o_valid   (o_valid),
      .o_done    (o_done)
  );

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
