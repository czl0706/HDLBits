//      State	Next state	Output
//      in=0    in=1
// A	A	    B	        0
// B	C	    B	        0
// C	A	    D	        0
// D	C	    B	        1

module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter [1:0] A=0, B=1, C=2, D=3;

    // State transition logic: next_state = f(state, in)
    always @(*) begin
        case (state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : C;
        endcase
    end

    // Output logic:  out = f(state) for a Moore state machine
    assign out = (state == D);

endmodule
