// PUCCH1Spreading PUCCH format 1 block-wise spread orthogonal sequence
/* Trick for (nSF != 4): phi(m+1) = (phi(m) + occi) mod nSF
          If (nSF == 4): use LUT instead

  if nSF == 1
      phi = 0;
  elseif nSF == 2
      phi = [0 0;
             0 1];
  elseif nSF == 3
      phi = [0 0 0;
             0 1 2;
             0 2 1];
  elseif nSF == 4
      phi = [0 0 0 0;
             0 2 0 2;
             0 0 2 2;
             0 2 2 0];
  elseif nSF == 5
      phi = [0 0 0 0 0;
             0 1 2 3 4;
             0 2 4 1 3;
             0 3 1 4 2;
             0 4 3 2 1];
  elseif nSF == 6
      phi = [0 0 0 0 0 0;
             0 1 2 3 4 5;
             0 2 4 0 2 4;
             0 3 0 3 0 3;
             0 4 2 0 4 2;
             0 5 4 3 2 1];
  else % nSF is equal to 7
      phi = [0 0 0 0 0 0 0;
             0 1 2 3 4 5 6;
             0 2 4 6 1 3 5;
             0 3 6 2 5 1 4;
             0 4 1 5 2 6 3;
             0 5 3 1 6 4 2;
             0 6 5 4 3 2 1];
*/

module pucch1_spread (
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
    output     [3:0] o_wi_phi,
    output           o_done,
    output reg       o_valid
);

  reg [2:0] m;
  reg [3:0] wi_phi;
  reg [3:0] next_wi_phi;

  wire done = (m >= i_nSF - 1);

  wire [2:0] nSF_4_LUT[0:3];  // Store as binary array (0 => phi(m) = 0; 1 => phi(m) = 2). No need to store first index because it always 0.
  assign nSF_4_LUT[0] = 3'b000;
  assign nSF_4_LUT[1] = 3'b101;
  assign nSF_4_LUT[2] = 3'b110;
  assign nSF_4_LUT[3] = 3'b011;

  wire [2:0] nSF_4_phi_arr = nSF_4_LUT[i_occi[1:0]];
  wire [3:0] nSF_4_phi = {2'b0, nSF_4_phi_arr[m[1:0]], 1'b0};

  always_comb begin
    if (i_nSF == 4) begin
      next_wi_phi = nSF_4_phi;
    end else begin
      next_wi_phi = wi_phi + i_occi;
      if (next_wi_phi >= {1'b0, i_nSF}) next_wi_phi = next_wi_phi - i_nSF;
    end
  end

  always @(posedge clk) begin
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
