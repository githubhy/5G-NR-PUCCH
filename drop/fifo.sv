module fifo #(
    parameter DATA_WIDTH  = 8,
    parameter DATA_LENGTH = 10
) (
    input clk,
    input rst,

    input [DATA_WIDTH-1:0] i_data,
    input                  i_push,
    input                  i_pop,

    output reg [DATA_WIDTH-1:0] o_data,
    output                      o_valid,

    output o_full,
    output o_empty
);

  localparam COUNT_BIT = $clog2(DATA_LENGTH);
  reg [COUNT_BIT-1:0] head;
  reg [COUNT_BIT-1:0] next_head;
  reg [COUNT_BIT-1:0] tail;
  reg [COUNT_BIT-1:0] next_tail;
  reg [COUNT_BIT-1:0] count;
  reg [COUNT_BIT-1:0] next_count;
  reg [DATA_WIDTH-1:0] pipe[0:DATA_LENGTH-1];
  reg [DATA_WIDTH-1:0] pop_data;

  genvar pipe_index;
  for (pipe_index = 0; pipe_index < DATA_LENGTH; pipe_index = pipe_index + 1) begin
    wire [DATA_WIDTH-1:0] pipe_data = pipe[pipe_index];
  end

  assign empty   = (count == 0);
  assign full    = (count == (DATA_LENGTH - 1));

  assign o_empty = empty;
  assign o_full  = full;

  always @(posedge clk, posedge rst) begin
    if (rst) begin
      head  <= 0;
      tail  <= 0;
      count <= 0;
    end else begin
      if (i_push && (!full)) begin
        pipe[head] <= i_data;
        head       <= next_head;
        count      <= next_count;
      end
      if (i_pop && (!empty)) begin
        o_data <= pop_data;
        tail   <= next_tail;
        count  <= next_count;
      end
    end
  end

  always_comb begin
    next_head  = head;
    next_tail  = tail;
    next_count = count;
    pop_data   = pipe[tail];
    case ({
      i_push, i_pop
    })
      2'b01: begin
        next_tail  = (tail < DATA_LENGTH - 1) ? (tail + 1) : 0;
        next_count = count - 1;
      end
      2'b10: begin
        next_head  = (head < DATA_LENGTH - 1) ? (head + 1) : 0;
        next_count = count + 1;
      end
      2'b11: begin
        pop_data = i_data;
      end
      default: begin

      end
    endcase
  end



endmodule
