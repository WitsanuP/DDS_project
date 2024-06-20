module clk_divider(PLL_CLK,RESETn,Fg_CLK,Dac_CLK);
    input PLL_CLK;
    input RESETn; //active_low
    output reg Fg_CLK;
    output reg Dac_CLK;


always @(posedge PLL_CLK) begin
    if(~RESETn)
        Fg_CLK = 0;
    else
        Fg_CLK = ~Fg_CLK;
end

always @(negedge PLL_CLK) begin
    if(~RESETn)
        Dac_CLK = 0;
    else
        Dac_CLK = ~Dac_CLK;
end
endmodule