module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q ); 

    reg [511:0] q_ns;

    always @(*) begin 
        for (integer i = 1; i <= 510; i = i + 1) begin
            q_ns[i] = q[i + 1] ^ q[i - 1];
        end
        q_ns[511] = q[510];
        q_ns[0]   = q[1]; 
    end 


    always @(posedge clk) begin 
        if (load) begin 
            q <= data;
        end 
        else begin
            q <= q_ns;
        end 
    end 

endmodule