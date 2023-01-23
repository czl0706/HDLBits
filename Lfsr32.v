module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 
    wire [31:0] mask;
    // 32, 22, 2, and 1.
    assign mask = q[0] << 31 | q[0] << 21 | q[0] << 1 | q[0] << 0;

    always @(posedge clk) begin
        if (reset) begin 
            q <= 32'h1;
        end 
        else begin
            q <= {1'b0, q[31:1]} ^ mask;
        end 

    end 

endmodule
