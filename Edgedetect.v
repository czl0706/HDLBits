module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg  [7:0] in_reg;
    wire [7:0] out_n;

    always @(posedge clk) begin
        in_reg <= in;
        pedge  <= out_n;
    end

    assign out_n = ~in_reg & in;
endmodule
