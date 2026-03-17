module FIFO (
    input  wire        clk,
    input  wire        reset_n,
    input  wire        wr_en,
    input  wire        rd_en,
    input  wire [7:0]  din,
    output reg  [7:0]  dout,
    output wire        full,
    output wire        empty
);

    parameter DEPTH = 16;
    parameter ADDR_BITS = 4;

    reg [7:0] mem [0:DEPTH-1];

    reg [ADDR_BITS-1:0] wr_ptr, rd_ptr;
    reg [ADDR_BITS:0]   count;

    wire write_fire = wr_en && !full;
    wire read_fire  = rd_en && !empty;

    assign full  = (count == DEPTH);
    assign empty = (count == 0);

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            count  <= 0;
            dout   <= 0;
        end else begin
            if (write_fire) begin
                mem[wr_ptr] <= din;
                wr_ptr <= wr_ptr + 1;
            end

            if (read_fire) begin
                dout <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;
            end

            case ({write_fire, read_fire})
                2'b10: count <= count + 1;
                2'b01: count <= count - 1;
                default: count <= count;
            endcase
        end
    end

endmodule
