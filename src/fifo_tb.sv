`timescale 1ns/1ps

module fifo_tb;

  parameter int WIDTH = 8;
  parameter int DEPTH = 16;
  parameter int ADDR_BITS = $clog2(DEPTH);

  // TB drives
  logic clk;
  logic reset_n;
  logic wr_en, rd_en;
  logic [WIDTH-1:0] din;

  // TB observes
  logic [WIDTH-1:0] dout;
  logic full, empty;

  // Scoreboard queue
  logic [WIDTH-1:0] exp_q[$];

  // Temp variables used in tests
  logic [WIDTH-1:0] tmp;
  int before_sz, after_sz;
  int before_sz2, after_sz2;
  int i;

  // Instantiate DUT (make sure module name matches your RTL)
  FIFO #(.WIDTH(WIDTH), .DEPTH(DEPTH), .ADDR_BITS(ADDR_BITS)) dut (
    .clk(clk),
    .reset_n(reset_n),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .din(din),
    .dout(dout),
    .full(full),
    .empty(empty)
  );

  // Clock: 10ns period
  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end

  task automatic do_reset();
    begin
      reset_n = 1'b0;
      wr_en   = 1'b0;
      rd_en   = 1'b0;
      din     = '0;
      exp_q.delete();

      repeat (3) @(posedge clk);
      reset_n = 1'b1;
      @(posedge clk);

      if (!empty || full) begin
        $fatal(1, "Reset check failed: empty=%0b full=%0b (expected empty=1 full=0)", empty, full);
      end
      $display("[TB] Reset OK");
    end
  endtask

  task automatic push(input logic [WIDTH-1:0] v);
    begin
      @(negedge clk);
      din   = v;
      wr_en = 1'b1;
      rd_en = 1'b0;

      @(posedge clk);
      // if accepted, mirror to scoreboard
      if (!full) exp_q.push_back(v);

      @(negedge clk);
      wr_en = 1'b0;
    end
  endtask

  task automatic pop(output logic [WIDTH-1:0] v);
    logic [WIDTH-1:0] exp;
    begin
      @(negedge clk);
      wr_en = 1'b0;
      rd_en = 1'b1;

      @(posedge clk);
      if (!empty) begin
        exp = exp_q.pop_front();
        if (dout !== exp) begin
          $fatal(1, "POP mismatch: got=%0h expected=%0h", dout, exp);
        end
        v = dout;
      end else begin
        v = 'x; // ignored read
      end

      @(negedge clk);
      rd_en = 1'b0;
    end
  endtask

  initial begin
    // init
    reset_n = 1'b0;
    wr_en   = 1'b0;
    rd_en   = 1'b0;
    din     = '0;

    // 1) Reset
    do_reset();

    // 2) Fill to full
    $display("[TB] Filling FIFO to full...");
    for (i = 0; i < DEPTH; i = i + 1) begin
      push(logic'(i));
      if (i == 0 && empty) $fatal(1, "empty stayed high after first write");
    end
    @(posedge clk);
    if (!full)  $fatal(1, "Expected full=1 after %0d writes, got full=%0b", DEPTH, full);
    if (empty)  $fatal(1, "Expected empty=0 when full");
    $display("[TB] Full reached OK");

    // 3) Write when full ignored
    $display("[TB] Attempt write while full (should be ignored)...");
    before_sz = exp_q.size();
    push(8'hAA);
    after_sz  = exp_q.size();
    if (after_sz != before_sz)
      $fatal(1, "Write while full was not ignored (size %0d -> %0d)", before_sz, after_sz);
    $display("[TB] Write-when-full ignored OK");

    // 4) Drain to empty (ordering checked inside pop)
    $display("[TB] Draining FIFO to empty...");
    for (i = 0; i < DEPTH; i = i + 1) begin
      pop(tmp);
    end
    @(posedge clk);
    if (!empty) $fatal(1, "Expected empty=1 after draining, got empty=%0b", empty);
    if (full)   $fatal(1, "Expected full=0 when empty");
    $display("[TB] Empty reached OK");

    // 5) Read when empty ignored
    $display("[TB] Attempt read while empty (should be ignored)...");
    before_sz2 = exp_q.size();
    pop(tmp);
    after_sz2  = exp_q.size();
    if (after_sz2 != before_sz2)
      $fatal(1, "Read while empty changed scoreboard size (shouldn't)");
    $display("[TB] Read-when-empty ignored OK");

    // 6) Mixed scenario
    $display("[TB] Mixed scenario...");
    for (i = 0; i < 3; i = i + 1) push(8'h10 + i);
    for (i = 0; i < 2; i = i + 1) pop(tmp);
    for (i = 0; i < 4; i = i + 1) push(8'h20 + i);

    while (exp_q.size() != 0) pop(tmp);

    @(posedge clk);
    if (!empty) $fatal(1, "Expected empty=1 at end of mixed test");
    $display("[TB] Mixed scenario OK");

    $display("\n✅ ALL TESTS PASSED\n");
    $finish;
  end

endmodule
