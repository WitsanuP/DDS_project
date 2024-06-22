module rotary(Fg_CLK, RESETn, Rot_A, Rot_B, Rot_C, Address, FreqChng);
    input Fg_CLK;
    input RESETn;
    input Rot_A;
    input Rot_B;
    input Rot_C;

    output reg Address; // 0-1800
    output reg FreqChng;

    reg [10:0] count; // 0-1800
    reg [1:0] step_exp; // 0->1, 1->10, 2->100
    reg [1:0] state; //  minus, idle, plus

    reg A1;
    reg A2;
    reg A3;
    reg A_pulse;
    reg B1;
    reg B2;
    reg B3;
    reg [21:0] counter;
    reg counter_pulse;
    // parameter counter_100ms = 2400000;// 100ms
    parameter counter_100ms = 300;// for test

    //syn Rot_A (A1, A2) and make pulse from falling edge(A3)
    always @(negedge Fg_CLK or RESETn) begin
        if(~RESETn) begin
            A1 <= 0;
            A2 <= 0;
            A3 <= 0;
            A_pulse <= 0;
        end
        else begin 
            A1 <= Rot_A;
            A2 <= A1;
            A3 <= A2;
            A_pulse <= (~A2 & A3);
        end
    end 

    //syn Rot_B (B1, B2) and make pulse from falling edge(B3)
    always @(negedge Fg_CLK or RESETn) begin
        if(~RESETn) begin
            B1 <= 0;
            B2 <= 0;
            B3 <= 0;
            B_pulse <= 0;
        end
        else begin 
            B1 <= Rot_B;
            B2 <= B1;
            B3 <= B2;
            B_pulse <= (~B2 & B3);
        end
    end 
    

    always @(posedge Fg_CLK or negedge RESETn) begin
        if(~RESETn) begin
            state <= 0;
            count <= 0;
            step_exp <= 0;
        end
        else begin
            case (state)
                -1 : begin //minus
                    count <= count - 10**step_exp;
                    if (count <= 0) count <= 0;// case count less 0
                    if (B_pulse) state <= 0;
                end
                0 : begin //idle
                    if (A_pulse) state <= -1;
                    if (B_pulse) state <= 1;
                end

                1 : begin //plus
                    count <= count + 10**step_exp;
                    if (count >= 1800) count <= 1800;// case count more than 1800
                    if (A_pulse) state <= 0;
                end
                default : state <= 0;
            endcase
        end
    end

    // button Rot_C
    always @(posedge Fg_CLK or negedge RESETn) begin
        if(~RESETn) step <= 0;
        else if(Rot_C) begin 
            step <= step + 1;
            if(step < 2) step <= 2;
        end
    end
    
    // make pulse every 100 ms
    always @(posedge Fg_CLK or negedge RESETn) begin
        if(~RESETn) begin 
            counter <= 0;
            counter_pulse <= 0;

        end
        else begin
            counter <= counter + 1; 
            if      (counter == counter_100ms -1)   counter_pulse <= 1;
            else if (counter < counter_100ms)       counter <= 0;
            else                                    counter_pulse <= 0;
            
        end
    end

    // output Address every 100 ms
    always @(posedge Fg_CLK or negedge RESETn) begin
        if      (~RESETn)       Address <= 0; 
        else if (counter_pulse) Address <= count;
    end

    // if output Adddress have change ,then this block generate pulse
    always @(posedge Fg_CLK or negedge RESETn) begin
        if(~RESETn)                                     FreqChng <= 0;
        else if ((Address != count) & counter_pulse )   FreqChng <= 1;
        else                                            FreqChng <= 0;
    end
endmodule
