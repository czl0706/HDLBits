// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

    // Fill in state name declarations

    // reg present_state, next_state;

    // always @(posedge clk) begin
    //     if (reset) begin  
    //         // Fill in reset logic
    //     end else begin
    //         case (present_state)
    //             // Fill in state transition logic
    //         endcase

    //         // State flip-flops
    //         present_state = next_state;   

    //         case (present_state)
    //             // Fill in output logic
    //         endcase
    //     end
    // end

    parameter A=0, B=1; 
    reg state, next_state;

    always @(*) begin    // This is a combinational always block
        // State transition logic
        case (state)
            A: next_state = (in == 1'b1) ? A : B; 
            B: next_state = (in == 1'b1) ? B : A;
        endcase
    end

    always @(posedge clk) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if (reset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    assign out = (state == A) ? 1'b0 : 1'b1;

endmodule
