module qpsk_cyc #(
    parameter CYC_DIV = 24 //! Diviver of the cycle
) (
    input [1:0] i_b,  //! Data bits b0,b1,...
    output [4:0] o_cyc_part //! Parts/Diviver of the cycle coresponding to the modulation complex point
);

  localparam P0 = (CYC_DIV * 1 / 4) - (CYC_DIV * 1 / 8);
  localparam P1 = (CYC_DIV * 2 / 4) - (CYC_DIV * 1 / 8);
  localparam P2 = (CYC_DIV * 4 / 4) - (CYC_DIV * 1 / 8);
  localparam P3 = (CYC_DIV * 3 / 4) - (CYC_DIV * 1 / 8);

  reg [4:0] cyc_part;

  always_comb begin
    case (i_b)
      2'b00:   cyc_part = P0;
      2'b01:   cyc_part = P1;
      2'b10:   cyc_part = P2;
      2'b11:   cyc_part = P3;
      default: cyc_part = 0;
    endcase
  end

  assign o_cyc_part = cyc_part;

endmodule
