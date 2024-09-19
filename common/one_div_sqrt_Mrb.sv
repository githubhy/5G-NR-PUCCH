module one_div_sqrt_Mrb (
    //! The number of resource blocks associated with the PUCCH
    //! format 3 transmission. Nominally the value of MRB will be
    //! one of the set {1,2,3,4,5,6,8,9,10,12,15,16}.
    input      [ 5:0] i_Mrb,
    output reg [17:0] o_one_div_sqrt_Mrb  //! 1/sqrt(Mrb) sfix18_En17
);

  always_comb begin
    case (i_Mrb)
      1:  o_one_div_sqrt_Mrb = 18'h093cd;
      2:  o_one_div_sqrt_Mrb = 18'h06883;
      3:  o_one_div_sqrt_Mrb = 18'h05555;
      4:  o_one_div_sqrt_Mrb = 18'h049e7;
      5:  o_one_div_sqrt_Mrb = 18'h04219;
      6:  o_one_div_sqrt_Mrb = 18'h03c57;
      8:  o_one_div_sqrt_Mrb = 18'h03441;
      9:  o_one_div_sqrt_Mrb = 18'h03144;
      10: o_one_div_sqrt_Mrb = 18'h02ebd;
      12: o_one_div_sqrt_Mrb = 18'h02aab;
      15: o_one_div_sqrt_Mrb = 18'h0262a;
      16: o_one_div_sqrt_Mrb = 18'h024f3;

      default: o_one_div_sqrt_Mrb = 18'dx;
    endcase
  end

endmodule
