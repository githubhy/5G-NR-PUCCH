module test ();

  reg  [ 9:0] nid;
  reg  [15:0] rnti;

  wire [30:0] init = ((rnti << 15) + nid);
  wire [30:0] init_concat = {rnti, 5'b0, nid};

  initial begin
    nid = 512;
    rnti = 56789;
    #1;
    $display("nid = %1d (%b), rnti = %1d (%b), init = %d (%b)",  //
             nid, nid, rnti, rnti, init, init);
    $display("nid = %1d (%b), rnti = %1d (%b), init = %d (%b)",  //
             nid, nid, rnti, rnti, init_concat, init_concat);
  end


endmodule
