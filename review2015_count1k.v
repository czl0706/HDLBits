module top_module (
    input clk,
    input reset,
    output reg [9:0] q);

    parameter CYCLES = 1000;

    always @(posedge clk) begin
        if (reset) 
            q <= 10'd0;
        else if (q == CYCLES - 1) 
            q <= 10'd0;
        else 
            q <= q + 1'b1;
    end

endmodule
