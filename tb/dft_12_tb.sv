`timescale 1ns / 1ps


/*
  angle_offset = 0                              angle_offset = 12
    0.000000000000000 - 1.414213562373095i       -2.828427124746190 + 1.414213562373095i
  -1.086044163149559 + 4.053171996137779i        1.931851652578137 - 1.931851652578137i
    0.189468690981506 - 3.156596523969726i        5.277916867529369 + 0.000000000000000i
  -2.828427124746190 - 1.414213562373095i       -1.414213562373095 + 0.000000000000000i
    1.224744871391589 - 3.535533905932738i        3.863703305156274 - 0.378937381963012i
  -5.985023648715917 + 1.603682253354601i       -0.517638090205042 + 0.517638090205042i
  -2.828427124746190 + 1.414213562373095i        2.828427124746190 + 4.242640687119286i
  -0.707106781186548 - 0.189468690981506i       -0.517638090205042 - 3.346065214951232i
  -1.224744871391589 - 3.535533905932738i       -1.035276180410083 - 5.277916867529369i
    2.828427124746190 - 1.414213562373095i       -1.414213562373095 - 2.828427124746191i
    2.638958433764684 + 1.742382961596631i        0.378937381963012 + 0.000000000000000i
  -0.707106781186548 - 2.638958433764684i        1.931851652578137 - 0.896575472168054i

  div by sqrt(Mrb)
    0.000000000000000 - 0.408248290463863i -0.816496580927726 + 0.408248290463863i
  -0.313513944973110 + 1.170049971521000i  0.557677535825205 - 0.557677535825205i
    0.054694899870589 - 0.911230926418479i  1.523603362114274 + 0.000000000000000i
  -0.816496580927726 - 0.408248290463863i -0.408248290463863 + 0.000000000000000i
    0.353553390593274 - 1.020620726159658i  1.115355071650411 - 0.109389799741179i
  -1.727727507346206 + 0.462943190334452i -0.149429245361342 + 0.149429245361342i
  -0.816496580927726 + 0.408248290463863i  0.816496580927726 + 1.224744871391589i
  -0.204124145231932 - 0.054694899870589i -0.149429245361342 - 0.965925826289068i
  -0.353553390593274 - 1.020620726159658i -0.298858490722684 - 1.523603362114274i
    0.816496580927726 - 0.408248290463863i -0.408248290463863 - 0.816496580927726i
    0.761801681057137 + 0.502982635954616i  0.109389799741179 + 0.000000000000000i
  -0.204124145231932 - 0.761801681057137i  0.557677535825205 - 0.258819045102521i
*/

/*
xtilde0
 -0.707106781186548 - 0.707106781186548i  0.707106781186548 - 0.707106781186548i
  0.707106781186548 - 0.707106781186548i -0.707106781186548 + 0.707106781186548i
 -0.707106781186548 + 0.707106781186548i  0.707106781186548 + 0.707106781186548i
 -0.707106781186548 - 0.707106781186548i -0.707106781186548 - 0.707106781186548i
 -0.707106781186548 + 0.707106781186548i -0.707106781186548 + 0.707106781186548i
 -0.707106781186548 - 0.707106781186548i -0.707106781186548 - 0.707106781186548i
  0.707106781186548 - 0.707106781186548i  0.707106781186548 + 0.707106781186548i
  0.707106781186548 + 0.707106781186548i -0.707106781186548 + 0.707106781186548i
  0.707106781186548 - 0.707106781186548i -0.707106781186548 + 0.707106781186548i
  0.707106781186548 - 0.707106781186548i -0.707106781186548 - 0.707106781186548i
 -0.707106781186548 + 0.707106781186548i -0.707106781186548 + 0.707106781186548i
  0.707106781186548 + 0.707106781186548i  0.707106781186548 - 0.707106781186548i

xtilde0_fft
  0.000000000000000 - 1.414213562373095i -2.828427124746190 + 1.414213562373095i
 -1.086044163149559 + 4.053171996137779i  1.931851652578137 - 1.931851652578137i
  0.189468690981506 - 3.156596523969726i  5.277916867529369 + 0.000000000000000i
 -2.828427124746190 - 1.414213562373095i -1.414213562373095 + 0.000000000000000i
  1.224744871391589 - 3.535533905932738i  3.863703305156274 - 0.378937381963012i
 -5.985023648715917 + 1.603682253354601i -0.517638090205042 + 0.517638090205042i
 -2.828427124746190 + 1.414213562373095i  2.828427124746190 + 4.242640687119286i
 -0.707106781186548 - 0.189468690981506i -0.517638090205042 - 3.346065214951232i
 -1.224744871391589 - 3.535533905932738i -1.035276180410083 - 5.277916867529369i
  2.828427124746190 - 1.414213562373095i -1.414213562373095 - 2.828427124746191i
  2.638958433764684 + 1.742382961596631i  0.378937381963012 + 0.000000000000000i
 -0.707106781186548 - 2.638958433764684i  1.931851652578137 - 0.896575472168054i

out
  0.000000000000000 - 0.408248290463863i -0.816496580927726 + 0.408248290463863i
 -0.313513944973110 + 1.170049971521000i  0.557677535825205 - 0.557677535825205i
  0.054694899870589 - 0.911230926418479i  1.523603362114274 + 0.000000000000000i
 -0.816496580927726 - 0.408248290463863i -0.408248290463863 + 0.000000000000000i
  0.353553390593274 - 1.020620726159658i  1.115355071650411 - 0.109389799741179i
 -1.727727507346206 + 0.462943190334452i -0.149429245361342 + 0.149429245361342i
 -0.816496580927726 + 0.408248290463863i  0.816496580927726 + 1.224744871391589i
 -0.204124145231932 - 0.054694899870589i -0.149429245361342 - 0.965925826289068i
 -0.353553390593274 - 1.020620726159658i -0.298858490722684 - 1.523603362114274i
  0.816496580927726 - 0.408248290463863i -0.408248290463863 - 0.816496580927726i
  0.761801681057137 + 0.502982635954616i  0.109389799741179 + 0.000000000000000i
 -0.204124145231932 - 0.761801681057137i  0.557677535825205 - 0.258819045102521i
*/

module dft_12_tb;

  // Parameters
  localparam VCD_FILE = "vcds/dft_12_tb.vcd";
  localparam ANGLE_FILE = "tb/dft/cyc_24_angle.txt";
  localparam RE_FILE = "tb/dft/xtilde0_re.txt";
  localparam IM_FILE = "tb/dft/xtilde0_im.txt";
  localparam DFT_RE_FILE = "tb/dft/xtilde0_fft_im.txt";
  localparam DFR_IM_FILE = "tb/dft/xtilde0_fft_im.txt";

  reg [15:0] test_angle[0:23];
  initial begin
    $readmemh(ANGLE_FILE, test_angle);
  end

  // Ports
  reg         clk = 0;
  reg         rst = 0;
  wire signed [15:0] i_re = cyc_24_re;
  wire signed [15:0] i_im = cyc_24_im;
  reg         i_start = 0;
  wire [ 4:0] o_k;
  wire [ 4:0] o_n;
  wire signed [15+12:0] o_re;
  wire signed [15+12:0] o_im;
  wire        o_done_one;
  wire        o_done_all;
  wire        o_valid;

  reg prev_done_one;
  // region sqrt
  localparam signed [17:0] ONE_DIV_SQRT_MRB = 18'h0093cd;  // 1/sqrt(Mrb) sfix18_En17
  wire signed [15+12+18:0] sqrt_o_re = o_re * ONE_DIV_SQRT_MRB;
  wire signed [15+12+18:0] sqrt_o_im = o_im * ONE_DIV_SQRT_MRB;

  // endregion sqrt
  wire real real_o_re = o_re;
  wire real real_o_im = o_im;
  wire real real_sqrt_o_re = sqrt_o_re; //$signed(sqrt_o_re);
  wire real real_sqrt_o_im = sqrt_o_im; //$signed(sqrt_o_im);
  always @(posedge clk ) begin
    prev_done_one <= o_done_one;
    if(prev_done_one) begin
      // $display("sqrt_o_re = o_re * ONE_DIV_SQRT_MRB = %d (%h) * %d (%h) = %d (%h)", o_re, o_re, ONE_DIV_SQRT_MRB, (ONE_DIV_SQRT_MRB), sqrt_o_re, sqrt_o_re);
      // $display("xtilde0_fft = %8.4f + %8.4fi", real_o_re / (2**15), real_o_im / (2**15));
      $display("out = %8.4f + %8.4fi", (real_sqrt_o_re / (2**15) / (2**17)), real_sqrt_o_im / (2**15) / (2**17));
    end
    // $display("xtilde0 = %8.4f + %8.4fi", cyc_24_modulation_re / (2**15), cyc_24_modulation_im / (2**15));
  end

  dft_12 dft_12_dut (
      .clk(clk),
      .rst(rst),

      .i_re(i_re),
      .i_im(i_im),
      .i_start(i_start),

      .o_k (o_k),
      .o_n (o_n),
      .o_re(o_re),
      .o_im(o_im),

      .o_done_one(o_done_one),
      .o_done_all(o_done_all),
      .o_valid   (o_valid)
  );

  wire integer angle_index = o_n;
  integer angle_offset; // TEST ONLY
  wire [15:0] cyc_24_modulation_angle = test_angle[angle_index + angle_offset];

  wire [7:0] kn = o_k * o_n;
  wire [15:0] cyc_24_kn = kn * 2;
  wire [15:0] mod24_dividend = cyc_24_modulation_angle + (24 * 12 - cyc_24_kn);
  wire [15:0] mod24_result;

  localparam DIVIDER = 24;
  localparam ONE_DIV_DIVIDER = 34'h155555555;
  mod_comb #(
      .DIVIDER        (DIVIDER),
      .ONE_DIV_DIVIDER(ONE_DIV_DIVIDER)
  ) mod_comb_dut (
      .i_dividend(mod24_dividend),
      .o_result  (mod24_result)
  );

  wire [ 4:0] cyc_24_point = mod24_result[4:0];
  wire signed [15:0] cyc_24_re;
  wire signed [15:0] cyc_24_im;

  cyc_24 cyc_24_dut (
      .i_point_index(cyc_24_point),
      .o_point_re   (cyc_24_re),
      .o_point_im   (cyc_24_im)
  );

  wire [ 4:0] cyc_24_modulation_point = cyc_24_modulation_angle;
  wire real cyc_24_modulation_re;
  wire real cyc_24_modulation_im;

  cyc_24 cyc_24_modulation_dut (
      .i_point_index(cyc_24_modulation_point),
      .o_point_re   (cyc_24_modulation_re),
      .o_point_im   (cyc_24_modulation_im)
  );


  initial begin
    begin
      $dumpfile(VCD_FILE);
      $dumpvars;
      reset(3);
      test(0); // angle_offset = 12 or 0
      nop_clk(20);
      $finish;
    end
  end

  task automatic test;
    input integer input_angle_offset;
    begin
      angle_offset = input_angle_offset;

      @(negedge clk);

      i_start = 1;
      @(negedge clk);
      i_start = 0;

      repeat(12*12) begin
        @(posedge clk);
      end

      // repeat (20) @(posedge clk);

      // i_start = 1;
      // @(negedge clk);
      // i_start = 0;

      @(posedge o_done_all);
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
