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

    parameter [3:0] LEFT = 4'b0000, RIGHT = 4'b0001, FALLING_LEFT = 4'b0010, FALLING_RIGHT = 4'b0011, 
                    DIGGING_LEFT = 4'b0100, DIGGING_RIGHT = 4'b0101, DYING = 4'b1010, SPLATTER = 4'b1001;
    reg       [3:0] state, next_state;

    wire game_over;
    assign game_over = (state == SPLATTER);
    
    reg [4:0] counter;

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
            FALLING_LEFT:  next_state = 
                    (counter >= 20) ? DYING :
                    ground ? LEFT : FALLING_LEFT;  
            FALLING_RIGHT: next_state = 
                    (counter >= 20) ? DYING :
                    ground ? RIGHT : FALLING_RIGHT;
            DIGGING_LEFT:  next_state = ground ? DIGGING_LEFT : FALLING_LEFT;
            DIGGING_RIGHT: next_state = ground ? DIGGING_RIGHT : FALLING_RIGHT;
            DYING:    next_state = ground ? SPLATTER : DYING;
            SPLATTER: next_state = SPLATTER;
            default: next_state = 4'hx;
        endcase 
    end

    always @(posedge clk or posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset) state <= LEFT;
        else        state <= next_state;
    end


    // counter
    wire cnt_disable;
    assign cnt_disable = ground | game_over;
    always @(posedge clk or posedge areset or posedge cnt_disable) begin
        if (cnt_disable) 
            counter <= 0;
        else if (areset)
            counter <= 0;
        else 
            counter <= counter + 1'b1;
    end

    // Output logic
    assign walk_left    = (state == LEFT)  & ~game_over;
    assign walk_right   = (state == RIGHT) & ~game_over;
    assign aaah         = state[1] & ~game_over;
    assign digging      = state[2] & ~game_over;

endmodule
