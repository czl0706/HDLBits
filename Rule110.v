module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
); 

    reg [511:0] q_ns;

    always @(*) begin
        for (integer i = 1; i <= 510; i = i + 1) begin
            or_xor_mux({q[i+1], q[i], q[i-1]}, q_ns[i]);
        end
        or_xor_mux({1'b0, q[511:510]}, q_ns[511]);
        or_xor_mux({q[1:0], 1'b0}, q_ns[0]);
    end

    always @(posedge clk) begin 
        if (load) begin 
            q <= data;
        end 
        else begin
            q <= q_ns;
        end 
    end 
    
    task or_xor_mux;
        input [2:0] in_data;
        output res;
        
        res = in_data[2] ? in_data[1] ^ in_data[0]:
                           in_data[1] | in_data[0];
    endtask

endmodule
