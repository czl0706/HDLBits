module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    parameter [2:0] LEFT = 3'b000, RIGHT = 3'b001, FALLING_LEFT = 3'b010, FALLING_RIGHT = 3'b011, 
                    DIGGING_LEFT = 3'b100, DIGGING_RIGHT = 3'b101;
    reg       [2:0] state, next_state;

    always @(*) begin
        // State transition logic
        case (state)
            LEFT: next_state = 
                    ~ground   ? FALLING_LEFT : 
                    dig       ? DIGGING_LEFT : 
                    bump_left ? RIGHT : LEFT;
            RIGHT: next_state = 
                    ~ground    ? FALLING_RIGHT : 
                    dig        ? DIGGING_RIGHT : 
                    bump_right ? LEFT : RIGHT;
            FALLING_LEFT:  next_state = ground ? LEFT : FALLING_LEFT;  
            FALLING_RIGHT: next_state = ground ? RIGHT : FALLING_RIGHT;
            DIGGING_LEFT:  next_state = ground ? DIGGING_LEFT : FALLING_LEFT;
            DIGGING_RIGHT: next_state = ground ? DIGGING_RIGHT : FALLING_RIGHT;
            default: next_state = 'x;
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
    assign digging      = state[2];

endmodule
