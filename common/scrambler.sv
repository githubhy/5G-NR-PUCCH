module scrambler (
    input clk,
    input rst,

    input i_start,

    input i_uciCW,
    input i_uciCW_valid,


    // c_gen
    output           o_scramble_start,  // start scramble code generation
    output reg       o_scramble_get,
    input      [7:0] i_scramble_byte,
    input            i_scramble_valid,
    // input        i_scramble_done,

    output reg o_scrambled_bit,
    output reg o_scrambled_bit_valid,

    output     [1:0] o_scrambled_2bit,
    output reg       o_scrambled_2bit_valid,

    output     o_valid,
    output reg o_done
);

  reg [2:0] count;
  localparam MAX_COUNT = 8;
  wire done_count = (count >= MAX_COUNT - 1);

  reg uciCW;
  wire i_scramble_bit = i_scramble_byte[scramble_bit_index];
  reg [2:0] scramble_bit_index;
  wire scrambled_uciCW = (uciCW ^ i_scramble_bit);
  reg [1:0] scrambled_uciCW_buff;

  always @(posedge clk, posedge rst) begin
    if (rst) begin
      uciCW                <= 0;
      o_done               <= 0;
      count                <= 0;
      scrambled_uciCW_buff <= 0;
      // o_scramble_start <= 0;
      o_scramble_get       <= 0;
      scramble_bit_index   <= 0;
    end else begin
      // o_scramble_start <= i_start;
      if (i_start) begin
        uciCW                <= 0;
        o_done               <= 0;
        count                <= 0;
        // o_scramble_start <= 1;
        o_scramble_get       <= 0;
        scrambled_uciCW_buff <= 0;
        scramble_bit_index   <= 0;
      end else begin
        if (i_uciCW_valid) begin
          uciCW              <= i_uciCW;
          scramble_bit_index <= count;
          o_scramble_get     <= done_count;
          count              <= count + 1;
          if (done_count) count <= 0;
        end
      end
    end
  end

  wire [7:0] scramble_byte = i_scramble_byte;
  always @(posedge clk, posedge rst) begin
    if (rst) begin
      
    end else begin
      scrambled_uciCW_buff   <= {scrambled_uciCW, scrambled_uciCW_buff[1]};
      // if (i_scramble_valid) scramble_byte <= i_scramble_byte;
      o_scrambled_2bit_valid <= (scramble_bit_index[0] && uciCW_valid_d);  // odd index & uci valid

      o_scrambled_bit        <= scrambled_uciCW;

      uciCW_valid_d          <= i_uciCW_valid;
      o_scrambled_bit_valid  <= uciCW_valid_d;
    end
  end

  reg uciCW_valid_d;

  assign o_scrambled_2bit = scrambled_uciCW_buff;


  assign o_scramble_start = i_start;

  // always @(posedge clk) begin
  //   if (o_scrambled_2bit_valid) $display("%b", o_scrambled_2bit);
  //   // if (o_scrambled_bit_valid) $display("%b", o_scrambled_bit);
  // end

endmodule


// ALPHA
// reg        alpha_start;
// reg        alpha_get;
// wire [7:0] gen_byte;
// wire       alpha_can_get;
// wire [4:0] alpha_cyc_12;
// wire [4:0] alpha_cyc_24 = (alpha_cyc_12 << 1);
// wire       alpha_valid;
// cyc_12_alpha_generator cyc_12_alpha_generator_dut (
//     .clk(clk),
//     .rst(rst),

//     .i_pucch_format(i_pucch_format),

//     .i_start(alpha_start),
//     .i_get  (alpha_get),

//     .i_m0   (m0),
//     .i_mcs  (mcs),
//     .i_nslot(i_nslot),
//     .i_nid  (i_nid),
//     .i_rnti (rnti),

//     .o_gen_byte    (gen_byte),
//     .o_can_get     (alpha_can_get),
//     .o_cyc_12_alpha(alpha_cyc_12),
//     .o_valid       (alpha_valid)
// );
