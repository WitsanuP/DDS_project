module sampling_control(Fg_CLK,RESETn,IntBTN,Ready,Enable,Mode);
    input Fg_CLK;
    input RESETn;
    input IntBTN;

    output Ready;
    output reg Enable;
    output reg [3:0] Mode; // 5 mode (0-4)

    reg [14:0] counter_Enable;
    reg [6:0] counter_Ready;
    reg reg_pulse;// pulse in

    //----- counter mode --------
    always @(posedge Fg_CLK or negedge RESETn)begin 
        if(~RESETn)begin
            Mode <= 0;
        end
        else if (reg_pulse && Enable)begin
            if(Mode < 4 )begin
                Mode <= Mode +1;
            end
            else begin
                Mode <= 0;
            end
            reg_pulse <= 0;
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

            if(counter_Enable >= 10**Mode-1) begin
                Enable <= 1;
                counter_Enable <= 0;
            end
            else begin
                Enable <= 0;
            end
        end
    end

    //------------- counter ready ------------
    always @(posedge Fg_CLK or negedge RESETn)begin
        if(~RESETn)begin
            counter_Ready <= 0;
        end
        else if (counter_Ready < 80) begin
            counter_Ready <= counter_Ready + 1;
        end
    end

    //------------- reg_pulse ------------
    always @(posedge Fg_CLK or negedge RESETn)begin
        if(~RESETn)begin
            reg_pulse <= 0;
        end
        else if (IntBTN) begin
            reg_pulse <=1;
        end
        
    end
endmodule