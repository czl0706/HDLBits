module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    
    wire s0, s1, s2, s3, s4, s5, s6, s7, s8, s9;
    assign {s9, s8, s7, s6, s5, s4, s3, s2, s1, s0} = state;
    assign next_state[0] = (s0 & (~in)) | (s1 & (~in)) | (s2 & (~in)) | (s3 & (~in)) | (s4 & (~in)) | (s7 & (~in)) | (s8 & (~in)) | (s9 & (~in));
    assign next_state[1] = (s0 & (in)) | (s8 & (in)) | (s9 & (in));
    assign next_state[2] = (s1 & (in));
    assign next_state[3] = (s2 & (in));
    assign next_state[4] = (s3 & (in));
    assign next_state[5] = (s4 & (in));
    assign next_state[6] = (s5 & (in));
    assign next_state[7] = (s6 & (in)) | (s7 & (in));
    assign next_state[8] = (s5 & (~in));
    assign next_state[9] = (s6 & (~in));

    assign out1 = s8 | s9;
    assign out2 = s7 | s9;
endmodule
