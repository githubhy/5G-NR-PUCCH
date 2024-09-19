module pucch_tb ();





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

      .i_rnti       (i_rnti),
      .i_uciCW      (i_uciCW),
      .i_uciCW_valid(i_uciCW_valid),

      .i_Mrb(i_Mrb),
      .i_pi2bpsk_qpsk(i_pi2bpsk_qpsk),

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

  function real to_real;
    input integer i_int;
    begin
      to_real = i_int;
    end
  endfunction

endmodule
