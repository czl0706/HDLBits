module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    reg  [7:0] in_reg;
    wire [7:0] anyedge_n;

    always @(posedge clk) begin
        in_reg <= in;
        anyedge <= anyedge_n;
    end

    assign anyedge_n = in_reg ^ in;
endmodule
