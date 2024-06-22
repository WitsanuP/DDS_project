module button(Fg_CLK,RESETn,ExtBTN,IntBTN);
    input Fg_CLK;
    input RESETn;
    input  ExtBTN;
    output reg IntBTN;

    reg D1;
    reg D2;
    reg D3;
    reg [25:0] counter;
    reg enable_counter;


    parameter [25:0] time_counter_limit = 300 ; //for test
    // parameter [25:0] time_counter_limit =  2_400_000 ; //for 100 ms
    // parameter [25:0] time_counter_limit = 24_000_000 ; //for 1 sec
    
always @(posedge Fg_CLK or negedge RESETn) begin
    if(~RESETn)begin
            D1 <= 0;
            D2 <= 0;
            D3 <= 0;
    end
    else begin
        D1 <= ExtBTN;
        D2 <= D1;
        D3 <= D2;
        if(~enable_counter) IntBTN <= (~D2 & D3 &(counter == 0));
    end
end


always @(posedge Fg_CLK or negedge RESETn) begin
    if(~RESETn)begin
        counter <= 0;
    end
    else if(counter < time_counter_limit && (enable_counter == 1))begin
        counter <= counter + 1;
    end
    else begin //in case coumter >= time_counter_limit
        counter <= 0;
        enable_counter <= 0;
    end
end

always @(posedge Fg_CLK or negedge RESETn) begin
    if(~RESETn)begin
        enable_counter <= 0 ;
    end

    else if(IntBTN)begin
        enable_counter <= 1;
    end

end

endmodule