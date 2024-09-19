module dft_12 (
    input clk,
    input rst,

    // connect to complex point source
    input signed [15:0] i_re,    //! real point
    input signed [15:0] i_im,    //! imaginary point
    input               i_start,

    output            [      4:0] o_k,
    output            [      4:0] o_n,
    output reg signed [15 + 12:0] o_re,
    output reg signed [15 + 12:0] o_im,
    output                        o_done_one,
    output                        o_done_all,
    output                        o_valid
);

  reg [4:0] n;
  reg [4:0] k;

  reg signed [15+12:0] temp_re;
  reg signed [15+12:0] temp_im;

  assign o_n = n;
  assign o_k = k;

  assign o_done_one = (n >= 12 - 1);
  assign o_done_all = (k >= 12);

  always @(posedge clk, posedge rst) begin
    if (rst) begin

    end else begin
      if (i_start) begin
        n <= 0;
        k <= 0;
        temp_re <= 0;
        temp_im <= 0;
      end else begin
        if (o_done_one) begin
          n <= 0;
          k <= k + 1;
        end else if (!o_done_all) begin
          n <= n + 1;
        end
      end

      if (!o_done_all) begin
        if (o_done_one) begin
          temp_re <= 0;
          temp_im <= 0;
        end else begin
          temp_re <= temp_re + i_re;
          temp_im <= temp_im + i_im;
        end
      end

      if (o_done_one) begin
        o_re <= temp_re + i_re;
        o_im <= temp_im + i_im;
      end
    end
  end

endmodule
