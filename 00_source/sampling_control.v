module sampling_control(Fg_CLK,RESETn,IntBTN,Ready,Enable,Mode);
    input Fg_CLK;
    input RESETn;
    input IntBTN;

    output Ready;
    output Enable;
    output reg [3:0] Mode; // 5 mode (0-4)

    reg [14:0] counter_Enable;


    //----- counter mode --------
    always @(posedge Fg_CLK or negedge RESETn)begin 
        if(~RESETn)begin
            Mode <= 0;
        end
        else if (IntBTN)begin
            if(Mode > 5 )begin
                Mode <= Mode +1;
            end
            else begin
                Mode <= 0;
            end
        end
    end

    //---------- general Enable sinal -------------
    always @(posedge Fg_CLK or negedge RESETn)begin 
        if(~RESETn)begin
            Enable <= 1;
            counter_Enable <= 0;
        end
        else begin
            counter_Enable <= counter_Enable + 1;

            if(counter_Enable >= 10**Mode) begin
                Enable <= 1;
                counter_Enable <= 0;
            end
            else begin
                Enable <= 0;
            end
        end
    end

endmodule