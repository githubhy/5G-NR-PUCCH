// alpha = (2pi/12)(i_params mod 12)

module cyclic_shift (
    // sum of all kind of parameters (alpha = (2pi/12) * (m_0 + m_cs + m_int + n_cs(n_s,f'^mu, l + l')) mod 12 = (2pi/12) * (i_sum_params mod 12)
    input  [15:0] i_sum_params,
    input  [ 4:0] i_n,
    output [15:0] o_cyc_part_24  // o_cyc_part/12 of a cycle
);

  // Parameters
  localparam DIVIDER = 12;
  localparam ONE_DIV_DIVIDER = 34'h2AAAAAAAA;  // ufix34_En37 [0; (2^34-1)*2^-37] ~ 0.08(3)

  wire [15:0] o_cyc_part_12;

  mod_comb #(
      .DIVIDER        (DIVIDER),
      .ONE_DIV_DIVIDER(ONE_DIV_DIVIDER)
  ) mod_dut (
      .i_dividend(i_sum_params * i_n),
      .o_result  (o_cyc_part_12)
  );

  assign o_cyc_part_24 = (2 * o_cyc_part_12);

endmodule
