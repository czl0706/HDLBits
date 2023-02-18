// detects the sequence 1101 in an input bit stream
module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);

    parameter [2:0] S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;
    reg [2:0] state, next_state;

    always @(*) begin
        case (state) 
            S0: next_state = data ? S1 : S0; 
            S1: next_state = data ? S2 : S0;
            S2: next_state = data ? S2 : S3;
            S3: next_state = data ? S4 : S0;
            S4: next_state = data ? S4 : S4;
            default: next_state = 3'hx;
        endcase
    end

    always @(posedge clk) begin
        if (reset)  state <= S0;
        else        state <= next_state;
    end

    assign start_shifting = (state == S4);

    // // why FSM?
    // parameter [3:0] pattern = 4'b1101;
    // reg [3:0] sh_reg;

    // always @(posedge clk) begin
    //     if (reset)  sh_reg <= 4'h0;
    //     else if (sh_reg == pattern) sh_reg <= sh_reg;
    //     else        sh_reg <= {sh_reg[2:0], data};
    // end

    // assign start_shifting = (sh_reg == pattern);

endmodule
