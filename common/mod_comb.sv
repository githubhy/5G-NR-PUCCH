//! Compute Y = X mod D with D is a constaint.
//! 
//! No pipelined, all combinational logic.
//! 
//! Passed the test with all possible value of X with D = 12 or 30.
//! 

//  12  h2AAAAAAAA
//  24  h155555555
//  30  h111111111
//  192 h02aaaaaab


module mod_comb #(
    //! Diviver D (unit)
    parameter [ 4:0] DIVIDER         = 12,
    //! 1/D (ufix34_En37)
    parameter [33:0] ONE_DIV_DIVIDER = 34'h2AAAAAAAA  // ufix34_En37 [0; (2^34-1)*2^-37] ~ 0.08(3)
) (
    input  [15:0] i_dividend,  //! Dividend X (uint16)
    output [15:0] o_result     //! Result Y = X mod D (uint16)
);

  wire [49:0] dividend_div_divider = i_dividend * ((i_dividend == 0) ? ONE_DIV_DIVIDER : ONE_DIV_DIVIDER + 1);  // ufix50_En37

  wire [12:0] rnd = dividend_div_divider[49:37];  // uint13

  wire [15:0] rnd_mul_divider = rnd * DIVIDER;  // uint16

  assign o_result = i_dividend - rnd_mul_divider;


endmodule
