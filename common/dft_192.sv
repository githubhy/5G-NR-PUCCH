module dft_192 (
    input clk,
    input rst,

    input [4:0] i_Mrb,  // 1-16

    input i_cyc_24_point,
    input i_cyc_24_point_valid
);

  wire [7:0] Msc = i_Mrb * 12;  // 12,24,...,192

  reg  [7:0] n;  // 0,1,...,Msc-1
  reg  [7:0] k;  // 0,1,...,Msc-1

endmodule
