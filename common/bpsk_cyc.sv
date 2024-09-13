module bpsk_cyc #(
    parameter CYC_DIV = 24
) (
    input i_b,
    output [4:0] o_cyc_part
);

  localparam P0 = (CYC_DIV * 1 / 4) - (CYC_DIV * 1 / 8);
  localparam P1 = (CYC_DIV * 3 / 4) - (CYC_DIV * 1 / 8);

  reg [4:0] cyc_part;

  always_comb begin
    case (i_b)
      1'b0:    cyc_part = P0;
      1'b1:    cyc_part = P1;
      default: cyc_part = 0;
    endcase
  end

  assign o_cyc_part = cyc_part;

endmodule
