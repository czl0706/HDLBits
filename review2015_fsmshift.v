module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

    parameter [2:0] start_val = 3'b100, pattern = 3'b000;
    reg [2:0] counter;

    always @(posedge clk) begin
        if (reset) 
            counter <= start_val;
        else if (counter == pattern) 
            counter <= pattern;
        else 
            counter <= counter - 1'b1;
    end

    assign shift_ena = ~(counter == pattern);

    // parameter [2:0] S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;
    // reg [2:0] state, next_state;

    // always @(*) begin
    //     case (state)
    //         S0: next_state = S1; 
    //         S1: next_state = S2;
    //         S2: next_state = S3;
    //         S3: next_state = S4;
    //         S4: next_state = S4;
    //         default: next_state = 3'hx; 
    //     endcase
    // end

    // always @(posedge clk) begin
    //     if (reset)  state <= S0;
    //     else        state <= next_state;
    // end

    // assign shift_ena = ~(state == S4);
endmodule
