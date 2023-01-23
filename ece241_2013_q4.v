// Mealy machine seems to be better for this problem = = 
module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output reg dfr
); 
    parameter S0 = 2'd0, S1 = 2'd1, S2 = 2'd2, S3 = 2'd3;
    reg [2:0] state, next_state;

    reg [2:0] fr;
    assign {fr3, fr2, fr1} = fr;

    always @(*) begin
        case (s) 
            3'b111:  next_state = S3;
            3'b011:  next_state = S2;
            3'b001:  next_state = S1;
            default: next_state = S0;
        endcase
    end

    always @(posedge clk) begin
        if (reset) state <= S0; 
        else       state <= next_state;
    end

    always @(posedge clk) begin
        if (reset) begin 
            {dfr, fr} <= 4'b1111;
        end 
        else begin
            case (next_state) 
                S3: fr <= 3'b000; 
                S2: fr <= 3'b001;
                S1: fr <= 3'b011;
                S0: fr <= 3'b111;
            endcase

            if (state < next_state)      
                dfr <= 1'b0;
            else if (state > next_state) 
                dfr <= 1'b1;
            else // state == next_state
                dfr <= dfr;
        end
    end

endmodule
