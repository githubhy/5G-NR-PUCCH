//! By combining two Linear Feedback Shift Registers (LFSRs), x1 and x2, each with
//! 31 taps, and XORing their outputs, we generate a length-31 Gold sequence as described
//! in Section 5.2.3.

module c_seq_gen #(
    parameter nGenBit = 8
) (
    input clk,
    input rst,

    input        i_en,    //! Enable the sequence generator
    input        i_load,  //! Load the initial value (i_init), the sequence generator will start generating from the first element with this initial value.
    input [30:0] i_init,  //! Initial value

    output [nGenBit-1:0]  o_seq_bit,  //! Output bit of the sequence at current index
    output reg o_valid     //! Valid output
);

  always @(posedge clk, posedge rst) begin
    if (rst) begin
      o_valid <= 0;
    end else begin
      o_valid <= (i_en || i_load);
    end
  end

  wire [nGenBit-1:0] o_seq_bit_x1;

  x1_seq_gen #(
      .nGenBit(nGenBit)
  ) x1_seq_gen_dut (
      .clk(clk),

      .rst   (rst),
      .i_en  (i_en),
      .i_load(i_load),

      .o_seq_bit(o_seq_bit_x1)
  );

  wire [nGenBit-1:0] o_seq_bit_x2;

  x2_seq_gen #(
      .nGenBit(nGenBit)
  ) x2_seq_gen_dut (
      .clk(clk),
      .rst(rst),

      .i_en  (i_en),
      .i_load(i_load),
      .i_init(i_init),

      .o_seq_bit(o_seq_bit_x2)
  );

  assign o_seq_bit = (o_seq_bit_x1 ^ o_seq_bit_x2);


endmodule
