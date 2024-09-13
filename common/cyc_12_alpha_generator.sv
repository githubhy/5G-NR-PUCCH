module cyc_12_alpha_generator (
    input clk,
    input rst,

    input i_start,  //! start a new generation process, must wait for 14 * nslot before start getting alpha
    input i_get,    //! get the next alpha angle coresponds to a point on 12 points complex cycle.

    // region Compute angles

    //! Initial cyclic shift (m_0) which is in range (0...11).
    //! For PUCCH formats 0 and 1, the value is provided by
    //! higher-layer parameter initialCyclicShift. For DMRS on
    //! PUCCH format 3, the value is 0 and for DMRS on format 4
    //! it can be any of 0,3,6,9.
    input [3:0] i_m0,  // (0-11)

    //! Sequence cyclic shift (m_cs) which is in range
    //! (0...11). The value is zero for all PUCCH formats
    //! except PUCCH format 0.
    input [3:0] i_mcs,  // (0-11)

    //! mint = 5 * nIRB for PUCCH formats 0 and 1 if PUCCH shall use interlaced mapping according to any of the
    //! higher-layer parameters useInterlacePUCCH-PUSCH in BWP-UplinkCommon or useInterlacePUCCH-PUSCH in
    //! BWP-UplinkDedicated, where  IRB is the resource block number within the interlace
    // input i_mint,  // Fixed to be 0 because Set resource block indices in the interlace is not supported
    // input [?:0] nIRB, // Fixed to be 0

    //! Slot number in radio frame. It is in range 0 to 159 for
    //! normal cyclic prefix for different numerologies. For
    //! extended cyclic prefix, it is in range 0 to 39, as
    //! specified in TS 38.211 Section 4.3.2.
    input [7:0] i_nslot,  // (0-159)

    //! Scrambling identity. It is in range 0 to 1023 if
    //! higher-layer parameter hoppingId is provided, else, it
    //! is in range 0 to 1007, equal to the physical layer cell
    //! identity NCellID.
    input  [9:0] i_nid,           // (0-1023)
    // endregion Compute angles
    // 
    output       o_can_get,       //! High if alpha is ready to start getting
    output [4:0] o_cyc_12_alpha,
    output       o_valid
);

  localparam [3:0] nRBSC = 12;

  wire [3:0] m0 = i_m0;
  wire [3:0] mcs = i_mcs;
  localparam mint = 0;
  wire [9:0] nid = i_nid;
  wire [7:0] nslot = i_nslot;

  // pucch-GroupHopping = 'neither' =>
  // fgh = 0                                --- Sequence-group hopping patterns
  // fss = nid mod 30                       --- Sequence-group shift offset
  // v   = 0                                --- Base sequence numbers
  // u   = (fgh + fss) mod 30 = nid mod 30  --- Base sequence group numbers
  // ncs = c seq                            --- Hopping/cell identity specific cyclic shifts

  localparam [3:0] nSlotSymb = 14;  //! (cyclic prefix (cp) == 'extended') ? 12 : 14
  localparam v = 0;
  wire [15:0] u;  // u = nid mod 30

  localparam DIVIDER_30 = 30;
  localparam ONE_DIV_DIVIDER_30 = 34'h111111111;

  mod_comb #(
      .DIVIDER        (DIVIDER_30),
      .ONE_DIV_DIVIDER(ONE_DIV_DIVIDER_30)
  ) mod_comb_30 (
      .i_dividend({6'd0, nid}),
      .o_result  (u)
  );

  wire [15:0] threshold = nSlotSymb * nslot;
  wire [ 7:0] ncs;

  c_seq_gen_control c_seq_gen_control_dut (
      .clk(clk),
      .rst(rst),

      .i_start    (i_start),
      .i_get      (i_get),
      .i_init     ({21'b0, nid}),
      .i_threshold(threshold),

      .o_gen_byte(ncs),
      .o_valid   (o_valid),
      .o_gen_done(o_can_get)
  );

  wire [15:0] sum_params = (m0 + mcs + mint + ncs);

  wire [15:0] cyc_12_alpha;  // = (m0 + mcs + mint + ncs) mod 12
  assign o_cyc_12_alpha = cyc_12_alpha;

  localparam DIVIDER_12 = 12;
  localparam ONE_DIV_DIVIDER_12 = 34'h2AAAAAAAA;

  mod_comb #(
      .DIVIDER        (DIVIDER_12),
      .ONE_DIV_DIVIDER(ONE_DIV_DIVIDER_12)
  ) mod_comb_12 (
      .i_dividend(sum_params),
      .o_result  (cyc_12_alpha)
  );


endmodule
