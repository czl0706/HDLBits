module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial
    parameter [3:0] IDLE = 0, START = 1, DONE = 9, STOP = 10, ERROR = 11;
    reg [3:0] state, next_state;
    reg [7:0] data_reg;

    always @(*) begin
        next_state = state + 1'b1;
        case (state) 
            IDLE: next_state = (in == 0) ? START : IDLE;
            DONE: next_state = (in == 1) ?  STOP : ERROR;
            STOP: next_state = (in == 0) ? START : IDLE;
           ERROR: next_state = (in == 1) ?  IDLE : ERROR; 
        endcase
    end

    always @(posedge clk) begin
        if (reset) state <= IDLE;
        else       state <= next_state; 
    end

    assign done = (state == STOP);

    // New: Datapath to latch input bits.
    always @(posedge clk) begin
        if (reset) 
            data_reg <= 0;
        else if (state != DONE) 
            data_reg <= {in, data_reg[7:1]}; 
    end

    assign out_byte = done ? data_reg : 8'd0;

endmodule
