// PUCCH1Spreading PUCCH format 1 block-wise spread orthogonal sequence
/* Trick for (nSF != 4): phi(m+1) = (phi(m) + occi) mod nSF
          If (nSF == 4): use LUT instead

  if nSF == 1
     0
  elseif nSF == 2
     0     0
     0    12
  elseif nSF == 3
     0     0     0
     0     8    16
     0    16     8
  elseif nSF == 4
     0     0     0     0
     0    12     0    12
     0     0    12    12
     0    12    12     0
  elseif nSF == 5
            CORDIC
  elseif nSF == 6
     0     0     0     0     0     0
     0     4     8    12    16    20
     0     8    16     0     8    16
     0    12     0    12     0    12
     0    16     8     0    16     8
     0    20    16    12     8     4
  else % nSF is equal to 7
            CORDIC
*/

module cyc_24_pucch1_spread (
    input clk,
    input rst,

    input i_start,
    input i_next,

    //! nSF = floor(nPUCCHSym/2).
    //! nSF range = (2-7) because nPUCCHSym (4-14)
    input [2:0] i_nSF,

    //! Orthogonal cover code index. It is in range 0 to 6,
    //! provided by higher-layer parameter timeDomainOCC. The
    //! valid range depends on the number of OFDM symbols per
    //! hop which contain control information.
    input [2:0] i_occi,

    //! phi(m) of wi(m)
    output     [4:0] o_wi_phi,
    output           o_done,
    output reg       o_valid,
    output reg       o_is_supported
);

  reg [2:0] m;
  reg [4:0] wi_phi;
  reg [5:0] next_wi_phi;

  wire done = (m >= i_nSF - 1);

  wire [2:0] nSF_4_LUT[0:3];  // Store as binary array (0 => phi(m) = 0; 1 => phi(m) = 2). No need to store first index because it always 0.
  assign nSF_4_LUT[0] = 3'b000;
  assign nSF_4_LUT[1] = 3'b101;
  assign nSF_4_LUT[2] = 3'b110;
  assign nSF_4_LUT[3] = 3'b011;

  wire [2:0] nSF_4_phi_arr = nSF_4_LUT[i_occi[1:0]];
  wire [3:0] nSF_4_phi = nSF_4_phi_arr[m[1:0]] ? 12 : 0;

  always_comb begin
    if (i_nSF == 4) begin
      next_wi_phi = nSF_4_phi;
    end else begin
      next_wi_phi = wi_phi + i_occi * amplifier;
      if (next_wi_phi >= 24) next_wi_phi = next_wi_phi - 24;
    end
  end

  reg [3:0] amplifier;
  always_comb begin
    o_is_supported = 1;
    case (i_nSF)
      1: amplifier = 0;
      2: amplifier = 12;
      3: amplifier = 8;
      4: amplifier = 6;
      6: amplifier = 4;
      default: begin
        amplifier = 4'dx;
        o_is_supported = 0;
      end
    endcase
  end

  always @(posedge clk, posedge rst) begin
    if (rst) begin
      //   m       <= 0;
      //   o_valid <= 0;
      //   wi_phi  <= 0;
    end else begin
      if (i_start) begin
        m       <= 0;
        o_valid <= 1;
        wi_phi  <= 0;
      end else if (i_next) begin
        if (!done) begin
          m       <= m + 1;
          o_valid <= 1;
          wi_phi  <= next_wi_phi;
        end else begin
          o_valid <= 0;
        end
      end else begin
        o_valid <= 0;
      end
    end
  end

  assign o_wi_phi = wi_phi;
  assign o_done   = done;

endmodule
