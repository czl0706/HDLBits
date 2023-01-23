module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 5'h1
    output reg [4:0] q
); 
    wire [4:0] mask;
    assign mask[4] = q[0];
    assign mask[2] = q[0];

    always @(posedge clk) begin
        if (reset) begin 
            q <= 5'h1;
        end 
        else begin
            q <= {1'b0, q[4:1]} ^ mask;
        end 

    end 

endmodule
