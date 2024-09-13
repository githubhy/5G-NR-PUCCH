

module cyc_24_base_seq (
    input [4:0] i_u,  //! 0,1,...,29      (sequence group)
    input [3:0] i_n,  //! 0,1,...,M_ZC-1 = 11  (index of φ)

    output [15:0] o_cyc_part_24
);

  localparam PHI_EN_BITS = 02;  // Varphi encode define
  localparam PHI_EN_NUMS = 12;  // Varphi encode define
  localparam PHI_EN_NEG_3 = 2'b10;  // Varphi encode define
  localparam PHI_EN_NEG_1 = 2'b11;  // Varphi encode define
  localparam PHI_EN_POS_1 = 2'b00;  // Varphi encode define
  localparam PHI_EN_POS_3 = 2'b01;  // Varphi encode define

  wire [PHI_EN_BITS-1:0] varphi_n;

  varphi12 varphi12_dut (
      .i_u(i_u),
      .i_n(i_n),
      .o_varphi_n(varphi_n)
  );

  reg signed [15:0] cyc_part_24;

  always_comb begin
    case (varphi_n)
      PHI_EN_NEG_3: cyc_part_24 = +(24 - 9);
      PHI_EN_NEG_1: cyc_part_24 = +(24 - 3);
      PHI_EN_POS_1: cyc_part_24 = +3;
      PHI_EN_POS_3: cyc_part_24 = +9;
      default: cyc_part_24 = 0;
    endcase
  end

  assign o_cyc_part_24 = cyc_part_24;


endmodule
