module pucch (
    input clk,
    input rst,

    input [2:0] i_pucch_format,  //! Format 0-4

    input i_start,

    input [3:0] i_symStart,  //! OFDM symbol index corresponding to start of PUCCH (0-13). symStart + nPUCCHSym <= nSlotSymb (12 for cyclic prefix (cp) == 'extended' else 14)
    input [3:0] i_nPUCCHSym, //! Number of symbols allocated for PUCCH (1-2 for Format 0, otherwise 4-14). symStart + nPUCCHSym <= nSlotSymb (12 for cyclic prefix (cp) == 'extended' else 14)

    //! Acknowledgment bits of hybrid automatic repeat request
    //! (HARQ-ACK). It is a column vector of length 0, 1 or 2
    //! HARQ-ACK bits. The bit value of 1 stands for positive
    //! acknowledgment and bit value of 0 stands for negative
    //! acknowledgment.
    input [1:0] i_ack,    //! [ack1, ack0] 00 01 10 11
    input [1:0] i_lenACK, //! (0-2)

    //! Scheduling request (SR). It is a column vector of
    //! length 0 or 1 SR bits. The bit value of 1 stands for
    //! positive SR and bit value of 0 stands for negative SR.
    //! The output SYM is empty when there is only negative SR
    //! transmission. For positive SR with HARQ-ACK information
    //! bits, only HARQ-ACK transmission happens.
    input i_sr,    // 0  1
    input i_lenSR, //! (0-1)

    input [3:0] i_m0,     //! (0-11)    initialCS
    // input [3:0] i_mcs,    //! (0-11)    seqCS
    input [7:0] i_nslot,  //! (0-159)
    input [9:0] i_nid,    //! (0-1023)

    //! [Format 1] occi < nSF0 with nSF0 = floor(nPUCCHSym/2). 
    //! [Format 2 3 4] n0 = occi need to compute (n0 + nIRB) mod sf.
    input [UNKNOWN-1:0] i_occi,

    input [       15:0] i_rnti,         //! [Format 2] Radio Network Temporary Identifier (0-65535)
    input               i_uciCW,        //! [Format 2] Encoded UCI codeword as per TS 38.212 Section 6.3.1
    input               i_uciCW_valid,  //! [Format 2] uciCW is valid and ready to continue generate PUCCH sequence
    input [        2:0] i_sf,           //! [Format 2 3 4] Orthogonal sequences's sf is given by the higher-layer parameter occ-Length. {2,4} for F2, F4 or {1,2,4} for F3
    // input        i_n0,           //! n0 = occi is the index of the orthogonal sequence to use given by the higher-layer parameter occ-Index
    input [UNKNOWN-1:0] i_nIRB,         //! Interlaced Resource Block number as defined in clause 4.4.4.6 within the interlace given by the higher-layer parameter Interlace0.

    input [UNKNOWN-1:0] i_nIRB_arr[0:15],
    input [UNKNOWN-1:0] i_occi_arr[0:15],
    input [        4:0] lenArr,

    //! The number of resource blocks associated with the PUCCH
    //! format 3 transmission. Nominally the value of MRB will be
    //! one of the set {1,2,3,4,5,6,8,9,10,12,15,16}.
    input [4:0] i_Mrb,          //! [Format 3] 
    input       i_pi2bpsk_qpsk, //! [Format 3] Modulation scheme (1: pi/2 BPSK, 0: QPSK)

    output reg signed [15:0] o_pucch_re[0:3],  //! PUCCH sequence complex point's real value at current sequence index (sfix16_En15)
    output reg signed [15:0] o_pucch_im[0:3],  //! PUCCH sequence complex point's imaginary value at current sequence index (sfix16_En15)
    output reg               o_valid,          //! Output valid
    output                   o_done            //! Done
);

  localparam UNKNOWN = 16;  // Unknow number of bits, need to fix

  // Parameters
  localparam [3:0] nSlotSymb = 14;  //! (cyclic prefix (cp) == 'extended') ? 12 : 14
  localparam [3:0] nRBSC = 12;  //! Number of subcarriers per Resource Block
  localparam [3:0] nRE = 8;  //! Number of RE per PRB available for PUCCH

  reg [UNKNOWN-1:0] nIRB;  // = 0;
  always_comb begin : sel_nIRB
    case (i_pucch_format)
      0, 1:    nIRB = 0;  // = 0 for F0, F1
      2, 3, 4: nIRB = i_nIRB;
      default: nIRB = 0;
    endcase
  end
  wire mint = 5 * nIRB;

  reg [4:0] Mrb;
  always_comb begin : sel_Mrb
    case (i_pucch_format)
      0, 1:    Mrb = 1;  // Default single-PRB allocation for PUCCH format 0 and 1 is Mrb = 1 if no nIRB is provied (which is not used)
      2, 3:    Mrb = i_Mrb;  // F2 F3 support 
      4:       Mrb = 1;
      default: Mrb = 5'dx;
    endcase
  end

  //! Select coresponds nIRB and occi in nIRB_arr and occi_arr
  //! wn_index = 0,1,...,lenArr-1
  reg [4:0] wn_index;

  //! nRepeat = nRE/sf with nRE = 8
  //! Repeat nRepeat times of a wn for the current modulation symbol d
  reg [2:0] nRepeat;
  always_comb begin : sel_nRepeat
    case (sf)
      2:       nRepeat = 4;
      4:       nRepeat = 2;
      default: nRepeat = 0;
    endcase
  end

  reg [7:0] Msc;  //! Total number of subcarriers
  always_comb begin : sel_Msc
    case (i_pucch_format)
      0, 1:    Msc = Mrb * nRBSC;
      2, 3, 4: Msc = Mrb * nRE;
      default: Msc = 5'dx;
    endcase
  end

  // HIGHER MODULE SHOULD MAKE SURE i_symStart + i_nPUCCHSym <= nSlotSymb. THIS MODULE BYPASS THIS CHECKING PROCESS
  wire [3:0] symStart = i_symStart;
  wire [3:0] nPUCCHSym = i_nPUCCHSym;
  wire [2:0] nSF = nPUCCHSym[3:1];  //! nSF = floor(nPUCCHSym/2). nSF range = (2-7) because nPUCCHSym (4-14)

  wire [1:0] ack = i_ack;
  wire [1:0] lenACK = i_lenACK;
  wire       sr = i_sr;
  wire       lenSR = i_lenSR;

  wire [3:0] m0 = i_m0;

  //! mcs = 0 except for PUCCH format 0 when it depends on the information to be transmitted according to clause 9.2 of [5, TS 38.213].
  reg  [3:0] mcs;
  always_comb begin : sel_mcs
    case (i_pucch_format)
      0:          mcs = F0_csTable(ack, lenACK, sr, lenSR);
      1, 2, 3, 4: mcs = 0;
      default:    mcs = 4'bx;
    endcase
  end
  wire [7:0] nslot = i_nslot;
  wire [9:0] nid = i_nid;

  // [Format 1]
  wire [UNKNOWN-1:0] occi = i_occi;

  // [Format 2] nIRB, sf, occi are not supported for Format 2
  wire [15:0] rnti = i_rnti;
  wire [1:0] uciCW = i_uciCW;
  wire [2:0] sf = i_sf;
  wire [UNKNOWN-1:0] n0 = i_occi;

  // region u, v
  // pucch-GroupHopping = 'neither' =>
  // fgh = 0                                --- Sequence-group hopping patterns
  // fss = nid mod 30                       --- Sequence-group shift offset
  // v   = 0                                --- Base sequence numbers
  // u   = (fgh + fss) mod 30 = nid mod 30  --- Base sequence group numbers
  // ncs = c seq                            --- Hopping/cell identity specific cyclic shifts
  localparam v = 0;  //! v = 0 (pucch-GroupHopping = 'neither')
  wire [15:0] u;  //! u = nid mod 30 (pucch-GroupHopping = 'neither')

  localparam DIVIDER_30 = 30;
  localparam ONE_DIV_DIVIDER_30 = 34'h111111111;

  mod_comb #(
      .DIVIDER        (DIVIDER_30),
      .ONE_DIV_DIVIDER(ONE_DIV_DIVIDER_30)
  ) mod_comb_30 (
      .i_dividend({6'd0, nid}),
      .o_result  (u)
  );
  // endregion u, v

  // region UCI
  //! Return empty output sequence either for empty inputs or for negative SR transmission only.
  wire       pucch_empty_seq = ((lenACK == 0) && ((lenSR == 0) || (sr == 0)));
  reg  [1:0] uciIn;
  reg  [1:0] lenUCI;

  // Check ack and sr inputs and get the control information
  always_comb begin : sel_UCI
    // Default values
    uciIn  = 0;
    lenUCI = 0;
    if (!pucch_empty_seq) begin
      if (lenACK == 0) begin  // Positive SR transmission
        uciIn  = 0;
        lenUCI = 1;
      end else begin  // HARQ-ACK transmission with/without SR
        uciIn  = ack;
        lenUCI = lenACK;
      end
    end
  end
  // endregion UCI

  // region PSK modulation
  localparam CYC_DIV = 24;

  reg       b_bpsk;  //! Input bit for BPSK modulation
  reg       b_pi2bpsk;  //! Input bit for Pi/2 BPSK modulation
  reg       pi2bpsk_lsb;  //! Input index lsb for Pi/2 BPSK modulation
  reg [1:0] b_qpsk;  //! Input bit for QPSK modulation
  always_comb begin : sel_modulation_input
    case (i_pucch_format)
      1: begin
        b_bpsk = uciIn[0];
        b_qpsk = {uciIn[1], uciIn[0]};
      end
      2: begin
        // b_qpsk = btilde;
        b_qpsk = scrambler_scrambed_2bit;
      end
      3, 4: begin
        pi2bpsk_lsb = index_odd;
        if (i_pi2bpsk_qpsk) b_pi2bpsk = scrambler_scrambed_bit;
        else b_qpsk = scrambler_scrambed_2bit;
        // else b_qpsk = btilde;
      end
      default: begin
        b_bpsk      = 1'dx;
        b_pi2bpsk   = 1'dx;
        pi2bpsk_lsb = 1'dx;
        b_qpsk      = 2'dx;
      end
    endcase
  end

  wire [4:0] d_bpsk;  //! Output angle coresponds to BPSK complex point
  bpsk_cyc #(
      .CYC_DIV(CYC_DIV)
  ) bpsk_cyc_24 (
      .i_b       (b_bpsk),
      .o_cyc_part(d_bpsk)
  );

  wire [4:0] d_qpsk;  //! Output angle coresponds to QPSK complex point
  qpsk_cyc #(
      .CYC_DIV(CYC_DIV)
  ) qpsk_cyc_24 (
      .i_b       (b_qpsk),
      .o_cyc_part(d_qpsk)
  );

  wire [4:0] d_pi2bpsk;  //! Output angle coresponds to pi/2-BPSK complex point
  pi2bpsk_cyc #(
      .CYC_DIV(CYC_DIV)
  ) pi2bpsk_cyc_dut (
      .i_b        (b_pi2bpsk),
      .i_index_lsb(pi2bpsk_lsb),
      .o_cyc_part (d_pi2bpsk)
  );


  reg [4:0] cyc_24_modulation;  //! Format 1's angle coresponds to BPSK or QPSK complex point of UCI data
  always_comb begin : sel_modulation_output
    case (i_pucch_format)
      1: begin
        case (lenUCI)
          1: cyc_24_modulation = d_bpsk;
          2: cyc_24_modulation = d_qpsk;
          default: cyc_24_modulation = 5'dx;
        endcase
      end
      2: begin
        cyc_24_modulation = d_qpsk;
      end
      3, 4: begin
        if (i_pi2bpsk_qpsk) begin
          cyc_24_modulation = d_pi2bpsk;
        end else begin
          cyc_24_modulation = d_qpsk;
        end
      end
      default: begin

      end
    endcase
  end
  // endregion PSK modulation

  // region R: FSM
  localparam sIDLE = 0;  //! Waiting for start conditions to be met.

  // F0 F1
  localparam sSTART_ALPHA = 1;  //! [Format 0, Format 1] Start generating alpha for Format 0, Format 1.
  localparam sNEXT_ALPHA = 2;  //! [Format 0, Format 1] Get the next alpha for PUCCH Format 0, Format 1 sequence generation process
  localparam sGEN_SEQUENCE = 3;  //! [Format 0, Format 1] Generate PUCCH Format 0, Format 1 sequence with current alpha

  // F2 F3
  localparam sGEN_F2 = 10;  //! [Format 2] Generate PUCCH Format 2 sequence with provied uciCW.

  localparam sDONE = 15;

  reg [3:0] cstate, nstate;

  reg [15:0] alpha_index;  // alpha index 0,1,...,nSlotSymb-1
  reg [15:0] get_alpha;  // get alpha 0,1,...,nSF-1
  reg [15:0] seq_index;  // n 0,1,2,...,nRBSC-1

  //! [F0 F1 supported] high when conditions to get next alpha are met
  //! (F0: get alpha at the next index, F1: get alpha at the next odd index)
  reg done_next_alpha;
  //! [F0 F1 supported] high when conditions to stop PUCCH sequence generation proceess are met
  //! (generation enough sequence with alphas {F0: from index 0 to nPUCCHSym-1},
  //! {F1: nSF = floor(nPUCCHSym/2) odd indexes from index 0 to nPUCCHSym-1})
  reg done_gen_sequence;
  //! High when sequence index at the end of the sequence (n == nRBSC-1)
  wire seq_tail = (seq_index == nRBSC - 1);
  always_comb begin
    case (i_pucch_format)
      0: begin
        done_next_alpha   = (alpha_index >= symStart);
        done_gen_sequence = (get_alpha >= nPUCCHSym);
      end
      1: begin
        done_next_alpha   = (alpha_index >= symStart) && (alpha_index[0] != symStart[0]);
        done_gen_sequence = (get_alpha >= nSF);
      end
      default: begin
        done_next_alpha   = 0;
        done_gen_sequence = 0;
      end
    endcase
  end

  reg index_odd;

  always @(posedge clk, posedge rst) begin : fsm_seq
    if (rst) begin
      alpha_index <= 0;
      get_alpha   <= 0;
      seq_index   <= 0;
      index_odd   <= 0;
    end else begin
      cstate <= nstate;

      case (cstate)
        sIDLE: begin

        end
        sSTART_ALPHA: begin
          alpha_index <= 0;
          get_alpha   <= 0;
        end
        sNEXT_ALPHA: begin
          if (alpha_valid) begin
            alpha_index <= alpha_index + 1;
            seq_index   <= 0;
            if (done_next_alpha) get_alpha <= get_alpha + 1;
          end
        end
        sGEN_SEQUENCE: begin
          seq_index <= seq_index + 1;
        end
        sGEN_F2: begin
          case (i_pucch_format)
            3, 4: begin
              if (i_pi2bpsk_qpsk) begin
                if (scrambler_scrambed_bit_valid) index_odd <= !index_odd;
              end else begin
                if (scrambler_scrambed_2bit_valid) index_odd <= !index_odd;
              end
            end
            default: begin

            end
          endcase
          // index_odd <= !index_odd;
        end
        sDONE: begin

        end
        default: begin
          cstate <= sIDLE;  // some error happended, back to sIDLE
        end
      endcase
    end
  end

  // initial begin
  //   $monitor("%1b", clk);
  // end

  always_comb begin : fsm_comb
    // Default values
    nstate       = cstate;
    alpha_start  = 0;
    alpha_get    = 0;

    spread_start = 0;
    spread_next  = seq_tail;


    case (cstate)
      sIDLE: begin
        if (i_start) begin
          case (i_pucch_format)
            0, 1: nstate = (pucch_empty_seq ? sDONE : sSTART_ALPHA);
            2, 3: nstate = sGEN_F2;
            default: nstate = cstate;
          endcase
        end
      end
      sSTART_ALPHA: begin
        nstate = sNEXT_ALPHA;
        alpha_start = 1;
        spread_start = 1;
      end
      sNEXT_ALPHA: begin
        alpha_get = 1;

        if (alpha_valid) begin
          if (done_next_alpha) begin
            nstate = sGEN_SEQUENCE;
            alpha_get = 0;
          end
        end
      end
      sGEN_SEQUENCE: begin
        if (seq_index >= nRBSC - 1) begin
          nstate = done_gen_sequence ? sDONE : sNEXT_ALPHA;
        end
      end
      sGEN_F2: begin
        // if (scrambler_done) nstate = sDONE;
      end
      sDONE: begin

      end
      default: begin

      end
    endcase
  end

  assign o_done = (cstate == sDONE);
  // reg o_valid;  // = ((cstate == sGEN_SEQUENCE));
  always_comb begin
    case (i_pucch_format)
      0, 1: begin
        o_valid = (cstate == sGEN_SEQUENCE);
      end
      2: begin
        o_valid = scrambler_scrambed_2bit_valid;
      end
      3, 4: begin
        o_valid = i_pi2bpsk_qpsk ? scrambler_scrambed_bit_valid : scrambler_scrambed_2bit_valid;
      end
      default: begin

      end
    endcase
  end

  // endregion R: FSM

  // region angles (F0 F1 alpha, F0 F1 base seq, F1 spreading (orthogonal))

  // SPREADING
  reg spread_start;
  reg spread_next;

  wire [4:0] spread_wi_phi_cyc_24;
  wire spread_done;
  wire spread_valid;
  wire spread_is_supported;
  cyc_24_pucch1_spread cyc_24_spread_dut (
      .clk(clk),
      .rst(rst),

      .i_start(spread_start),
      .i_next (spread_next),
      .i_nSF  (nSF),
      .i_occi (occi),

      .o_wi_phi      (spread_wi_phi_cyc_24),
      .o_done        (spread_done),
      .o_valid       (spread_valid),
      .o_is_supported(spread_is_supported)
  );

  // SCRAMBLING
  wire       scrambler_start;
  wire       scrambler_get;
  wire [7:0] scrambler_byte = c_seq_gen_byte;
  // wire       scrambler_valid = c_seq_gen_valid;
  // wire       scramble_done = c_seq_gen_done;
  wire       scrambler_scrambed_bit;
  wire       scrambler_scrambed_bit_valid;
  wire [1:0] scrambler_scrambed_2bit;
  wire       scrambler_scrambed_2bit_valid;

  wire       scrambler_valid;
  wire       scrambler_done;

  // output reg o_scrambled_bit,
  // output reg o_scrambled_bit_valid,

  // output     [1:0] o_scrambled_2bit,
  // output reg       o_scrambled_2bit_valid,
  scrambler scrambler_dut (
      .clk(clk),
      .rst(rst),

      .i_start(i_start),
      .i_uciCW(i_uciCW),
      .i_uciCW_valid(i_uciCW_valid),

      .o_scramble_start(scrambler_start),
      .o_scramble_get  (scrambler_get),
      .i_scramble_byte (scrambler_byte),
      .i_scramble_valid(scrambler_valid),
      // .i_scramble_done (scramble_done),

      .o_scrambled_bit      (scrambler_scrambed_bit),
      .o_scrambled_bit_valid(scrambler_scrambed_bit_valid),

      .o_scrambled_2bit      (scrambler_scrambed_2bit),
      .o_scrambled_2bit_valid(scrambler_scrambed_2bit_valid),

      .o_valid(scrambler_valid),
      .o_done (scrambler_done)
  );


  // region C SEQ GEN
  reg  [15:0] c_seq_gen_threshold;  // = nSlotSymb * nslot;
  reg         c_seq_gen_start;  // = alpha_start;
  reg         c_seq_gen_get;  // = alpha_get;
  reg  [30:0] c_seq_gen_cinit;
  wire [ 7:0] c_seq_gen_byte;
  wire        c_seq_gen_valid;
  wire        c_seq_gen_done;
  always_comb begin
    case (i_pucch_format)
      0, 1: begin
        c_seq_gen_cinit     = {21'b0, nid};
        c_seq_gen_threshold = nSlotSymb * nslot;
        c_seq_gen_start     = alpha_start;
        c_seq_gen_get       = alpha_get;
      end
      2, 3, 4: begin
        c_seq_gen_cinit     = {rnti, 5'd0, nid};
        c_seq_gen_threshold = 0;
        c_seq_gen_start     = scrambler_start;
        c_seq_gen_get       = scrambler_get;
      end
      default: begin

      end
    endcase
  end

  c_seq_gen_control #(
      .nGenBit(8)
  ) c_seq_gen_control_dut (
      .clk(clk),
      .rst(rst),

      .i_start    (c_seq_gen_start),
      .i_get      (c_seq_gen_get),
      .i_init     (c_seq_gen_cinit),
      .i_threshold(c_seq_gen_threshold),

      .o_gen_bit (c_seq_gen_byte),
      .o_valid   (c_seq_gen_valid),
      .o_gen_done(c_seq_gen_done)
  );
  // endregion C SEQ GEN

  // region ALPHA
  reg         alpha_start;
  reg         alpha_get;
  wire        alpha_can_get = c_seq_gen_done;
  wire        alpha_valid = c_seq_gen_valid;

  wire [ 7:0] ncs = c_seq_gen_byte;
  wire [15:0] sum_params = (m0 + mcs + mint + ncs);

  wire [15:0] alpha_cyc_12;  // = (m0 + mcs + mint + ncs) mod 12
  wire [15:0] alpha_cyc_24 = (alpha_cyc_12 << 1);

  localparam DIVIDER_12 = 12;
  localparam ONE_DIV_DIVIDER_12 = 34'h2AAAAAAAA;
  mod_comb #(
      .DIVIDER        (DIVIDER_12),
      .ONE_DIV_DIVIDER(ONE_DIV_DIVIDER_12)
  ) mod_comb_12 (
      .i_dividend(sum_params),
      .o_result  (alpha_cyc_12)
  );
  // endregion ALPHA

  // region BASE SEQ
  wire [ 4:0] base_seq_u = u;
  wire [ 3:0] base_seq_n = seq_index;
  wire [15:0] base_seq_cyc_24;
  cyc_24_base_seq cyc_24_base_seq_dut (
      .i_u(base_seq_u),
      .i_n(base_seq_n),

      .o_cyc_part_24(base_seq_cyc_24)
  );
  // endregion BASE SEQ

  // lowPAPRS = Alpha * n + base seq r
  wire [15:0] lowPAPRS_cyc_24 = (alpha_cyc_24 * base_seq_n) + base_seq_cyc_24;

  // reg  [15:0] point_cyc_24_no_mod_24;
  always_comb begin : sel_cyc_24_input
    case (i_pucch_format)
      0: gen_parallel_pucch_234[0].point_cyc_24_no_mod_24 = lowPAPRS_cyc_24;  // x = lowPAPRS
      1: begin
        // z = wi(m) * y(n) = w * d * lowPAPRS
        if (spread_is_supported) gen_parallel_pucch_234[0].point_cyc_24_no_mod_24 = spread_wi_phi_cyc_24 + cyc_24_modulation + lowPAPRS_cyc_24;
        else gen_parallel_pucch_234[0].point_cyc_24_no_mod_24 = 'dx;
      end
      2, 3, 4: begin
        gen_parallel_pucch_234[0].point_cyc_24_no_mod_24 = cyc_24_modulation + spread_wn_cyc_24[0];
        gen_parallel_pucch_234[1].point_cyc_24_no_mod_24 = cyc_24_modulation + spread_wn_cyc_24[1];
        gen_parallel_pucch_234[2].point_cyc_24_no_mod_24 = cyc_24_modulation + spread_wn_cyc_24[2];
        gen_parallel_pucch_234[3].point_cyc_24_no_mod_24 = cyc_24_modulation + spread_wn_cyc_24[3];
      end
      3: gen_parallel_pucch_234[0].point_cyc_24_no_mod_24 = cyc_24_modulation;  // + ((12 * 24) - (dft_k * dft_n * 2));
      default: begin
        gen_parallel_pucch_234[0].point_cyc_24_no_mod_24 = 16'bx;
      end
    endcase
  end

  reg [2:0] spread_wn_i;
  reg [5*4-1:0] spread_wn_i_cyc_24;
  wire [4:0] spread_wn_cyc_24[0:3];
  always_comb begin
    case (i_pucch_format)
      2:       spread_wn_i_cyc_24 = F2_orthogonal(sf, n0, nIRB);
      3, 4:    spread_wn_i_cyc_24 = F34_blockWiseSpreading(sf, occi);
      default: spread_wn_i_cyc_24 = 16'dz;
    endcase
  end

  genvar wn_i_index;
  for (wn_i_index = 0; wn_i_index < 4; wn_i_index = wn_i_index + 1) begin : gen_parallel_pucch_234
    assign spread_wn_cyc_24[wn_i_index] = spread_wn_i_cyc_24[(wn_i_index+1)*5-1:wn_i_index*5];


    reg [15:0] point_cyc_24_no_mod_24;

    localparam DIVIDER_24 = 24;
    localparam ONE_DIV_DIVIDER_24 = 34'h155555555;
    mod_comb #(
        .DIVIDER        (DIVIDER_24),
        .ONE_DIV_DIVIDER(ONE_DIV_DIVIDER_24)
    ) mod_comb_24 (
        .i_dividend(point_cyc_24_no_mod_24),
        .o_result  (point_cyc_24)
    );
    // endregion angles (alpha, base seq, spreading (orthogonal))


    // region complex value
    wire        [ 4:0] point_cyc_24;
    wire signed [15:0] point_re;
    wire signed [15:0] point_im;
    cyc_24 cyc_24_dut (
        .i_point_index(point_cyc_24),
        .o_point_re(point_re),
        .o_point_im(point_im)
    );

    assign o_pucch_re[wn_i_index] = point_re;
    assign o_pucch_im[wn_i_index] = point_im;

  end  // end gen_parallel_pucch_234

  // endregion complex value

  //!  ```
  //!  % Get the possible cyclic shift values for the length of ack input
  //!  csTable = getCyclicShiftTable(lenACK);
  //!
  //!  % Get the sequence cyclic shift based on ack and sr inputs
  //!  if lenACK==0
  //!      seqCS = csTable(1,1);
  //!  elseif (lenSR==0) || (sr(1) ==0)
  //!      uciValue = comm.internal.utilities.convertBit2Int(ack,lenACK);
  //!      seqCS = csTable(1,uciValue+1);
  //!  else
  //!      uciValue = comm.internal.utilities.convertBit2Int(ack,lenACK);
  //!      seqCS = csTable(2,uciValue+1);
  //!  end
  //!  
  //!  function csTable = getCyclicShiftTable(len)
  //!  %   csTable = getCyclicShiftTable(LEN) provides the possible sequence
  //!  %   cyclic shift values based on the length LEN.
  //!  
  //!      if len == 1
  //!          csTable = [0 6;
  //!                     3 9];
  //!      else
  //!          csTable = [0 3  9 6;
  //!                     1 4 10 7];
  //!      end
  //!  
  //!  end
  //!  ```
  //!
  function [3:0] F0_csTable;
    input [1:0] ack;
    input [1:0] lenACK;
    input sr;
    input lenSR;
    begin
      if (lenACK == 0) begin  // lenACK == 0
        F0_csTable = 0;
      end else if ((lenSR == 0) || (sr == 0)) begin
        if (lenACK == 1) begin  // lenACK == 1
          case (ack[0])
            0: F0_csTable = 0;
            1: F0_csTable = 6;
            default: F0_csTable = 4'bx;
          endcase
        end else begin  // lenACK == 2
          case ({
            ack[0], ack[1]
          })
            0: F0_csTable = 0;
            1: F0_csTable = 3;
            2: F0_csTable = 9;
            3: F0_csTable = 6;
            default: F0_csTable = 4'bx;
          endcase
        end
      end else begin
        if (lenACK == 1) begin  // lenACK == 1
          case (ack[0])
            0: F0_csTable = 3;
            1: F0_csTable = 9;
            default: F0_csTable = 4'bx;
          endcase
        end else begin  // lenACK == 2
          case ({
            ack[0], ack[1]
          })
            0: F0_csTable = 1;
            1: F0_csTable = 4;
            2: F0_csTable = 10;
            3: F0_csTable = 7;
            default: F0_csTable = 4'bx;
          endcase
        end
      end
    end
  endfunction

  //! return orthogonal sequence wn(i) (cyc_24) at index i
  //! 
  //! function wn = spreadingSequence(sf,occi)
  //! spreadingSequence Orthogonal spreading sequence for PUCCH format 2
  //! 
  //!    Note: This is an internal undocumented function and its API and/or
  //!    functionality may change in subsequent releases.
  //! 
  //!    WN = spreadingSequence(SF,OCCI) returns the orthogonal cover code
  //!    spreading sequence, WN, according to TS 38.211 Tables 6.3.2.5A-1 and
  //!    6.3.2.5A-2 for these inputs.
  //!      SF   - Spreading factor. It must be either 2 or 4
  //!      OCCI - Orthogonal cover code sequence index. It must be greater than
  //!             or equal to zero and less than SF
  //!     if sf == 2
  //!         % TS 38.211 6.3.2.5A-1
  //!         w = [+1 +1;  % OCCI equals 0
  //!              +1 -1]; % OCCI equals 1
  //!     else
  //!         % TS 38.211 Table 6.3.2.5A-2
  //!         w = [+1 +1 +1 +1;  % OCCI equals 0
  //!              +1 -1 +1 -1;  % OCCI equals 1
  //!              +1 +1 -1 -1;  % OCCI equals 2
  //!              +1 -1 -1 +1]; % OCCI equals 3
  //!     end
  //!     
  //!     % Extract the orthogonal cover code sequence based on the orthogonal
  //!     % cover code index
  //!     wn = w(occi+1,:);
  //! 
  //! end
  function [5*4-1:0] F2_orthogonal;
    input [2:0] sf;  // sf = {2,4} for F2,F4 or {1,2,4} for F3
    input [1:0] n0;  // occi last 2 bits
    input [1:0] nIRB;  // nIRB last 2 bits
    reg [1:0] n;
    begin
      // n = (n0 + nIRB) mod sf
      n = (n0 + nIRB);
      if (sf == 2) n = {1'b0, n[0]};  // mod 2
      // else n = n; // mod 4

      // $display("n mod sf = n mod %1d = %1d", sf, n);

      case (sf)
        0:       F2_orthogonal = {5'dz, 5'dz, 5'dz, 5'd00};  // Disabled
        // 1:       F2_orthogonal = {5'dz, 5'dz, 5'd00, 5'd00};
        2: begin
          case (n)
            0: F2_orthogonal = {5'dz, 5'dz, 5'd00, 5'd00};
            1: F2_orthogonal = {5'dz, 5'dz, 5'd12, 5'd00};
            default: F2_orthogonal = 20'dz;
          endcase
        end
        4: begin
          case (n)
            0:       F2_orthogonal = {5'd00, 5'd00, 5'd00, 5'd00};
            1:       F2_orthogonal = {5'd12, 5'd00, 5'd12, 5'd00};
            2:       F2_orthogonal = {5'd12, 5'd12, 5'd00, 5'd00};
            3:       F2_orthogonal = {5'd00, 5'd12, 5'd12, 5'd00};
            default: F2_orthogonal = 20'dz;
          endcase
        end
        default: F2_orthogonal = 20'dz;
      endcase
    end
  endfunction

  function [5*4-1:0] F34_blockWiseSpreading;
    input [2:0] sf;
    input [2:0] occi;
    begin
      case (sf)
        0: F34_blockWiseSpreading = {5'dx, 5'dx, 5'dx, 5'd0};  //! Disabled
        1: F34_blockWiseSpreading = {5'dx, 5'dx, 5'dx, 5'd0};  //! Disabled
        2: begin
          case (occi)
            0: F34_blockWiseSpreading = {5'dx, 5'dx, 5'd0, 5'd0};
            1: F34_blockWiseSpreading = {5'dx, 5'dx, 5'd12, 5'd0};
            default: F34_blockWiseSpreading = 20'dz;
          endcase
        end
        4: begin
          case (occi)
            0: F34_blockWiseSpreading = {5'd00, 5'd00, 5'd00, 5'd00};
            1: F34_blockWiseSpreading = {5'd06, 5'd12, 5'd18, 5'd00};
            2: F34_blockWiseSpreading = {5'd12, 5'd00, 5'd12, 5'd00};
            3: F34_blockWiseSpreading = {5'd18, 5'd12, 5'd06, 5'd0};
            default: F34_blockWiseSpreading = 20'dz;
          endcase
        end
        default: F34_blockWiseSpreading = 20'dz;
      endcase
    end
  endfunction

  // reg [4*4-1:0] f2;
  // initial begin
  //   f2 = F2_orthogonal(4, 39, 17);
  //   $write("%2d ", f2[3:0]);
  //   $write("%2d ", f2[7:4]);
  //   $write("%2d ", f2[11:8]);
  //   $write("%2d ", f2[15:12]);
  //   $display();
  // end

endmodule
