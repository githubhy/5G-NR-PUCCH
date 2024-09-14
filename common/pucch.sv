module pucch (
    input clk,
    input rst,

    input [2:0] i_pucch_format,  // Format 0-4

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

    input [2:0] i_occi,  //! [Format 1] occi < nSF0 with nSF0 = floor(nPUCCHSym/2)

    input [15:0] i_rnti,        //! [Format 2] Radio Network Temporary Identifier (0-65535)
    input [ 1:0] i_uciCW,       //! [Format 2] Encoded UCI codeword as per TS 38.212 Section 6.3.1
    input        i_uciCW_valid, //! [Format 2] uciCW is valid and ready to continue generate PUCCH sequence

    //! The number of resource blocks associated with the PUCCH
    //! format 3 transmission. Nominally the value of MRB will be
    //! one of the set {1,2,3,4,5,6,8,9,10,12,15,16}.
    input [4:0] i_Mrb,          //! [Format 3] 
    input       i_pi2bpsk_qpsk, //! [Format 3] Modulation scheme (1: pi/2 BPSK, 0: QPSK)

    output reg signed [15:0] o_pucch_re,  //! PUCCH sequence complex point's real value at current sequence index (sfix16_En15)
    output reg signed [15:0] o_pucch_im,  //! PUCCH sequence complex point's imaginary value at current sequence index (sfix16_En15)
    output reg               o_valid,     //! Output valid
    output                   o_done       //! Done
);

  // Parameters
  localparam [3:0] nSlotSymb = 14;  //! (cyclic prefix (cp) == 'extended') ? 12 : 14
  localparam [3:0] nRBSC = 12;

  localparam nIRB = 0;
  localparam mint = 5 * nIRB;

  reg [4:0] Mrb;
  always_comb begin
    Mrb = 5'dx;
    case (i_pucch_format)
      0, 1: Mrb = 1;  // Default single-PRB allocation for PUCCH format 0 and 1 is Mrb = 1
      2, 3: Mrb = i_Mrb;
      default: Mrb = 5'dx;
    endcase
  end
  wire [7:0] Msc = Mrb * nRBSC;  // Total number of subcarriers

  // HIGHER MODULE SHOULD MAKE SURE i_symStart + i_nPUCCHSym <= nSlotSymb. THIS MODULE BYPASS THIS CHECKING PROCESS
  wire [3:0] symStart = i_symStart;
  wire [3:0] nPUCCHSym = i_nPUCCHSym;
  wire [2:0] nSF = nPUCCHSym[3:1];  //! nSF = floor(nPUCCHSym/2). nSF range = (2-7) because nPUCCHSym (4-14)

  wire [1:0] ack = i_ack;
  wire [1:0] lenACK = i_lenACK;
  wire       sr = i_sr;
  wire       lenSR = i_lenSR;

  wire [3:0] m0 = i_m0;
  reg  [3:0] mcs;
  always_comb begin
    mcs = 4'bx;
    case (i_pucch_format)
      0: mcs = F0_csTable(ack, lenACK, sr, lenSR);
      1: mcs = 0;
      default: mcs = 4'bx;
    endcase
  end
  wire [ 7:0] nslot = i_nslot;
  wire [ 9:0] nid = i_nid;

  // [Format 1]
  wire [ 2:0] occi = i_occi;

  // [Format 2] nIRB, sf, occi are not supported for Format 2
  wire [15:0] rnti = i_rnti;
  wire [ 1:0] uciCW = i_uciCW;

  // region u, v
  // pucch-GroupHopping = 'neither' =>
  // fgh = 0                                --- Sequence-group hopping patterns
  // fss = nid mod 30                       --- Sequence-group shift offset
  // v   = 0                                --- Base sequence numbers
  // u   = (fgh + fss) mod 30 = nid mod 30  --- Base sequence group numbers
  // ncs = c seq                            --- Hopping/cell identity specific cyclic shifts
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
  // endregion u, v

  // region UCI
  //! Return empty output sequence either for empty inputs or for negative SR transmission only.
  wire       pucch_empty_seq = ((lenACK == 0) && ((lenSR == 0) || (sr == 0)));
  reg  [1:0] uciIn;
  reg  [1:0] lenUCI;

  // Check ack and sr inputs and get the control information
  always_comb begin
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

  reg b_bpsk;  //! Input bit for BPSK modulation
  reg [1:0] b_qpsk;  //! Input bit for QPSK modulation
  always_comb begin
    b_bpsk = 1'dx;
    b_qpsk = 2'dx;
    case (i_pucch_format)
      1: begin
        b_bpsk = uciIn[0];
        b_qpsk = {uciIn[1], uciIn[0]};
      end
      2, 3: begin
        b_qpsk = (uciCW ^ scramble_f2_bit);
      end
      default: begin
        b_bpsk = 1'dx;
        b_qpsk = 2'dx;
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

  wire [4:0] cyc_24_modulation =  //! Format 1's angle coresponds to BPSK or QPSK complex point of UCI data
  (lenUCI == 1) ? d_bpsk :  //
  (lenUCI == 2) ? d_qpsk :  //
  4'bx;
  // endregion PSK modulation

  // region R: FSM
  localparam sIDLE = 0;  //! Waiting for start conditions to be met.
  localparam sSTART_ALPHA = 1;  //! [Format 0, Format 1] Start generating alpha for Format 0, Format 1.
  localparam sNEXT_ALPHA = 2;  //! [Format 0, Format 1] Get the next alpha for PUCCH Format 0, Format 1 sequence generation process
  localparam sGEN_SEQUENCE = 3;  //! [Format 0, Format 1] Generate PUCCH Format 0, Format 1 sequence with current alpha

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
        done_next_alpha   = (alpha_index >= symStart) && (alpha_index[0] == 1);
        done_gen_sequence = (get_alpha >= nSF);
      end
      default: begin
        done_next_alpha   = 0;
        done_gen_sequence = 0;
      end
    endcase
  end

  reg prev_uciCW_valid;

  always @(posedge clk, posedge rst) begin
    if (rst) begin

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
          prev_uciCW_valid <= i_uciCW_valid;
        end
        sDONE: begin

        end
        default: begin
          cstate <= sIDLE;  // some error happended, back to sIDLE
        end
      endcase
    end
  end

  always_comb begin
    // Default values
    nstate            = cstate;
    alpha_start       = 0;
    alpha_get         = 0;

    spread_start      = 0;
    spread_next       = seq_tail;

    // scramble_f2_start = 0;
    scramble_f2_start = i_start;
    scramble_f2_get   = 0;

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
        // scramble_f2_start = i_start;
        scramble_f2_get = i_uciCW_valid;
      end
      sDONE: begin

      end
      default: begin

      end
    endcase
  end

  assign o_done  = (cstate == sDONE);
  assign o_valid = ((cstate == sGEN_SEQUENCE) || ((cstate == sGEN_F2) && prev_uciCW_valid));

  // endregion R: FSM
  reg         scramble_f2_start;
  reg         scramble_f2_get;
  wire [30:0] scramble_f2_init = {rnti, 5'b0, nid};  //! Format 2 scrambling cinit = rnti * 2^15 + nid; (6.3.2.5.1 TS38.211)

  wire [ 1:0] scramble_f2_bit;
  wire        scramble_f2_can_get;
  wire        scramble_f2_valid;
  // region F2 scrambling sequence
  c_seq_gen_control #(
      .nGenBit(2)
  ) scramble_f2 (
      .clk        (clk),
      .rst        (rst),
      .i_start    (scramble_f2_start),
      .i_get      (scramble_f2_get),
      .i_init     (scramble_f2_init),
      .i_threshold(0),

      .o_gen_bit (scramble_f2_bit),
      .o_gen_done(scramble_f2_can_get),
      .o_valid   (scramble_f2_valid)
  );

  // endregion F2 scrambling sequence

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

      .o_wi_phi(spread_wi_phi_cyc_24),
      .o_done(spread_done),
      .o_valid(spread_valid),
      .o_is_supported(spread_is_supported)
  );


  // ALPHA
  reg        alpha_start;
  reg        alpha_get;
  wire       alpha_can_get;
  wire [4:0] alpha_cyc_12;
  wire [4:0] alpha_cyc_24 = (alpha_cyc_12 << 1);
  wire       alpha_valid;
  cyc_12_alpha_generator cyc_12_alpha_generator_dut (
      .clk(clk),
      .rst(rst),

      .i_start(alpha_start),
      .i_get  (alpha_get),

      .i_m0   (m0),
      .i_mcs  (mcs),
      .i_nslot(i_nslot),
      .i_nid  (i_nid),

      .o_can_get     (alpha_can_get),
      .o_cyc_12_alpha(alpha_cyc_12),
      .o_valid       (alpha_valid)
  );

  // BASE SEQ
  wire [ 4:0] base_seq_u = u;
  wire [ 3:0] base_seq_n = seq_index;
  wire [15:0] base_seq_cyc_24;
  cyc_24_base_seq cyc_24_base_seq_dut (
      .i_u(base_seq_u),
      .i_n(base_seq_n),

      .o_cyc_part_24(base_seq_cyc_24)
  );

  // lowPAPRS = Alpha * n + base seq r
  wire [15:0] lowPAPRS_cyc_24 = (alpha_cyc_24 * base_seq_n) + base_seq_cyc_24;

  reg  [15:0] point_cyc_24_no_mod_24;
  always_comb begin
    case (i_pucch_format)
      0: point_cyc_24_no_mod_24 = lowPAPRS_cyc_24;  // x = lowPAPRS
      1: begin
        // z = wi(m) * y(n) = w * d * lowPAPRS
        if (spread_is_supported) point_cyc_24_no_mod_24 = spread_wi_phi_cyc_24 + cyc_24_modulation + lowPAPRS_cyc_24;
        else point_cyc_24_no_mod_24 = 'dx;
      end
      2, 3: point_cyc_24_no_mod_24 = d_qpsk;
      default: begin
        point_cyc_24_no_mod_24 = 16'bx;
      end
    endcase
  end

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
  assign o_pucch_re = point_re;
  assign o_pucch_im = point_im;
  cyc_24 cyc_24_dut (
      .i_point_index(point_cyc_24),
      .o_point_re(point_re),
      .o_point_im(point_im)
  );

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

endmodule
