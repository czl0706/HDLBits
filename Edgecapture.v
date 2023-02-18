module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);
    reg  [31:0] in_reg;
    wire [31:0] out_n;

    always @(posedge clk) begin 
        if (reset)  out <= 0;
        else        out <= out | out_n;
    end

    always @(posedge clk) begin
        in_reg <= in;
    end

    assign out_n = in_reg & ~in;
    
endmodule
