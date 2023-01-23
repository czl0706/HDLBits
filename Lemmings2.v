module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 

    parameter [1:0] LEFT=2'b00, RIGHT=2'b01, FALLING_LEFT = 2'b10, FALLING_RIGHT = 2'b11;
    reg       [1:0] state, next_state;

    always @(*) begin
        // State transition logic
        case (state)
            LEFT:  
                next_state = ground ? (bump_left ? RIGHT : LEFT) : FALLING_LEFT;
            RIGHT: 
                next_state = ground ? (bump_right ? LEFT : RIGHT) : FALLING_RIGHT;
            FALLING_LEFT:  
                next_state = ground ? LEFT : FALLING_LEFT;  
            FALLING_RIGHT:
                next_state = ground ? RIGHT : FALLING_RIGHT;
        endcase 
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset) state <= LEFT;
        else        state <= next_state;
    end

    // Output logic
    assign walk_left    = (state == LEFT);
    assign walk_right   = (state == RIGHT);
    assign aaah         = state[1];

endmodule
