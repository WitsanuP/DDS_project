module rotary(Fg_CLK, RESETn, Rot_A, Rot_B, Rot_C, Address, FreqChng);
    input Fg_CLK;
    input RESETn;
    input Rot_A;
    input Rot_B;
    input Rot_C;

    output reg [10:0] Address; // 0-1800
    output reg FreqChng;

    reg [11:0] count; // 0-1800 [10:0]can over flow, 0-100 =-99 
    reg [1:0] step_exp; // 0->1, 1->10, 2->100
    reg [1:0] state; //  minus, idle, plus

    reg A1;
    reg A2;
    reg A3;
    reg A_pulse;
    reg B1;
    reg B2;
    reg B3;
    reg B_pulse;
    reg [21:0] counter;
    reg counter_pulse;
    `ifdef TEST_MODE parameter counter_100ms = 3000;// for test
    `else            parameter counter_100ms = 2400000;// 100ms
    `endif 

    //syn Rot_A (A1, A2) and make pulse from falling edge(A3)
    always @(posedge Fg_CLK or negedge RESETn) begin
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
    always @(posedge Fg_CLK or negedge RESETn) begin
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
            state <= 2'b00;
            count <= 0;
        end
        else begin
            case (state)
                2'b10 : begin //minus
                    if (B_pulse) begin 
                        state <= 2'b00;
                        // count <= count - 10**step_exp;
                        // if ($signed(count) <= 0) count <= 0;// case count less than 0
                        if ($signed(count - 10**step_exp) >= 0) count <= count - 10**step_exp;
                        else                                    count <= 0;
                    end
                end

                2'b00 : begin //idle
                    if (A_pulse) state <= 2'b10;
                    if (B_pulse) state <= 2'b01;
                end

                2'b01 : begin //plus
                    if (A_pulse) begin 
                        state <= 2'b00;
                        // count <= count + 10**step_exp;
                        if (count + 10**step_exp <= 1800) count <= count + 10**step_exp;
                        else count <= 1800;// case count more than 1800
                    end
                end
                default : state <= 2'b00;
            endcase
        end
    end

    // button Rot_C
    always @(posedge Fg_CLK or negedge RESETn) begin
        if(~RESETn) step_exp <= 0;
        else if(Rot_C) begin 
            if(step_exp < 2) step_exp <= step_exp + 1;
            else step_exp <= 0;
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
            else if (counter >= counter_100ms) begin
                counter <= 0;
                counter_pulse <= 0; 
            end
        end
    end

    // output Address every 100 ms
    always @(posedge Fg_CLK or negedge RESETn) begin
        if      (~RESETn)       Address <= 0; 
        else if (counter_pulse) Address <= count[10:0];
    end

    // if output Adddress have change ,then this block generate pulse
    always @(posedge Fg_CLK or negedge RESETn) begin
        if(~RESETn)                                     FreqChng <= 0;
        else if ((Address != count[10:0]) & counter_pulse )   FreqChng <= 1;
        else                                            FreqChng <= 0;
    end
endmodule