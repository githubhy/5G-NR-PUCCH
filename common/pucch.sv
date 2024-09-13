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

    input [2:0] i_occi,  //! (0-nSF0 - 1) with nSF0 = floor(nPUCCHSym/2)

    output reg signed [15:0] o_pucch_re,  // sfix16_En15
    output reg signed [15:0] o_pucch_im,  // sfix16_En15
    output reg o_valid,
    output o_done
);

  // Parameters
  localparam nIRB = 0;
  localparam mint = 5 * nIRB;
  localparam Mrb = 1;  // Interlacing is not supported! Default single-PRB allocation for PUCCH format 0 and 1 is Mrb = 1
  localparam Msc = Mrb * 12;  // Total number of subcarriers

  localparam [3:0] nSlotSymb = 14;  //! (cyclic prefix (cp) == 'extended') ? 12 : 14
  localparam [3:0] nRBSC = 12;

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
  wire [7:0] nslot = i_nslot;
  wire [9:0] nid = i_nid;

  wire [2:0] occi = i_occi;

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

  wire [4:0] d_bpsk;
  bpsk_cyc #(
      .CYC_DIV(CYC_DIV)
  ) bpsk_cyc_24 (
      .i_b(uciIn[0]),
      .o_cyc_part(d_bpsk)
  );

  wire [4:0] d_qpsk;
  qpsk_cyc #(
      .CYC_DIV(CYC_DIV)
  ) qpsk_cyc_24 (
      .i_b({uciIn[0], uciIn[1]}),
      .o_cyc_part(d_qpsk)
  );

  wire [4:0] cyc_24_modulation =  //
  (lenUCI == 1) ? d_bpsk :  //
  (lenUCI == 2) ? d_qpsk :  //
  4'bx;
  // endregion PSK modulation

  // region R: FSM
  localparam IDLE = 0;
  localparam START_ALPHA = 1;
  localparam NEXT_ALPHA = 2;
  localparam GEN_SEQUENCE = 10;

  localparam DONE = 15;

  reg [3:0] cstate, nstate;

  reg [15:0] alpha_index;  // alpha index 0,1,...,nSlotSymb-1
  reg [15:0] get_alpha;  // get alpha 0,1,...,nSF-1
  reg [15:0] seq_index;  // n 0,1,2,...,nRBSC-1

  always @(posedge clk, posedge rst) begin
    if (rst) begin

    end else begin
      cstate <= nstate;
      case (cstate)
        IDLE: begin

        end
        START_ALPHA: begin
          alpha_index <= 0;
          get_alpha   <= 0;
        end
        NEXT_ALPHA: begin
          if (alpha_valid) begin
            alpha_index <= alpha_index + 1;
            seq_index   <= 0;


            case (i_pucch_format)
              0: begin
                if (alpha_index >= symStart) begin
                  get_alpha <= get_alpha + 1;
                end
              end
              1: begin
                // Only get alpha at odd index
                if ((alpha_index >= symStart) && (alpha_index[0] == 1)) begin
                  get_alpha <= get_alpha + 1;
                end
              end
              default: begin

              end
            endcase
          end
        end
        GEN_SEQUENCE: begin
          seq_index <= seq_index + 1;
        end
        DONE: begin

        end
        default: begin
          cstate <= IDLE;  // some error happended, back to IDLE
        end
      endcase
    end
  end

  reg done_next_alpha;
  reg done_gen_sequence;
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

  always_comb begin
    // Default values
    nstate = cstate;
    alpha_start = 0;
    alpha_get = 0;

    case (cstate)
      IDLE: begin
        if (i_start) nstate = (pucch_empty_seq ? DONE : START_ALPHA);
      end
      START_ALPHA: begin
        nstate = NEXT_ALPHA;
        alpha_start = 1;
      end
      NEXT_ALPHA: begin
        alpha_get = 1;
        if (alpha_valid) begin
          if (done_next_alpha) begin
            nstate = GEN_SEQUENCE;
            alpha_get = 0;
          end
        end
      end
      GEN_SEQUENCE: begin
        if (seq_index >= nRBSC - 1) begin
          nstate = done_gen_sequence ? DONE : NEXT_ALPHA;
        end
      end
      DONE: begin

      end
      default: begin

      end
    endcase
  end

  assign o_done  = (cstate == DONE);
  assign o_valid = (cstate == GEN_SEQUENCE);

  // endregion R: FSM

  // region angles (alpha, base seq, spreading (orthogonal))

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
      0: begin
        // x = lowPAPRS
        point_cyc_24_no_mod_24 = lowPAPRS_cyc_24;
      end
      1: begin
        // y = d * lowPAPRS
        point_cyc_24_no_mod_24 = cyc_24_modulation + lowPAPRS_cyc_24;
      end
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
  function [3:0] F0_csTable;
    input [1:0] ack;
    input [1:0] lenACK;
    input sr;
    input lenSR;
    begin
      if (lenACK == 0) begin
        F0_csTable = 0;
      end else if ((lenSR == 0) || (sr == 0)) begin
        case (ack[0])
          0: F0_csTable = 0;
          1: F0_csTable = 3;
          default: F0_csTable = 4'bx;
        endcase
      end else begin
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
  endfunction

endmodule
