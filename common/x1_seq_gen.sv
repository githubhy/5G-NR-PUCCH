//! Generate bit sequence x1 that the gold sequence c(n) needed

module x1_seq_gen #(
    parameter nGenBit = 8  //! Number of bits generated per clock cycle (1,2,...,27)
) (
    input clk,
    input rst,

    input i_en,   //! Enable the sequence generator
    input i_load, //! Load the initial value (INIT), the sequence generator will start generating from the first element with this initial value.
    // input [30:0] i_init, // No need

    output reg [nGenBit-1:0] o_seq_bit  //! Output bit of the sequence at current index
);

  localparam [30:0] INIT = 1;  //! Constaint initial value
  localparam [30:0] PARALLEL_MASK = 35263098;  //! Mask to jump ahead by a number of indexes (1600)

  reg [30:0] lfsr;  // LFSR registers length 31

  wire [nGenBit-1:0] new_val;

  wire [30+nGenBit:0] concat_new_val_lfsr = {new_val, lfsr};

  wire [30:0] masked_val[0:nGenBit-1];

  wire [nGenBit-1:0] seq_bit;

  genvar gen_index;
  for (gen_index = 0; gen_index < nGenBit; gen_index = gen_index + 1) begin : gen_structure
    assign new_val[gen_index] = (lfsr[gen_index+3] ^ lfsr[gen_index+0]);  // x1(n+31) = (x1(n+3) + x1(n)) mod 2
    assign masked_val[gen_index] = (concat_new_val_lfsr[gen_index+30:gen_index+0] & PARALLEL_MASK);
    assign seq_bit[gen_index] = (^(masked_val[gen_index]));
  end

  wire [30:0] next_lfsr = concat_new_val_lfsr[30+nGenBit:nGenBit];

  always @(posedge clk, posedge rst) begin
    if (rst) begin
      lfsr <= 0;
    end else begin
      if (i_load) begin
        lfsr <= INIT;
        o_seq_bit <= seq_bit;
      end else if (i_en) begin
        lfsr      <= next_lfsr;
        o_seq_bit <= seq_bit;
      end
    end
  end

endmodule
